import 'package:bloc_app/besniees_logic/cubit/items_cubit.dart';
import 'package:bloc_app/core/routs.dart';
import 'package:bloc_app/data/repos/items_repos.dart';
import 'package:bloc_app/data/services/item_services.dart';
import 'package:bloc_app/persintaion/views/card_page.dart';
import 'package:bloc_app/persintaion/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  late ItemsCubit itemsCubit;
  late ItemRepo itemRepo;

  AppRouter() {
    itemRepo = ItemRepo(ItemServices());
    itemsCubit = ItemsCubit(itemRepo);
  }

  Route? generateRout(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppPages.homePage:
        return MaterialPageRoute(
          builder: (_)=> const HomePage()
        );
      case AppPages.cardScreen:
        return MaterialPageRoute(
          builder: (_)=> const CardPage()
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
    }
  }
}
