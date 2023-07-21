// import 'package:api_blocs/features/cart/ui/cart_tile_widget.dart';

import 'package:api_blocs/data/wishlist_items.dart';
import 'package:api_blocs/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:api_blocs/features/wishlist/ui/wishlist_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();

  void add(WishlistRemoveFromWishlistEvent wishlistRemoveFromWishlistEvent) {}
}

class _WishlistState extends State<Wishlist> {
  final WishlistBloc wishlistBloc = WishlistBloc();
  @override
  void initState() {
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist Items'),
      ),
      body: BlocConsumer<WishlistBloc, WishlistState>(
        bloc: wishlistBloc,
        listener: (context, state) {},
        listenWhen: (previous, current) => current is WishlistActionState,
        buildWhen: (previous, current) => current is! WishlistActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case WishlistSuccessState:
              // final successState = state as WishlistSuccessState;
              return ListView.builder(
                  itemCount: wishlistItems.length,
                  itemBuilder: (context, index) {
                    return WishlistTileWidget(
                        wishlistBloc: wishlistBloc,
                        productModel: wishlistItems[index]);
                  });

            default:
          }
          return Container();
        },
      ),
    );
  }
}
