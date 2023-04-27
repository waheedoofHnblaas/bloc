part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {}

class GetThemeEvent extends ThemeEvent {}

class ChangeThemeEvent extends ThemeEvent {
  final AppTheme appTheme;

  ChangeThemeEvent(this.appTheme);
}

