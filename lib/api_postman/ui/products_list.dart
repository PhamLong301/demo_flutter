import 'package:flutter/material.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({super.key});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
            }),
        title: Text('Products'),
        actions: [
          IconButton(icon: const Icon(Icons.shopping_cart), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey
              ),
              child: Column(
                children: [
                  Text('data'),
                ],
              ),
            ),
          );
        },
      ),
    ));
  }
}
