import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_transfer_app/core/constants/app_texts.dart';
import 'package:money_transfer_app/core/utils/Utils.dart';
import 'package:money_transfer_app/features/authentication/data/app_user.dart';
import 'package:money_transfer_app/features/recipient/data/payload/pending_connections_model.dart';
import 'package:money_transfer_app/features/recipient/data/payload/search_user.dart';
import 'package:money_transfer_app/features/recipient/domain/recipients_repository.dart';
import 'package:money_transfer_app/features/recipient/presentation/bloc/accepted_connections_bloc.dart';
import 'package:money_transfer_app/features/recipient/presentation/bloc/accepted_connections_event.dart';
import 'package:money_transfer_app/features/recipient/presentation/bloc/accepted_connections_state.dart';
import 'package:money_transfer_app/features/recipient/presentation/bloc/pending_connections_bloc.dart';
import 'package:money_transfer_app/features/recipient/presentation/bloc/pending_connections_event.dart';
import 'package:money_transfer_app/features/recipient/presentation/bloc/pending_connections_state.dart';
import 'package:money_transfer_app/features/recipient/presentation/bloc/received_pending_connections_bloc.dart';
import 'package:money_transfer_app/features/recipient/presentation/bloc/received_pending_connections_event.dart';
import 'package:money_transfer_app/features/recipient/presentation/bloc/send_connections_bloc.dart';
import 'package:money_transfer_app/features/recipient/presentation/pages/request_recieved_list_page.dart';
import 'package:money_transfer_app/features/recipient/presentation/widgets/recipient_list_tile.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../core/theme/app_color.dart';
import '../bloc/search_user_bloc.dart';

class RecipientListingPage extends StatefulWidget {
  const RecipientListingPage({super.key});

  @override
  State<RecipientListingPage> createState() => _RecipientListingPageState();
}

class _RecipientListingPageState extends State<RecipientListingPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  List<SearchList> _suggestions = [];
  final List<PendingRecipientList> _pendingRecipients = [];
  final List<PendingRecipientList> _acceptedRecipients = [];
  AppUser? appUser;
  int _selectedSegment = 0;
  bool _isLoadingPending = true;
  bool _isLoadingAccepted = true;
  bool _hasErrorPending = false;
  bool _hasErrorAccepted = false;
  bool _isSearching = false;

  // Contacts related state
  List<Contact> _contacts = [];
  List<Contact> _filteredContacts = [];
  bool _isLoadingContacts = true;
  bool _contactsPermissionDenied = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _searchController.addListener(_onSearchChanged);
    _fetchAppUser();
    _fetchContacts();
  }

  Future<void> _fetchAppUser() async {
    appUser = await Utility.getAppUser();
    if (appUser != null) {
      context.read<AcceptedConnectionsBloc>().add(FetchAcceptedConnections(
          appUser: appUser!, context: context, page: 0, size: 10));
    }
    setState(() {});
  }

  void _sendConnection(SearchList recipient) {
    if (appUser != null) {
      context.read<SendConnectionBloc>().add(SendConnectionRequested(
          appUser: appUser!,
          context: context,
          receiverId: recipient.id.toString()));
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _fetchContacts() async {
    if (!mounted) return;

    setState(() {
      _isLoadingContacts = true;
      _contactsPermissionDenied = false;
    });

    if (await Permission.contacts.isGranted) {
      try {
        _contacts = await FlutterContacts.getContacts(
            withProperties: true, withPhoto: true);
        _filteredContacts = _contacts;
      } catch (e) {
        print('Error fetching contacts: $e');
      }
    } else {
      final status = await Permission.contacts.request();
      if (status.isGranted) {
        _contacts = await FlutterContacts.getContacts(
            withProperties: true, withPhoto: true);
        _filteredContacts = _contacts;
      } else {
        _contactsPermissionDenied = true;
      }
    }

    if (!mounted) return;
    setState(() {
      _isLoadingContacts = false;
    });
  }

  void _onSearchChanged() {
    _debounce?.cancel();

    final query = _searchController.text.trim();

    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _suggestions.clear();
        _filteredContacts = _contacts;
      });
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (!mounted) return;

      setState(() {
        _isSearching = true;
      });

      if (_selectedSegment == 0) {
        final isNumberSearch = RegExp(r'^[0-9]+$').hasMatch(query);

        setState(() {
          _filteredContacts = _contacts.where((contact) {
            if (isNumberSearch) {
              return contact.phones.any((phone) {
                final normalizedPhone = phone.number.replaceAll(RegExp(r'[^0-9]'), '');
                return normalizedPhone.contains(query);
              });
            } else {
              final normalizedName = contact.displayName.toLowerCase();
              return normalizedName.contains(query.toLowerCase());
            }
          }).toList();
          _isSearching = false;
        });
      } else {
        context.read<SearchUserBloc>().add(FetchSearchUsersEvent(
          query: query,
          context: context,
          appUser: appUser!,
        ));
      }
    });
  }

  Future<bool> _onWillPop() async {
    if (_suggestions.isNotEmpty || _searchController.text.isNotEmpty) {
      setState(() {
        _suggestions.clear();
        _searchController.clear();
        _filteredContacts = _contacts;
      });
      return false;
    }
    return true;
  }

  Widget _buildAcceptedConnections() {
    if (_isLoadingAccepted && _acceptedRecipients.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    } else if (_hasErrorAccepted || _acceptedRecipients.isEmpty) {
      return Center(
        child: Text(
          'No records found',
          style: GoogleFonts.nunitoSans(),
        ),
      );
    } else {
      return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!_isLoadingAccepted &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            context.read<AcceptedConnectionsBloc>().add(
                FetchAcceptedConnections(
                    appUser: appUser!,
                    context: context,
                    page: _acceptedRecipients.length ~/ 10,
                    size: 10));
          }
          return false;
        },
        child: ListView.builder(
          itemCount: _acceptedRecipients.length + (_isLoadingAccepted ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == _acceptedRecipients.length) {
              return const Center(child: CircularProgressIndicator());
            }
            return RecipientListTile(
              name: _acceptedRecipients[index].sender?.name ?? '',
              nickName: Utility.decodeString(
                _acceptedRecipients[index].sender?.uniqueName ?? '',
              ),
              onDelete: () {},
            );
          },
        ),
      );
    }
  }

  Widget _buildPendingConnections() {
    if (_isLoadingPending && _pendingRecipients.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    } else if (_hasErrorPending || _pendingRecipients.isEmpty) {
      return Center(
        child: Text(
          'No records found',
          style: GoogleFonts.nunitoSans(),
        ),
      );
    } else {
      return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!_isLoadingPending &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            context.read<PendingConnectionsBloc>().add(FetchPendingConnections(
                appUser: appUser!,
                context: context,
                page: _pendingRecipients.length ~/ 10,
                size: 10));
          }
          return false;
        },
        child: ListView.builder(
          itemCount: _pendingRecipients.length + (_isLoadingPending ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == _pendingRecipients.length) {
              return const Center(child: CircularProgressIndicator());
            }
            return RecipientListTile(
              name: _pendingRecipients[index].sender?.name ?? '',
              nickName: Utility.decodeString(
                  _pendingRecipients[index].sender?.uniqueName ?? ''),
              trailing: Text(
                Utility.getReadableTime(
                    _pendingRecipients[index].createdAt?.toString() ?? ''),
                style: GoogleFonts.nunitoSans(
                    fontSize: 12.0, color: const Color(AppColor.black)),
              ),
              onDelete: () {},
            );
          },
        ),
      );
    }
  }

  Widget _buildContactTile(Contact contact) {
    final phoneNumber = contact.phones.isNotEmpty
        ? contact.phones.first.number
        : 'No phone number';

    return ListTile(
      leading: Container(
        height: 40,
        width: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          shape: BoxShape.circle,
        ),
        child: Text(
          contact.displayName.isNotEmpty
              ? contact.displayName[0].toUpperCase()
              : '?',
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
        contact.displayName.isNotEmpty ? contact.displayName : 'Unknown',
        style: GoogleFonts.nunitoSans(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        phoneNumber,
        style: GoogleFonts.nunitoSans(
          fontSize: 14,
          color: Colors.grey,
        ),
      ),
      trailing: _selectedSegment == 0 && _searchController.text.isNotEmpty
          ? IconButton(
        icon: const Icon(
          Icons.person_add,
          color: Color(AppColor.primaryColor),
        ),
        onPressed: () {
          // Handle adding this contact as a recipient
        },
      )
          : null,
      onTap: () {
        // Handle contact selection
      },
    );
  }

  Widget _buildPhoneContacts() {
    if (_isLoadingContacts) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_contactsPermissionDenied) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Contacts permission denied',
              style: GoogleFonts.nunitoSans(),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                await openAppSettings();
              },
              child: const Text('Open Settings'),
            ),
          ],
        ),
      );
    }

    if (_filteredContacts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.contacts_outlined,
              size: 48,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              _searchController.text.isEmpty
                  ? 'No contacts found'
                  : 'No matching contacts found',
              style: GoogleFonts.nunitoSans(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            if (_searchController.text.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'Searching for: ${_searchController.text}',
                style: GoogleFonts.nunitoSans(
                  fontSize: 14,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ],
        ),
      );
    }

    final isNameSearch = !RegExp(r'^[0-9]+$').hasMatch(_searchController.text);
    final Map<String, List<Contact>> groupedContacts = {};

    if (isNameSearch && _searchController.text.isNotEmpty) {
      for (var contact in _filteredContacts) {
        final firstLetter = contact.displayName.isNotEmpty
            ? contact.displayName[0].toUpperCase()
            : '#';
        groupedContacts.putIfAbsent(firstLetter, () => []).add(contact);
      }
    }

    return isNameSearch && _searchController.text.isNotEmpty
        ? ListView.builder(
      itemCount: groupedContacts.length,
      itemBuilder: (context, index) {
        final letter = groupedContacts.keys.elementAt(index);
        final contacts = groupedContacts[letter]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Text(
                letter,
                style: GoogleFonts.nunitoSans(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
            ),
            ...contacts.map((contact) => _buildContactTile(contact)),
          ],
        );
      },
    )
        : ListView.builder(
      itemCount: _filteredContacts.length,
      itemBuilder: (context, index) => _buildContactTile(_filteredContacts[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(
                Icons.person_add,
                color: Color(AppColor.white),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) => ReceivedPendingConnectionsBloc(
                              recipientsRepository: RecipientsRepository(),
                            )..add(FetchReceivedPendingConnections(
                              appUser: appUser!,
                              context: context,
                            )),
                          ),
                          BlocProvider(
                            create: (context) => SendConnectionBloc(
                                recipientsRepository: RecipientsRepository()),
                          ),
                        ],
                        child: const RequestReceivedListPage(),
                      ),
                    ));
              },
            ),
          ],
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<SearchUserBloc, SearchUserState>(
              listener: (context, state) {
                if (state is SearchUserSuccess) {
                  setState(() {
                    _isSearching = false;
                    _suggestions = state.searchUsersList;
                  });
                } else if (state is SearchUserLoading) {
                  setState(() {
                    _isSearching = true;
                  });
                } else {
                  setState(() {
                    _isSearching = false;
                  });
                }
              },
            ),
            BlocListener<PendingConnectionsBloc, PendingConnectionsState>(
              listener: (context, state) {
                if (state is PendingConnectionsLoading) {
                  setState(() {
                    _isLoadingPending = true;
                    _hasErrorPending = false;
                  });
                } else if (state is PendingConnectionsLoaded) {
                  setState(() {
                    _isLoadingPending = false;
                    _hasErrorPending = false;
                    _pendingRecipients
                        .addAll(state.pendingConnections?.content ?? []);
                  });
                } else if (state is PendingConnectionsError) {
                  setState(() {
                    _isLoadingPending = false;
                    _hasErrorPending = true;
                  });
                }
              },
            ),
            BlocListener<AcceptedConnectionsBloc, AcceptedConnectionsState>(
              listener: (context, state) {
                if (state is AcceptedConnectionsLoading) {
                  setState(() {
                    _isLoadingAccepted = true;
                    _hasErrorAccepted = false;
                  });
                } else if (state is AcceptedConnectionsLoaded) {
                  setState(() {
                    _isLoadingAccepted = false;
                    _hasErrorAccepted = false;
                    _pendingRecipients
                        .addAll(state.acceptedConnections?.content ?? []);
                  });
                } else if (state is AcceptedConnectionsError) {
                  setState(() {
                    _isLoadingAccepted = false;
                    _hasErrorAccepted = true;
                  });
                }
              },
            ),
            BlocListener<SendConnectionBloc, SendConnectionState>(
              listener: (context, state) {
                if (state is SendConnectionLoading) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.orange,
                    content: Text(
                      AppTexts.sendingRequest,
                      style: GoogleFonts.nunitoSans(
                        color: const Color(AppColor.white),
                      ),
                    ),
                  ));
                } else if (state is SendConnectionSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      content: Text(AppTexts.sendingRequestSucces,
                          style: GoogleFonts.nunitoSans(
                            color: const Color(AppColor.white),
                          )),
                    ),
                  );
                  setState(() {
                    _suggestions.clear();
                    _searchController.clear();
                  });
                } else if (state is SendConnectionFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: const Color(AppColor.red),
                      content: Text(
                        '${AppTexts.sendingRequestFailed}: ${state.error}',
                        style: GoogleFonts.nunitoSans(
                          color: const Color(AppColor.white),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 10.0),
                      TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Color(AppColor.primaryColor)),
                          ),
                          hintText: 'Search recipients here....',
                          hintStyle: GoogleFonts.nunitoSans(
                            color: const Color(AppColor.buttonBorderDark),
                          ),
                          suffixIcon: SizedBox(
                            height: 55,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor:
                                const Color(AppColor.primaryColor),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(4.0),
                                    bottomRight: Radius.circular(4.0),
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: const Icon(
                                Icons.search,
                                size: 25,
                                color: Color(AppColor.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      CupertinoSegmentedControl<int>(
                        padding: const EdgeInsets.all(10.0),
                        children: {
                          0: Text(
                            "          My Contacts           ",
                            style: GoogleFonts.nunitoSans(fontSize: 14.0),
                          ),
                          1: Text(
                            "          Request Sent          ",
                            style: GoogleFonts.nunitoSans(fontSize: 14.0),
                          ),
                        },
                        onValueChanged: (int value) {
                          setState(() {
                            _selectedSegment = value;
                            if (_selectedSegment == 1) {
                              context.read<PendingConnectionsBloc>().add(
                                  FetchPendingConnections(
                                      appUser: appUser!,
                                      context: context,
                                      page: 0,
                                      size: 10));
                            }
                          });
                        },
                        groupValue: _selectedSegment,
                      ),
                      Expanded(
                        child: _isSearching && _selectedSegment == 0
                            ? const Center(child: CircularProgressIndicator())
                            : _selectedSegment == 0
                            ? _buildPhoneContacts()
                            : _buildPendingConnections(),
                      ),
                    ],
                  ),
                  if (_isSearching && _selectedSegment != 0)
                    const Center(child: CircularProgressIndicator()),
                  if (_suggestions.isNotEmpty && _selectedSegment != 0)
                    Positioned(
                      top: 80.0,
                      left: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(AppColor.white),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5.0,
                                spreadRadius: 1.0,
                              ),
                            ],
                          ),
                          height: size.height / 2 - 80.0,
                          child: ListView.builder(
                            itemCount: _suggestions.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: const CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Color(AppColor.primaryColor),
                                  child: Icon(
                                    Icons.person,
                                    size: 20,
                                    color: Color(AppColor.white),
                                  ),
                                ),
                                title: Text(_suggestions[index].name!),
                                subtitle: Text(Utility.decodeString(
                                    _suggestions[index].uniqueName!)),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.person_add,
                                    color: Color(AppColor.primaryColor),
                                  ),
                                  onPressed: () =>
                                      _sendConnection(_suggestions[index]),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}