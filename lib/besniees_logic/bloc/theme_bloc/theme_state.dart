part of 'theme_bloc.dart';

@immutable
abstract class ThemeState {}

class ThemeInitial extends ThemeState {}
class LoadThemeState extends ThemeInitial {
  final ThemeData themeData;

  LoadThemeState({required this.themeData});
}

