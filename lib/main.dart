import 'package:bloc_app/besniees_logic/bloc/internet_bloc.dart';
import 'package:bloc_app/besniees_logic/cubit/card/card_cubit.dart';
import 'package:bloc_app/besniees_logic/cubit/items_cubit.dart';
import 'package:get/get.dart';
import 'package:bloc_app/core/colors.dart';
import 'package:bloc_app/data/repos/items_repos.dart';
import 'package:bloc_app/data/services/item_services.dart';
import 'package:bloc_app/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetBloc>(
          create: (context) => InternetBloc(),
        ),
        RepositoryProvider<CardCubit>(
          create: (context) => CardCubit(),
        ),
        RepositoryProvider<ItemsCubit>(
          create: (context) => ItemsCubit(ItemRepo(ItemServices())),
        )
      ],
      child: GetMaterialApp(
        theme: ThemeData(
          fontFamily: 'Cairo',
          progressIndicatorTheme: const ProgressIndicatorThemeData(
              color: AppColors.myWhite, linearTrackColor: AppColors.myRed),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: AppColors.myRed,
          ),
          scaffoldBackgroundColor: AppColors.myTextColor,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: AppColors.myRed,
          ),
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter().generateRout,
      ),
    );
  }
}
