import 'package:bloc_app/besniees_logic/bloc/theme_bloc/theme_bloc.dart';
import 'package:bloc_app/core/thems.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: List.generate(
          AppTheme.values.length,
          (index) => InkWell(
            onTap: () {
              BlocProvider.of<ThemeBloc>(context).add(
                ChangeThemeEvent(AppTheme.values.toList()[index]),
              );
            },
            child: SizedBox(
              width: Get.width,
              height: Get.height / 4,
              child: Card(
                color: appTheme.values.toList()[index].scaffoldBackgroundColor,
                child: Center(
                  child: Text(
                    AppTheme.values.toList()[index].name,
                    style: TextStyle(
                      color: appTheme.values.toList()[index].primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
