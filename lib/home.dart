// import 'dart:js';

// ignore_for_file: must_be_immutable

import 'package:api_blocs/data/grocery_data.dart';
// import 'package:api_blocs/data/wishlist_items.dart';
// import 'package:api_blocs/features/cart/bloc/cart_bloc.dart';
import 'package:api_blocs/features/cart/ui/cart.dart';
import 'package:api_blocs/features/wishlist/ui/wishlist.dart';
import 'package:api_blocs/product_model.dart';
import 'package:api_blocs/product_tile_widget.dart';
import 'package:api_blocs/products/blocks/bloc/home_bloc.dart';
import 'package:api_blocs/products/blocks/bloc/home_event.dart';
import 'package:api_blocs/products/blocks/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc(GroceryData());
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Cart()));
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Wishlist()));
        } else if (state is HomeProductItemCartedActionState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Item Carted')));
        } else if (state is HomeProductItemWishlistedActionState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Item Wishlisted')));
        }
      },
      builder: (context, state) {
        print(state);
        switch (state.runtimeType) {
          case HomeLodingState:
            return const Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));
          case HomeLoadedSuccessState:
            // final successState = state as HomeLoadedSuccessState;
            return Scaffold(
                appBar: AppBar(
                  title: const Text('The Shopping app'),
                  actions: [
                    IconButton(
                        onPressed: () {
                          homeBloc.add(HomeWishlistButtonNavigateEvent());
                        },
                        icon: const Icon(Icons.favorite_border)),
                    IconButton(
                        onPressed: () {
                          homeBloc.add(HomeCartButtonNavigateEvent());
                        },
                        icon: const Icon(Icons.shopping_bag_outlined)),
                  ],
                ),
                body: BlocBody(
                  homeBloc: homeBloc,
                ));

          case HomeErrorState:
            return const Scaffold(
              body: Center(
                child: Text('Errorrrrrrrr'),
              ),
            );
          default:
            return const SizedBox(
              height: 10,
            );
        }
      },
    );
  }
}

class BlocBody extends StatelessWidget {
  BlocBody({
    super.key,
    required HomeBloc homeBloc,
  });

  // get homeBloc => homeBloc;

  HomeBloc homeBloc = HomeBloc(GroceryData());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(
            GroceryData(),
          )..add(HomeInitialEvent()),
        ),
      ],
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          print('HI : //');
          if (state is HomeLodingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HomeErrorState) {
            return const Center(child: Text("Errorrrrrr"));
          } else if (state is HomeLoadedSuccessState) {
            List<ProductModel> productList = state.products;
            print(productList.length);
            return ListView.builder(
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  return ProductTileWidget(
                      homeBloc: homeBloc, productModel: productList[index]);
                });
          }
          return const Text("HB");
        },
      ),
    );
  }
}
