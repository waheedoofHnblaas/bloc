part of 'download_cubit.dart';

@immutable
abstract class DownloadState {}

class DownloadInitial extends DownloadState {}
class DownloadingState extends DownloadState {}
class DownloadedState extends DownloadState {

}
