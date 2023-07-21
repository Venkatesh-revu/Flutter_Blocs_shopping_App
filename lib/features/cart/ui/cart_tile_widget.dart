import 'package:api_blocs/features/cart/ui/cart.dart';
import 'package:api_blocs/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:api_blocs/features/cart/bloc/cart_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CartTileWidget extends StatelessWidget {
  final ProductModel productModel;
  final CartBloc cartBloc;
  const CartTileWidget(
      {super.key,
      required this.productModel,
      required this.cartBloc,
      required totalPrice});

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
                    image: NetworkImage(productModel.image.toString()))),
          ),
          const SizedBox(height: 20),
          Text(productModel.title.toString(),
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(productModel.description.toString()),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("\$${productModel.price}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              RatingBar.builder(
                initialRating: double.parse(productModel.rate as String),
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 20,
                itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  // print(rating);
                },
              ),
              Text("(" + productModel.count.toString() + ')'),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        // homeBloc.add(HomeProductWishlistButtonClickedEvent(
                        // clickedProduct: productModel));
                      },
                      icon: const Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        // Show snacBar

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
                            double.parse(productModel.price as String);
                        discountSum = totalPrice - ((5 / 100) * totalPrice);
                        cartBloc.add(CartRemoveFromCartEvent(
                            productModel: productModel));
                      },
                      icon: const Icon(Icons.shopping_bag)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
