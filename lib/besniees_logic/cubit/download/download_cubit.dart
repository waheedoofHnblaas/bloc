import 'package:bloc/bloc.dart';
import 'package:bloc_app/data/model/ItemModel.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:meta/meta.dart';

part 'download_state.dart';

class DownloadCubit extends Cubit<DownloadState> {
  DownloadCubit() : super(DownloadInitial());

  Future<bool> download(ItemModel item) async {
    String path = item.urls!.small.toString().replaceAll('fit=max', 'fit=min');
    emit(DownloadingState());
    bool isDone = false;
    await GallerySaver.saveImage(path + '.jpg',
            headers: {}, toDcim: true, albumName: 'unsplash')
        .whenComplete(() {
      print('======whenComplete========');

      isDone = true;
    }).onError((error, stackTrace) {
      print('======onError========');
      isDone = false;
    });
    print('======download========');
    emit(DownloadedState());
    return isDone;
  }

  @override
  Future<void> close() {
    print('close');
    return super.close();
  }
}
