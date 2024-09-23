import 'package:carousel_slider/carousel_slider.dart';
import 'package:demo_flutter/api_postman/controller/phone_controller.dart';
import 'package:demo_flutter/api_postman/model/detail_phone_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/firebase_controller.dart';

class DetailPhoneScreen extends StatefulWidget {
  const DetailPhoneScreen({super.key});

  @override
  State<DetailPhoneScreen> createState() => _DetailPhoneScreenState();
}

class _DetailPhoneScreenState extends State<DetailPhoneScreen> {
  late DetailPhoneController _controller;
  final AuthController authController = Get.find();

  @override
  void initState() {
    _controller = Get.put(DetailPhoneController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              authController.signOut();
            }),
        actions: [
          IconButton(icon: const Icon(Icons.shopping_cart), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: SafeArea(
        child: Obx(
          () => _controller.isLoading.value == true
              ? const CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            child: CarouselSlider(
                              options: CarouselOptions(
                                autoPlay: true,
                                autoPlayAnimationDuration:
                                    const Duration(milliseconds: 5),
                              ),
                              items: _controller.productImages
                                  .map((item) => Container(
                                        child: Center(
                                          child: Image.network(
                                            item,
                                            fit: BoxFit.fill,
                                            height: 300,
                                            width: double.infinity,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Obx(() => Text(
                              'Màu sắc: ${_controller.titleColor}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            )),
                      ),
                      Wrap(
                        children: _controller
                            .colorOptions()
                            .map((e) => GestureDetector(
                                  onTap: () {
                                    _controller.selectColor(e ?? '');
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                      right: 16,
                                      bottom: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.transparent,
                                      border: Border.all(
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    child: Text(e ?? ''),
                                  ),
                                ))
                            .toList(),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Obx(() => Text(
                              'Dung lượng: ${_controller.titleSizeMemory}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            )),
                      ),
                      Wrap(
                        children: _controller
                            .sizeMemory()
                            .map((e) => GestureDetector(
                                  onTap: () {
                                    _controller.selectSizeMemory(e ?? '');
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                      right: 16,
                                      bottom: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.transparent,
                                      border:
                                          Border.all(color: Colors.blueAccent),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    child: Text(e ?? ''),
                                  ),
                                ))
                            .toList(),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Thông tin chi tiết sản phẩm',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        _controller.detailProduct.value?.result?.product?.productInfo?.name ?? '',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        '${_controller.detailProduct.value?.result?.product?.prices?.first?.latestPrice}đ',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          Text(
                            '${_controller.detailProduct.value?.result?.product?.prices?.first?.supplierRetailPrice}đ   ',
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            '-${_controller.detailProduct.value?.result?.product?.prices?.first?.discountPercent}%',
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _controller.getInfoTitleList
                            .map((e) => Container(
                          child: Text(e),
                          margin: const EdgeInsets.only(
                            bottom: 10,
                          ),
                        ))
                            .toList(),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Text(
                        'Chi tiết sản phẩm',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: index % 2 == 0 ? Colors.white : Colors.grey.withOpacity(0.6),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 26,
                              vertical: 16,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _controller.attributes[index].name ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    _controller.attributes[index].value ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: _controller.attributes.length,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Xem thêm nội dung'),
                          IconButton(
                            icon: const Icon(Icons.expand_more),
                            onPressed: () {},
                          )
                        ],
                      ),

                      const SizedBox(
                        height: 6,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Mô tả sản phẩm',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      // Html(data: DetailProductController.testHtml),
                      Text(
                        '${_controller.detailProduct?.value?.result?.product?.productDetail?.description}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 150,
                      ),
                    ],
                  ),
                ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        height: 64,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              backgroundColor: Colors.blue),
          child: const Center(child: Text('Liên Hệ')),
        ),
      ),
    );
  }
}
