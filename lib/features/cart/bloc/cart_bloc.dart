// ignore_for_file: list_remove_unrelated_type

import 'dart:async';

import 'package:api_blocs/data/cart_items.dart';
import 'package:api_blocs/product_model.dart';
import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitalEvent);
    on<CartRemoveFromCartEvent>(cartRemoveFromCartEvent);
  }

  FutureOr<void> cartInitalEvent(
      CartInitialEvent event, Emitter<CartState> emit) {
    // cartItems.add(event.productModel);
    emit(CartSuccessState(cartItems: cartItems));
  }

  FutureOr<void> cartRemoveFromCartEvent(
      CartRemoveFromCartEvent event, Emitter<CartState> emit) {
    cartItems.remove(event.productModel);
    emit(CartSuccessState(cartItems: cartItems));
  }
}
