import 'package:bloc_app/data/model/ItemModel.dart';

import '../services/item_services.dart';

class ItemRepo {
  final ItemServices itemServices;

  ItemRepo(this.itemServices);

  Future<List<ItemModel>> getItems() async {
    final List items = await itemServices.getItems();

    return items.map((e) => ItemModel.fromJson(e)).toList();
  }

  Future<List<ItemModel>> getMoreItems() async {
    final List items = await itemServices.getMoreItems();

    return items.map((e) => ItemModel.fromJson(e)).toList();
  }
}
