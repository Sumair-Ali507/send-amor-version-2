import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_transfer_app/common/widgets/IAppButton.dart';
import 'package:money_transfer_app/core/theme/app_color.dart';
import 'package:money_transfer_app/core/theme/theme_bloc/theme_bloc.dart';
import 'package:money_transfer_app/core/utils/Utils.dart';
import 'package:money_transfer_app/features/authentication/data/app_user.dart';
import 'package:money_transfer_app/features/recipient/data/payload/received_pending_connections_model.dart';
import 'package:money_transfer_app/features/recipient/presentation/bloc/send_connections_bloc.dart';

class ReceivedRequestListTile extends StatefulWidget {
  final AppUser? appUser;
  final ConnectionContent? request;
  const ReceivedRequestListTile(
      {super.key, required this.request, required this.appUser});

  @override
  _ReceivedRequestListTileState createState() =>
      _ReceivedRequestListTileState();
}

class _ReceivedRequestListTileState extends State<ReceivedRequestListTile> {
  ReceivedPendingConnectionListModel? requestsList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: const Color(AppColor.white),
          boxShadow: [Utility.lightShadow()],
        ),
        child: Column(
          children: [
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(AppColor.primaryColor),
                child: Icon(
                  Icons.person,
                  color: Color(AppColor.white),
                ),
              ),
              title: Text(
                widget.request?.sender?.name.toString() ?? '',
                style: GoogleFonts.nunitoSans(),
              ),
              subtitle: Text(
                Utility.decodeString(
                    widget.request?.sender?.uniqueName.toString() ?? ''),
                style: GoogleFonts.nunitoSans(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IAppButton(
                  height: 30,
                  width: 80,
                  text: 'Reject',
                  textStyle: GoogleFonts.nunitoSans(
                      color: const Color(AppColor.white)),
                  backgroundColor: const Color(AppColor.deepOrange),
                  textColor: const Color(AppColor.white),
                  onTap: () {},
                ),
                const SizedBox(width: 8),
                IAppButton(
                  height: 30,
                  width: 80,
                  text: 'Accept',
                  textStyle: GoogleFonts.nunitoSans(
                      color: const Color(AppColor.white)),
                  backgroundColor: const Color(AppColor.primaryColor),
                  textColor: const Color(AppColor.white),
                  onTap: () {
                    context.read<SendConnectionBloc>().add(
                        UpdateConnectionStatusEvent(
                            appUser: widget.appUser!,
                            context: context,
                            connectionId: widget.request?.id ?? -1,
                            status: 'ACCEPTED'));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
