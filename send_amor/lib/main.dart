import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_transfer_app/core/utils/Utils.dart';
import 'package:money_transfer_app/features/authentication/data/app_user.dart';
import 'package:money_transfer_app/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:money_transfer_app/features/profile/domain/profile_repository.dart';
import 'package:money_transfer_app/features/profile/presentation/bloc/bloc/profile_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/theme/theme_bloc/theme_bloc.dart';
import 'core/theme/theme_bloc/theme_state.dart';
import 'features/authentication/presentation/pages/welcome_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterBranchSdk.init(enableLogging: true, branchAttributionLevel: BranchAttributionLevel.FULL);



  runApp(
    // Wrap the entire app with BlocProvider
    BlocProvider<ThemeBloc>(
      create: (context) => ThemeBloc(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget _initialScreen = const CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
    _checkUserLoginStatus();
  }

  // Method to check SharedPreferences for user data
  Future<void> _checkUserLoginStatus() async {
    AppUser? appUser = await Utility.getAppUser();
    if (appUser != null) {
      // User is logged in, navigate to Dashboard
      _initialScreen = BlocProvider(
        create: (context) =>
            ProfileBloc(profileRepository: ProfileRepository()),
        child: const DashboardPage(),
      );
    } else {
      _initialScreen = const WelcomeScreen();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return ScreenUtilInit(
          builder: ((context,child) => MaterialApp(
            theme: themeState.themeData,
            debugShowCheckedModeBanner: false,
            home: _initialScreen,
          )),
        );
      },
    );
  }
}
