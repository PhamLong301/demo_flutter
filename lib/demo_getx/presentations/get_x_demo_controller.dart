import 'package:get/get.dart';

class GetXControllerDemo extends GetxController {
  ///OBX
  var count = 0.obs;// init value = 0

  increment(){
    count.value ++;
  }

  decrease(){
    count.value --;
  }

  String value = "HOME";

  void updateValue(){
    if(value == "HOME"){
      value = "SHOW";
    }else {
      value = "HOME";
    }
    update();
  }
}