import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../product_model.dart';

@immutable
abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

abstract class HomeActionEvent extends HomeEvent {}

class HomeInitialEvent extends HomeEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ProductFetchEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class HomeProductWishlistButtonClickedEvent extends HomeActionEvent {
  final ProductModel clickedProduct;
  HomeProductWishlistButtonClickedEvent({
    required this.clickedProduct,
  });

  @override
  List<Object?> get props => throw UnimplementedError();
}

class HomeProductCartButtonClickedEvent extends HomeActionEvent {
  final ProductModel clickedProduct;
  HomeProductCartButtonClickedEvent({
    required this.clickedProduct,
  });

  @override
  List<Object?> get props => throw UnimplementedError();
}

class HomeWishlistButtonNavigateEvent extends HomeActionEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class HomeCartButtonNavigateEvent extends HomeActionEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
