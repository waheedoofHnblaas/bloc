import 'package:bloc/bloc.dart';
import 'package:bloc_app/data/repos/items_repos.dart';
import 'package:meta/meta.dart';

import '../../data/model/ItemModel.dart';

part 'items_state.dart';

class ItemsCubit extends Cubit<ItemsState> {
  final ItemRepo itemRepo;
  late List<ItemModel> items;

  ItemsCubit(this.itemRepo) : super(ItemsInitial());

  Future<List<ItemModel>> getItemsList() async {
    await itemRepo.getMoreItems().then((items) {
      emit(ItemsLoadedState(items));
      this.items = items;
    });
    return items;
  }

  Future<List<ItemModel>> getMoreItemsList() async {
    List<ItemModel> getNewList = await itemRepo.getMoreItems();

    items.addAll(getNewList.where((element) => getNewList.indexOf(element)>=2));
    emit(ItemsLoadedState(items));
    print('==================items.length');
    print(items.length);
    return items;
  }
}
