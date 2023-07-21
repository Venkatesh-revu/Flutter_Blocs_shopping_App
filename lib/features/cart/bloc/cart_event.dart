part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

abstract class CartActionEvent extends CartEvent {}

class CartInitialEvent extends CartEvent {}

class CartItemAdding extends CartActionEvent {
  final ProductModel productModel;

  CartItemAdding(this.productModel);
}

class CartRemoveFromCartEvent extends CartEvent {
  final ProductModel productModel;
  CartRemoveFromCartEvent({
    required this.productModel,
  });
}
