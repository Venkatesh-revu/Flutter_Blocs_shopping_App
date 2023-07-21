part of 'wishlist_bloc.dart';

abstract class WishlistState {}

abstract class WishlistActionState extends WishlistState {}

class WishlistInitial extends WishlistState {}

class WishlistSuccessState extends WishlistState {
  final List<ProductModel> wishlistItems;
  WishlistSuccessState({
    required this.wishlistItems,
  });
}
