import 'package:flutter_bloc/flutter_bloc.dart';
import '../app_theme.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(AppTheme.lightTheme)) {
    on<ToggleThemeEvent>((event, emit) {
      // Toggle between light and dark themes
      if (state.themeData == AppTheme.lightTheme) {
        emit(ThemeState(AppTheme.darkTheme));
      } else {
        emit(ThemeState(AppTheme.lightTheme));
      }
    });
  }
}
