import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_transfer_app/common/mixins/ts.dart';
import 'package:money_transfer_app/common/widgets/IRichText.dart';
import 'package:money_transfer_app/common/widgets/IText.dart';
import 'package:money_transfer_app/common/widgets/IVerticalSpace.dart';
import 'package:money_transfer_app/core/constants/app_images.dart';
import 'package:money_transfer_app/core/constants/app_texts.dart';
import 'package:money_transfer_app/core/utils/Utils.dart';
import 'package:money_transfer_app/features/authentication/data/app_user.dart';
import 'package:money_transfer_app/features/recipient/domain/recipients_repository.dart';
import 'package:money_transfer_app/features/recipient/presentation/bloc/accepted_connections_bloc.dart';
import 'package:money_transfer_app/features/recipient/presentation/bloc/accepted_connections_event.dart';
import 'package:money_transfer_app/features/recipient/presentation/bloc/pending_connections_bloc.dart';
import 'package:money_transfer_app/features/recipient/presentation/bloc/search_user_bloc.dart';
import 'package:money_transfer_app/features/recipient/presentation/bloc/send_connections_bloc.dart';
import 'package:money_transfer_app/features/recipient/presentation/pages/recipient_listing_page.dart';
import 'package:money_transfer_app/features/send_money/presentation/pages/send_money_page.dart';
import 'package:money_transfer_app/features/settings/presentation/pages/setting_page.dart';
import '../../../../common/widgets/IconTextWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppUser? appUser;

  @override
  void initState() {
    super.initState();
    _fetchAppUser();
  }

  Future<void> _fetchAppUser() async {
    appUser = await Utility.getAppUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return const SettingPage();
                      }),
                    );
                  },
                  icon: Icon(
                    Icons.settings,
                    color: theme.colorScheme.primary,
                  )),
            ),
            IVerticalSpace(),
            buildBalanceView(),
            IVerticalSpace(
              height: 5,
            ),
            buildAddRecipientView(),
            const Spacer(),
            SizedBox(
                width: 200,
                height: 200,
                child: Image.asset(AppImages().dummyQRPng)),
            IVerticalSpace(
              height: 2,
            ),
            IText(
              content: AppTexts.scanMyQrCode,
              textStyle: Ts.mediumStyle(
                  context: context,
                  textColor: theme.colorScheme.primary,
                  size: 18.0),
            ),
            const Spacer(),

          ],
        ),
      ),
    );
  }

  buildBalanceView() {
    return const IRichText(
      title: 'Balance:',
      subTitle: '00.00(USD)',
    );
  }

  buildAddRecipientView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconTextWidget(
            title: AppTexts.addRecipient,
            icon: Icon(
              Icons.add_circle,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create: (context) => SearchUserBloc(
                                recipientsRepository: RecipientsRepository(),
                              ),
                            ),
                            BlocProvider<PendingConnectionsBloc>(
                              create: (context) => PendingConnectionsBloc(
                                  recipientsRepository: RecipientsRepository()),
                            ),
                            BlocProvider(
                              create: (context) => AcceptedConnectionsBloc(
                                recipientsRepository: RecipientsRepository(),
                              )..add(FetchAcceptedConnections(
                                  appUser: appUser!,
                                  context: context,
                                )),
                            ),
                            BlocProvider(
                              create: (context) => SendConnectionBloc(
                                recipientsRepository: RecipientsRepository(),
                              ),
                            ),
                          ],
                          child: const RecipientListingPage(),
                        )),
              );
            },
          ),
          IconTextWidget(
            title: AppTexts.sendMoney,
            icon: Icon(
              Icons.money,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SendMoneyPage()),
              );
            },
          )
        ],
      ),
    );
  }
}
