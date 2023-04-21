import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../../data/model/ItemModel.dart';

part 'card_state.dart';

class CardCubit extends Cubit<CardState> {
  // final List<ItemModel> cardItem;
  CardCubit() : super(CardInitial());

  final Map<ItemModel, int> items = {};
  final Map<ItemModel, int> removedItems = {};

  addItem(ItemModel item) {
    if (items.keys.contains(item)) {
      items.update(item, (value) => value + 1);
    } else {
      items.addAll({item: 1});
    }
    emit(AppCardState(items));
  }

  void removeItem(item) {
    removedItems.clear();
    items.forEach((key, value) {
      if (key == item) {
        if (value == 1) {
          removedItems.addAll({item: 1});
        } else {
          items.update(item, (value) => value - 1);
        }
      }
    });
    items.removeWhere((item, value) => removedItems.containsKey(item));
    emit(AppCardState(items));
  }
}
