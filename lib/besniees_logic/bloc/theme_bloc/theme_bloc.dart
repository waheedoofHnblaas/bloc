import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_app/core/themeHelper.dart';
import 'package:bloc_app/core/thems.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial()) {
    on<ThemeEvent>((event, emit) async {
      if (event is GetThemeEvent) {
        int themeIndex = await ThemeHelper().getThemeIndex();
        final ThemeData theme = appTheme[AppTheme.values[themeIndex]]!;
        print('=============theme');
        print(theme);
        emit(LoadThemeState(themeData: theme));
      } else if (event is ChangeThemeEvent) {
        ThemeHelper().saveThemeIndex(event.appTheme.index);
        int themeIndex = await ThemeHelper().getThemeIndex();
        final ThemeData theme = appTheme[AppTheme.values[themeIndex]]!;
        emit(LoadThemeState(themeData: theme));
      }
    });
  }
}
