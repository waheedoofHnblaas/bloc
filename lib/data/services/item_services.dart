import 'package:bloc_app/core/links.dart';
import 'package:bloc_app/data/model/ItemModel.dart';
import 'package:dio/dio.dart';

class ItemServices {
  late Dio dio;

  ItemServices() {
    BaseOptions options = BaseOptions(
      baseUrl: AppLinks.host,
      sendTimeout: const Duration(
        seconds: 8,
      ),
      connectTimeout: const Duration(
        seconds: 8,
      ),
      receiveTimeout: const Duration(
        seconds: 8,
      ),
    );
    dio = Dio(options);
  }

  Future<List> getItems() async {
    try {
      Response response = await dio.get(AppLinks.products);
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  int page = 0;

  Future<List> getMoreItems() async {
    try {
      page++;
      Response response = await dio.get(
          'https://api.unsplash.com/photos?page=$page&client_id=${AppLinks.id}');

      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
