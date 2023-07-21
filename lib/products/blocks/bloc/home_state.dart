import 'package:api_blocs/product_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLodingState extends HomeState {
  List<Object?> get props => [];
}

class HomeLoadedSuccessState extends HomeState {
  final List<ProductModel> products;
  HomeLoadedSuccessState(
    this.products,
  );

  List<Object?> get props => [products];
}

class HomeErrorState extends HomeState {
  final String error;
  HomeErrorState(this.error);

  List<Object?> get props => [error];
}

class HomeNavigateToWishlistPageActionState extends HomeActionState {}

class HomeNavigateToCartPageActionState extends HomeActionState {}

class HomeProductItemWishlistedActionState extends HomeActionState {}

class HomeProductItemCartedActionState extends HomeActionState {}
