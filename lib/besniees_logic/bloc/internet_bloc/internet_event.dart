part of 'internet_bloc.dart';

@immutable
abstract class InternetEvent {}



class ConnectMobilEvent extends InternetEvent{}
class ConnectWifiEvent extends InternetEvent{}
class NotConnectEvent extends InternetEvent{}
