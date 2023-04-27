import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/repos/items_repos.dart';
import '../../../data/services/item_services.dart';
import '../../cubit/items/items_cubit.dart';

part '../internet_bloc/internet_event.dart';

part '../internet_bloc/internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  StreamSubscription? _streamSubscription;

  InternetBloc() : super(InternetInitial()) {
    on<InternetEvent>(
      (event, emit) {
        print('change internet connection');
        if (event is ConnectMobilEvent) {
          // RepositoryProvider<ItemsCubit>(
          //   create: (context) => ItemsCubit(ItemRepo(ItemServices())),
          // );
          emit(ConnectState(message: 'Connected with Mobil'));
        } else if (event is ConnectWifiEvent) {
          emit(ConnectState(message: 'Connected with Wifi'));
        } else if (event is NotConnectEvent) {
          emit(NotConnectState(message: 'Not Connected'));
        }
      },
      transformer: restartable(),
    );
    _streamSubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.wifi) {
        add(ConnectWifiEvent());
      } else if (result == ConnectivityResult.mobile) {
        add(ConnectMobilEvent());
      } else if (result == ConnectivityResult.none) {
        add(NotConnectEvent());
      }
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
