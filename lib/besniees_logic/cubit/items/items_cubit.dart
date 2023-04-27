import 'package:bloc/bloc.dart';
import 'package:bloc_app/data/repos/items_repos.dart';
import 'package:meta/meta.dart';

import '../../../data/model/ItemModel.dart';

part 'items_state.dart';

class ItemsCubit extends Cubit<ItemsState> {
  final ItemRepo itemRepo;
  List<ItemModel> items = [];

  ItemsCubit(this.itemRepo) : super(ItemsLoadingState());

  Future<List<ItemModel>?> getItemsList() async {
    try {
      emit(ItemsLoadingState());
      await itemRepo.getMoreItems().then((items) {
        emit(ItemsLoadedState(items!));
        this.items = items;
      });
      return items;
    } catch (e) {
      emit(ErrorState('Network Error'));
      return null;
    }
  }

  Future<List<ItemModel>?> getMoreItemsList() async {
    try {
      List<ItemModel>? getNewList = await itemRepo.getMoreItems();
      items.addAll(
          getNewList!.where((element) => getNewList.indexOf(element) >= 2));
      emit(ItemsLoadedState(items));
      print('========items.length==========');
      print(items.length);
      return items;
    } catch (e) {
      if (items.isNotEmpty) {
        emit(ItemsLoadedState(items));
      } else {
        emit(ErrorState('Network Error'));
      }
      return null;
    }
  }
}
