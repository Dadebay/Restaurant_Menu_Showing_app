import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cart_page_controller.dart';

class CartPageView extends GetView<CartPageController> {
  const CartPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CartPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CartPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
