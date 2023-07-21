import 'package:api_blocs/data/cart_items.dart';
import 'package:api_blocs/data/wishlist_items.dart';
// import 'package:api_blocs/features/cart/bloc/cart_bloc.dart';
import 'package:api_blocs/features/cart/ui/cart.dart';
// import 'package:api_blocs/features/wishlist/bloc/wishlist_bloc.dart';
// import 'package:api_blocs/features/wishlist/ui/wishlist.dart';
import 'package:api_blocs/product_model.dart';
import 'package:api_blocs/products/blocks/bloc/home_bloc.dart';
import 'package:api_blocs/products/blocks/bloc/home_event.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductTileWidget extends StatefulWidget {
  final ProductModel productModel;
  final HomeBloc homeBloc;
  const ProductTileWidget(
      {super.key, required this.productModel, required this.homeBloc});

  @override
  State<ProductTileWidget> createState() => _ProductTileWidgetState();
}

class _ProductTileWidgetState extends State<ProductTileWidget> {
  bool isFavChecked = false;
  bool isCarChecked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.productModel.image.toString()))),
          ),
          const SizedBox(height: 20),
          Text(widget.productModel.title.toString(),
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 10,
          ),
          Text(widget.productModel.description.toString()),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("\$${widget.productModel.price}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              RatingBar.builder(
                initialRating: double.parse(widget.productModel.rate as String),
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 20,
                itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  // print(rating);
                },
              ),
              Text("(" + widget.productModel.count.toString() + ')'),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        if (!wishlistItems.contains(widget.productModel)) {
                          widget.homeBloc.add(
                              HomeProductWishlistButtonClickedEvent(
                                  clickedProduct: widget.productModel));
                        } else if (wishlistItems
                            .contains(widget.productModel)) {
                          wishlistItems.remove(widget.productModel);
                        }
                        print(widget.productModel.count);
                        // print(wishlistItems.length);
                        // print(totalPrice);
                        setState(() {
                          isFavChecked = !isFavChecked;
                        });
                      },
                      icon: isFavChecked
                          ? const Icon(Icons.favorite)
                          : const Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        if (!cartItems.contains(widget.productModel)) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text('Item succfully added'),
                            duration: const Duration(seconds: 1),
                            action: SnackBarAction(
                              label: 'undo',
                              onPressed: () {},
                            ),
                          ));
                          itemCount++;
                          totalPrice +=
                              double.parse(widget.productModel.price as String);
                          discountSum = totalPrice - ((5 / 100) * totalPrice);
                          widget.homeBloc.add(HomeProductCartButtonClickedEvent(
                              clickedProduct: widget.productModel));
                          setState(() {
                            isCarChecked = true;
                          });
                        } else if (cartItems.contains(widget.productModel)) {
                          // show snack bar
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text('Item succfully removed'),
                            duration: const Duration(seconds: 1),
                            action: SnackBarAction(
                              label: 'undo',
                              onPressed: () {},
                            ),
                          ));
                          itemCount--;
                          totalPrice -=
                              double.parse(widget.productModel.price as String);
                          discountSum = totalPrice - ((5 / 100) * totalPrice);
                          cartItems.remove(widget.productModel);
                          setState(() {
                            isCarChecked = false;
                          });
                        }
                      },
                      icon: isCarChecked
                          ? const Icon(Icons.shopping_bag)
                          : const Icon(Icons.shopping_bag_outlined)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
