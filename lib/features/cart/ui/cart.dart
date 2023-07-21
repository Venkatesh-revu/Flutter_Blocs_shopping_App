import 'package:api_blocs/data/cart_items.dart';
import 'package:api_blocs/features/cart/ui/cart_tile_widget.dart';
import 'package:api_blocs/features/cart/ui/carted_successfully.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:api_blocs/features/cart/bloc/cart_bloc.dart';
// import 'package:api_blocs/features/cart/ui/cart_tile_widget.dart';

double totalPrice = 0;
int itemCount = 0;
double discountSum = 0;

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  // double discountPrice() {

  // return discountSum;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Items'),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listener: (context, state) {},
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartSuccessState:
              // final successState = state as CartSuccessState;
              return ListView.builder(
                  itemCount: cartItems.length + 1,
                  itemBuilder: (context, index) {
                    if (index < cartItems.length) {
                      print(totalPrice.toString());
                      return CartTileWidget(
                        cartBloc: cartBloc,
                        productModel: cartItems[index],
                        totalPrice: totalPrice,
                      );
                    } else {
                      print('hello');
                      // print(totalPrice.toString());
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 40.0),
                        margin: const EdgeInsets.symmetric(vertical: 10.0),

                        // decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(10),
                        //     border: Border.all(color: Colors.black)),
                        color: Colors.greenAccent,

                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                  'Total items are $itemCount and Sum total is: \$ ${totalPrice.toStringAsFixed(2)}'),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text('Discounted price with 5% is '),
                              const SizedBox(height: 10),
                              Text(
                                '\$ ${discountSum.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    if (discountSum.toStringAsFixed(0) != '0') {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PlaceOrder()));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: const Text(
                                            'Cart is empty Add some Items'),
                                        duration: const Duration(seconds: 1),
                                        action: SnackBarAction(
                                          label: 'undo',
                                          onPressed: () {},
                                        ),
                                      ));
                                    }
                                  },
                                  child: const Text(
                                    "Buy now",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                        ),
                      );
                    }
                  });

            default:
          }
          return Container();
        },
      ),
    );
  }
}
