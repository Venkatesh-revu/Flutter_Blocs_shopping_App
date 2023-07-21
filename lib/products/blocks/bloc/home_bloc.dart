import 'dart:async';

import 'package:api_blocs/data/cart_items.dart';
import 'package:api_blocs/data/grocery_data.dart';
import 'package:api_blocs/data/wishlist_items.dart';
import 'package:bloc/bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GroceryData _groceryData;

  HomeBloc(this._groceryData) : super(HomeInitial()) {
    on<ProductFetchEvent>((event, emit) async {
      emit(HomeInitial());
    });
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductWishlistButtonClickedEvent>(
        homeProductWishlistButtonClickedEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    on<HomeWishlistButtonNavigateEvent>(homeWishlistButtonNavigateEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
  }

  FutureOr<void> homeProductWishlistButtonClickedEvent(
      HomeProductWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
    print('Wishlist Product Clicked');
    wishlistItems.add(event.clickedProduct);
    emit(HomeProductItemWishlistedActionState());
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    print('Cart Product clicked');
    cartItems.add(event.clickedProduct);
    emit(HomeProductItemCartedActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('Cart Navigate Clicked');
    emit(HomeNavigateToCartPageActionState());
  }

  FutureOr<void> homeWishlistButtonNavigateEvent(
      HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('Wishlist Navigate Clicked');
    emit(HomeNavigateToWishlistPageActionState());
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLodingState());
    try {
      final products = await _groceryData.getProducts();
      emit(HomeLoadedSuccessState(products));
    } catch (e, st) {
      print(e);
      print(st);
      emit(HomeErrorState(e.toString()));
    }
  }
}
