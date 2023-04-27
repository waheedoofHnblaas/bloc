part of 'items_cubit.dart';

@immutable
abstract class ItemsState {}

class ItemsLoadingState extends ItemsState {}

class ItemsLoadedState extends ItemsState {
  final List<ItemModel> items;

  ItemsLoadedState(this.items);
}

class ErrorState extends ItemsState {
  final String message;

  ErrorState(this.message);
}
