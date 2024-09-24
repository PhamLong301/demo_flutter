import 'package:demo_flutter/api_postman/controller/products_controller.dart';
import 'package:demo_flutter/api_postman/model/products_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({super.key});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  late ProductsController controller;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller = Get.put(ProductsController());
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        controller.loadingMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Handle settings button press
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {
              // Handle info button press
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(
          () {
            if (controller.isLoadingAll.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<ProductModel> products = controller.products;
              return NotificationListener(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        shrinkWrap: true,
                        itemCount: controller.products.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 200,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: Colors.grey,
                              ),
                              child: Column(
                                children: [
                                  Text(products[index].title ?? ''),
                                  Expanded(
                                      child: Image.network(
                                          products[index].image ?? '')),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Obx(() {
                      if (controller.isLoadingList.value) {
                        return const CircularProgressIndicator();
                      } else {
                        return const SizedBox();
                      }
                    })
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
