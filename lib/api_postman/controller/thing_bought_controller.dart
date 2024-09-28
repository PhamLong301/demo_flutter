import 'package:demo_flutter/api_postman/model/thing_bought_model.dart';
import 'package:demo_flutter/storages/firebase_storage.dart';
import 'package:get/get.dart';

class ThingBoughtController extends GetxController {
  FirebaseStorageUtil firebaseStorageUtil = FirebaseStorageUtil();
  List<ThingBoughtModel> thingBought = <ThingBoughtModel>[].obs;

  RxBool isLoading = false.obs;

  Future<void> addThingBought({
    required String nameThing,
    required String money,
  }) async {
    isLoading.value = true;
    bool resultAdd = await firebaseStorageUtil.addThingsBought(nameThing: nameThing, money: money);
    if (resultAdd) {
      print('successAdd');
    } else {
      print('errorAdd');
    }
    isLoading.value = false;
  }

  Future<void> getThingsBought() async {
    isLoading.value = true;
    List<ThingBoughtModel> result = await firebaseStorageUtil.getThingBoughtFromFBStorage();
    thingBought.addAll(result);
    isLoading.value = false;
  }

  Future<void> deleteThingBought(String itemID) async{
    isLoading.value = true;
    bool resultDelete = await firebaseStorageUtil.deteleThingBought(itemID);
    if(resultDelete){
      print('Delete success');
      await getThingsBought();
    }else{
      print('Delete failed');
    }
  }

  Future<void> refreshThingsBought() async {
    isLoading.value = true;
    List<ThingBoughtModel> result = await firebaseStorageUtil.getThingBoughtFromFBStorage();
    thingBought.clear();
    thingBought.addAll(result);
    isLoading.value = false;
  }

  @override
  void onInit() async {
    super.onInit();
    await getThingsBought();
  }

  @override
  void onReady() async {
    await refreshThingsBought();
  }
}
