part of 'internet_bloc.dart';

@immutable
abstract class InternetState {}

class InternetInitial extends InternetState {}

class ConnectState extends InternetState {
  final String message;

  ConnectState({required this.message});
}

class NotConnectState extends InternetState {
  final String message;

  NotConnectState({required this.message});
}
