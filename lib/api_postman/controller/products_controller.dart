import 'package:demo_flutter/api_postman/model/products_model.dart';
import 'package:demo_flutter/services/api_service.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  final RxList<ProductModel> products = <ProductModel>[].obs;
  final RxBool isLoadingAll = false.obs;
  final RxBool isLoadingList = false.obs;

  final ApiService apiService = ApiService();


  final int pageSize = 4;
  int skipSize = 0;
  int? totalSize;
  bool get canLoadMore => (products.length < (totalSize ?? 0));
  Future<void> getProducts({bool isLoadingMore = false}) async {
    setLoadingState(isLoadingMore);

    final ProductsTotalResponse? response = await apiService.fetchRecipes(
      currentSize: pageSize,
      skipSize: skipSize,
    );

    resetLoadingState(isLoadingMore);

    if (response != null) {
      totalSize = response.totalResults ?? 0;
      products.addAll(response.products ?? []);
    } else {
      handleError();
    }

    print('Loaded products: ${products.length}');
  }
  Future<void> loadMoreProducts() async {
    if (canLoadMore) {
      skipSize += pageSize;
      await getProducts(isLoadingMore: true);
    }
  }
  void setLoadingState(bool isLoadingMore) {
    if (isLoadingMore) {
      isLoadingList.value = true;
    } else {
      isLoadingAll.value = true;
    }
  }
  void resetLoadingState(bool isLoadingMore) {
    if (isLoadingMore) {
      isLoadingList.value = false;
    } else {
      isLoadingAll.value = false;
    }
  }
  void handleError() {
    Get.snackbar('Error Loading data!', ':((');
  }

  @override
  void onInit() async {
    super.onInit();
    await getProducts();
  }
}
