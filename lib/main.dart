import 'package:bloc_app/besniees_logic/bloc/internet_bloc/internet_bloc.dart';
import 'package:bloc_app/besniees_logic/cubit/card/card_cubit.dart';
import 'package:bloc_app/besniees_logic/cubit/items/items_cubit.dart';
import 'package:bloc_app/core/thems.dart';
import 'package:get/get.dart';
import 'package:bloc_app/core/colors.dart';
import 'package:bloc_app/data/repos/items_repos.dart';
import 'package:bloc_app/data/services/item_services.dart';
import 'package:bloc_app/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';

import 'besniees_logic/bloc/theme_bloc/theme_bloc.dart';
import 'besniees_logic/cubit/download_cubit.dart';

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
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc()..add(GetThemeEvent()),
        ),
        RepositoryProvider<CardCubit>(
          create: (context) => CardCubit(),
        ),
        RepositoryProvider<DownloadCubit>(
          create: (context) => DownloadCubit(),
        ),
        RepositoryProvider<ItemsCubit>(
          create: (context) => ItemsCubit(ItemRepo(ItemServices())),
        )
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          if(state is LoadThemeState){
            return GetMaterialApp(
              theme: state.themeData,
              debugShowCheckedModeBanner: false,
              onGenerateRoute: AppRouter().generateRout,
            );
          }else{
            return Container();
          }
        },
      ),
    );
  }
}


