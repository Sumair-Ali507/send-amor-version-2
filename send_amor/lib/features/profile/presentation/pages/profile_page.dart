import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:money_transfer_app/common/mixins/ts.dart';
import 'package:money_transfer_app/common/widgets/IText.dart';
import 'package:money_transfer_app/common/widgets/IVerticalSpace.dart';
import 'package:money_transfer_app/core/constants/app_texts.dart';
import 'package:money_transfer_app/core/theme/app_color.dart';
import 'package:money_transfer_app/core/theme/theme_bloc/theme_bloc.dart';
import 'package:money_transfer_app/core/utils/Utils.dart';
import 'package:money_transfer_app/features/profile/presentation/bloc/bloc/profile_bloc.dart';
import '../../../authentication/data/app_user.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:share_plus/share_plus.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isEditingUserName = false;
  final TextEditingController _controller = TextEditingController();
  String userName = "";
  AppUser? appUser;
  bool isLoading = false;
  bool userNameError = false;

  @override
  void initState() {
    super.initState();
  }

  // Add these methods to your _ProfilePageState class
  Future<String> _generateBranchLink() async {
    try {
      // Create a Branch Universal Object (required even for basic links)
      BranchUniversalObject buo = BranchUniversalObject(
        canonicalIdentifier: 'app_profile_${appUser?.appUserData?.uniqueName ?? 'user'}',
        title: '${appUser?.appUserData?.name ?? 'User'} on Money Transfer App',
        contentDescription: 'Connect with me on Money Transfer App',
        contentMetadata: BranchContentMetaData()
          ..addCustomMetadata('user_id', appUser?.appUserData?.id?.toString() ?? '')
          ..addCustomMetadata('type', 'profile_share'),
      );

      // Create link properties
      BranchLinkProperties lp = BranchLinkProperties(
        channel: 'flutter',
        feature: 'sharing',
      );

      // Generate the link
      BranchResponse response = await FlutterBranchSdk.getShortUrl(
        buo: buo,
        linkProperties: lp,
      );

      return response.result;
    } catch (e) {
      print('Error generating Branch link: $e');
      return 'https://yourfallbackwebsite.com'; // Fallback URL
    }
  }

  void _shareProfile() async {
    final link = await _generateBranchLink();

    // Using share_plus package for sharing options
    await Share.share(
      'Connect with me on Money Transfer App: $link',
      subject: 'Money Transfer App Profile',
    );
  }

  fetchUserDetails() async {
    appUser = await Utility.getAppUser();
    userName = appUser?.appUserData?.uniqueName ?? '';
    // Strip symbols when entering edit mode
    String strippedName = Utility.stripSymbols(userName);
    // Set the controller text for editing
    _controller.text = strippedName;
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller to free resources
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      if (_isEditingUserName) {
        // Save the updated name
        userName = _controller.text;

        context.read<ProfileBloc>().add(UpdateUniqueNameEvent(
            context: context, appUser: appUser!, uniqueName: userName));
      }
      _isEditingUserName = !_isEditingUserName; // Toggle the edit state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) async {
          if (state is UpdateUniqueNameInProgress) {
            setState(() {
              isLoading = true;
            });
          } else if (state is UpdateUniqueNameSuccess) {
            appUser = state.appUser;

            if (appUser?.success == false) {
              userNameError = true;
            } else {
              userNameError = false;
              AppUser? existingUserData = await Utility.getAppUser();
              if (appUser != null) {
                existingUserData = existingUserData?.copyWith(
                    appUserData: appUser?.appUserData);
                Utility.saveAppUser(existingUserData!);
              }
            }

            setState(() {
              isLoading = false;
            });
          } else if (state is UpdateUniqueNameFailure) {
            setState(() {
              isLoading = false;
            });
          }
        },
        child: SafeArea(
          child: FocusDetector(
            onFocusGained: () {
              fetchUserDetails();
            },
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IVerticalSpace(),
                buildUserImageView(),
                IVerticalSpace(
                  height: 2,
                ),
                buildNameView(),
                IVerticalSpace(),
                buildUserNameView(),
                userNameError ? buildErrorView() : const SizedBox(),
                IVerticalSpace(
                  height: 3,
                ),
                buildQuickActionView()
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildUserImageView() {
    return const CircleAvatar(
      radius: 24, // Adjust the size of the avatar
      backgroundColor:
          Color(AppColor.primaryColor), // Background color of the avatar
      child: Icon(
        Icons.person, // Person icon
        size: 20, // Icon size
        color: Colors.white, // Icon color
      ),
    );
  }

  buildNameView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IText(
          content: appUser?.appUserData?.name?.toUpperCase() ?? '',
          textStyle: Ts.mediumStyle(
            context: context,
          ),
        ),
        IText(
          content: ' Senior Consultant',
          textStyle: Ts.normalStyle(
              context: context,
              textColor: const Color(AppColor.lightBlack),
              size: 14.0,
              height: 0.7),
        ),
      ],
    );
  }

  buildUserNameView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Name/TextField
        _isEditingUserName
            ? Expanded(
                child: TextField(
                  controller: _controller,
                  canRequestFocus: true,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                  ),
                  onChanged: (text) {
                    setState(() {
                      userName = text; // Update live preview (optional)
                    });
                  },
                ),
              )
            : Text(
                userName.isEmpty
                    ? 'set username'
                    : Utility.decodeString(userName),
                style: userName.isEmpty
                    ? Ts.normalStyle(
                        context: context,
                        size: 14.0,
                        textColor: const Color(AppColor.lightBlack),
                      )
                    : Ts.normalStyle(context: context, size: 17.0),
              ),
        const SizedBox(width: 8),
        // Edit/Save Icon
        IconButton(
          icon: isLoading
              ? const CircularProgressIndicator(
                  color: Color(AppColor.primaryColor),
                )
              : Icon(_isEditingUserName ? Icons.check : Icons.edit),
          onPressed: () {
            if (_isEditingUserName) {
              // Append symbols when saving
              String text = _controller.text.trim();
              if (!text.startsWith('❤️')) {
                text = '$text❤️';
              }
              if (!text.endsWith('\$')) {
                text = '$text \$';
              }

              setState(() {
                userName = text; // Save the username
                _controller.text = userName; // Sync controller
              });
            } else {
              String strippedName = Utility.stripSymbols(
                Utility.decodeString(userName),
              ); // Decode before stripping symbols

              // Set the controller text for editing
              _controller.text = strippedName;
            }
            setState(() {});

            _toggleEdit(); // Toggle edit mode
          },
        ),
      ],
    );
  }

  buildErrorView() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.close_rounded, color: Colors.red, size: 16),
        SizedBox(width: 4),
        Text(
          AppTexts.userNameAlreadyTaken,
          style: TextStyle(color: Colors.red, fontSize: 12),
        ),
      ],
    );
  }

  buildQuickActionView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(AppColor.primaryColor),
              boxShadow: [Utility.lightShadow()]),
          child: const Center(
            child: Icon(
              Icons.qr_code,
              color: Color(AppColor.white),
            ),
          ),
        ),
        Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(AppColor.primaryColor),
              boxShadow: [Utility.lightShadow()]),
          child:  Center(
            child: IconButton(
              onPressed: _shareProfile,
              icon: const Icon(
                Icons.share,
                color: Color(AppColor.white),
              ),
              color: Color(AppColor.white),
            ),
          ),
        ),
        Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(AppColor.primaryColor),
              boxShadow: [Utility.lightShadow()]),
          child: const Center(
            child: Icon(
              Icons.transfer_within_a_station,
              color: Color(AppColor.white),
            ),
          ),
        ),
        Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(AppColor.primaryColor),
              boxShadow: [Utility.lightShadow()]),
          child: const Center(
            child: Icon(
              Icons.monetization_on,
              color: Color(AppColor.white),
            ),
          ),
        ),
      ],
    );
  }
}
