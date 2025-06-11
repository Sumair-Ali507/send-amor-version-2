import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_transfer_app/core/theme/app_color.dart';
import 'package:money_transfer_app/core/utils/Utils.dart';
import 'package:money_transfer_app/features/authentication/data/app_user.dart';
import 'package:money_transfer_app/features/recipient/presentation/bloc/received_pending_connections_bloc.dart';
import 'package:money_transfer_app/features/recipient/presentation/bloc/received_pending_connections_event.dart';
import 'package:money_transfer_app/features/recipient/presentation/bloc/received_pending_connections_state.dart';
import 'package:money_transfer_app/features/recipient/presentation/widgets/received_request_list_tile.dart';
import '../../data/payload/received_pending_connections_model.dart';

class RequestReceivedListPage extends StatefulWidget {
  const RequestReceivedListPage({super.key});

  @override
  State<RequestReceivedListPage> createState() =>
      _RequestReceivedListPageState();
}

class _RequestReceivedListPageState extends State<RequestReceivedListPage> {
  final ScrollController _scrollController = ScrollController();
  AppUser? appUser;
  ReceivedPendingConnectionListModel? requestsList;
  bool _hasError = false;
  bool _isLoadingMore = false;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _fetchAppUser();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoadingMore) {
      setState(() {
        _isLoadingMore = true;
      });
      context
          .read<ReceivedPendingConnectionsBloc>()
          .add(FetchReceivedPendingConnections(
            appUser: appUser!,
            context: context,
            page: _currentPage + 1,
            size: 10,
          ));
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchAppUser() async {
    appUser = await Utility.getAppUser();
    if (appUser != null) {
      context.read<ReceivedPendingConnectionsBloc>().add(
            FetchReceivedPendingConnections(
              appUser: appUser!,
              context: context,
              page: 0,
              size: 10,
            ),
          );
    } else {
      setState(() {
        _hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Requests Received',
          style: GoogleFonts.nunitoSans(color: const Color(AppColor.white)),
        ),
      ),
      body: BlocListener<ReceivedPendingConnectionsBloc,
          ReceivedPendingConnectionsState>(
        listener: (context, state) {
          if (state is ReceivedPendingConnectionsLoaded) {
            setState(() {
              requestsList = state.receivedPendingConnections;
                _hasError = false;
              _isLoadingMore = false;
              _currentPage++;
            });
            if (state.receivedPendingConnections?.content != null &&
                state.receivedPendingConnections!.content!.isNotEmpty) {
            } else {
              setState(() {
                _hasError = true;
              });
            }
          } else if (state is ReceivedPendingConnectionsError) {
            setState(() {
              _hasError = true;
            });
          } else if (state is ReceivedPendingConnectionsLoading) {
            setState(() {});
          }
        },
        child: (requestsList?.content?.isEmpty ?? false) && !_hasError
            ? const Center(child: CircularProgressIndicator())
            : (requestsList?.content?.isEmpty ?? false) && _hasError
                ? Center(
                    child: Text(
                      'No records found',
                      style: GoogleFonts.nunitoSans(),
                    ),
                  )
                : ListView.builder(
                    itemCount: (requestsList?.content?.length ?? 0) +
                        (_isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      return ReceivedRequestListTile(
                        request: requestsList?.content?[index],
                        appUser: appUser,
                      );
                    },
                  ),
      ),
    );
  }
}
