part of 'card_cubit.dart';

@immutable
abstract class CardState {}

class CardInitial extends CardState {}

class AppCardState extends CardState {
  final Map<ItemModel, int> items ;
  AppCardState(this.items){
    print(items.keys.toList().length);
  }
}
