part of 'wishlist_bloc.dart';

abstract class WishlistEvent {}

abstract class WishlistActionEvent extends WishlistEvent {}

class WishlistInitialEvent extends WishlistEvent {}

class WishlistItemAdding extends WishlistActionEvent {
  final ProductModel productModel;

  WishlistItemAdding(this.productModel);
}

class WishlistRemoveFromWishlistEvent extends WishlistEvent {
  final ProductModel productModel;
  WishlistRemoveFromWishlistEvent({
    required this.productModel,
  });
}
