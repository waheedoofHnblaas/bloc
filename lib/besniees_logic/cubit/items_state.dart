part of 'items_cubit.dart';

@immutable
abstract class ItemsState {}

class ItemsInitial extends ItemsState {}

class ItemsLoadedState extends ItemsState {
  final List<ItemModel> items;
  ItemsLoadedState(this.items);
}
