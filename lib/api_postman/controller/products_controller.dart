import 'package:demo_flutter/api_postman/model/products_model.dart';
import 'package:demo_flutter/services/api_service.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  List<ProductModel> products = <ProductModel>[].obs;
  RxBool isLoadingAll = false.obs;
  RxBool isLoadingList = false.obs;

  final ApiService apiService = ApiService();

  int itemSize = 4;
  int skipSize = 0;
  int? totalSize;

  Future<void> getRecipes({
    bool isLoadingMore = false,
  }) async {
    if (products.isEmpty) {
      isLoadingAll.value = true;
    }
    if (isLoadingMore) {
      isLoadingList.value = true;
      skipSize += 4;
    }

    final ProductsTotalResponse? response = await apiService.fetchRecipes(
      currentSize: itemSize,
      skipSize: skipSize,
    );
    if (itemSize == 4) {
      isLoadingAll.value = false;
    }
    if (isLoadingMore) {
      isLoadingList.value = false;
    }
    if (response == null) {
      Get.snackbar('Error Loading data!', ':((');
    } else {
      totalSize = response.totalResults ?? 0;
      products.addAll(response.products ?? []);
    }
    print('products ${products.length}');
  }

  Future<void> loadingMore() async {
    if (products.length < (totalSize ?? 0)) {
      await getRecipes(isLoadingMore: true);
    } else {}
  }

  @override
  void onInit() async {
    super.onInit();
    await getRecipes();
  }
}
