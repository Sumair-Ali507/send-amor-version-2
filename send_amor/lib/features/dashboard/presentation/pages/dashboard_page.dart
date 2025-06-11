import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_transfer_app/core/constants/app_texts.dart';
import 'package:money_transfer_app/core/theme/app_color.dart';
import 'package:money_transfer_app/features/authentication/data/app_user.dart';
import 'package:money_transfer_app/features/bankAccount/presentation/pages/bank_account_main_page.dart';
import 'package:money_transfer_app/features/cards/presentation/pages/card_page.dart';
import 'package:money_transfer_app/features/dashboard/presentation/pages/home_page.dart';
import 'package:money_transfer_app/features/profile/domain/profile_repository.dart';
import 'package:money_transfer_app/features/profile/presentation/bloc/bloc/profile_bloc.dart';
import 'package:money_transfer_app/features/profile/presentation/pages/profile_page.dart';
import 'package:money_transfer_app/features/recipient/presentation/pages/contacts_from_phone.dart';

import '../../../../core/utils/Utils.dart';
import '../../../history/presentation/pages/history_page.dart';


class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0; // Track the current selected tab index
  late PageController _pageController; // To handle page transitions
  AppUser? appUser;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    loadExistingDetails();
  }

  loadExistingDetails() async {
    appUser = await Utility.getAppUser();
    loadLatestUserDetails();
  }

  loadLatestUserDetails() async {
    context
        .read<ProfileBloc>()
        .add(FetchUserDetailsEvent(context: context, appUser: appUser!));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is FetchUserDetailInProgress) {
            setState(() {
              isLoading = true;
            });
          } else if (state is FetchUserDetailSuccess) {
            appUser = state.appUser;

            if (appUser != null) {
              Utility.saveAppUser(appUser!);
            }



            setState(() {
              isLoading = false;
            });
          } else if (state is FetchUserDetailFailure) {
            setState(() {
              isLoading = false;
            });
          }
        },
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: [
            const HomePage(),
            const CardPage(),
            const HistoryPage(),
            const BankAccountMainPage(),
            BlocProvider(
              create: (context) =>
                  ProfileBloc(profileRepository: ProfileRepository()),
              child: const ProfilePage(),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(AppColor.primaryColor),
          boxShadow: [Utility.lightShadow()],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            });
          },
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          // selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          // unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: AppTexts.home,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.credit_card_outlined),
              label: AppTexts.card,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: AppTexts.history,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_sharp),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_sharp),
              label: AppTexts.profile,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Profile Screen",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Settings Screen",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
