import 'dart:convert';

import 'package:get/get.dart';
import '../model/detail_phone_model.dart';
import 'package:http/http.dart' as http;

class DetailPhoneController extends GetxController {
  Rx<DetailPhoneModel?> detailProduct = Rxn<DetailPhoneModel>();
  RxBool isLoading = false.obs;
  RxString titleColor = ''.obs;
  RxString titleSizeMemory = ''.obs;
  RxString getTitle = ''.obs;
  List<AttributeGroups> attributes = [];

  Future<void> fetchDetail() async {
    isLoading.value = true;
    const String productUrl =
        'https://discovery.tekoapis.com/api/v1/product?productId=535038&sku=230900684&location=&terminalCode=phongvu';

    try {
      final response = await http.get(Uri.parse(productUrl));
      if (response.statusCode == 200) {
        print('${response.body}');
        detailProduct.value = DetailPhoneModel.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
        isLoading.value = false;
        update();
      } else {
        isLoading.value = false;
        Get.snackbar('Lỗi, không tải được dữ liệu',
            'Lỗi phản hồi: ${response.statusCode}:${response.reasonPhrase.toString()}');
      }
    } catch (error) {
      isLoading.value = false;
      Get.snackbar('Lỗi tải dữ liệu', 'Đang có lỗi xảy ra');
    }
  }

  List<String> getInfoTitleList = [];
  List<String> productImages = [];

  void getImageProduct() {
    productImages = detailProduct.value?.result?.product?.productDetail?.images
            ?.map((e) => e.url ?? '')
            .toList() ??
        [];
  }

  void getProductTitle() {

  }

  void selectColor(String value) {
    titleColor.value = value;
  }

  List<String?> colorOptions() {
    List<String?> colorOptions = detailProduct
        .value?.result?.product?.productOptions?.rows?[1].options
        ?.map((e) => e.label)
        .toList() ??
        [];
    return colorOptions;
  }

  void selectSizeMemory(String value) {
    titleSizeMemory.value = value;
  }

  List<String?> sizeMemory() {
    List<String?> sizeMemories = detailProduct
        .value?.result?.product?.productOptions?.rows?[0].options
        ?.map((e) => e.label)
        .toList() ?? [];
    print(sizeMemories);
    return sizeMemories;
  }

  void getInfoTitle() {
    getInfoTitleList =
        detailProduct.value?.result?.product?.productDetail?.shortDescription?.split('<br/>') ?? [];
  }

  void getAttributes() {
    attributes = detailProduct.value?.result?.product?.productDetail?.attributeGroups ?? [];
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchDetail();
    getInfoTitle();
    getAttributes();
    getImageProduct();
  }
}
