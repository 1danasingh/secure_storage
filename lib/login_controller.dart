import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class LogInController extends GetxController{
  final isLoggedIn = false.obs;
  final isRemembered = false.obs;
  final storage = const FlutterSecureStorage();
  LogInController(){
    _getStoreVale();
  }
  Future<void> changeStatus(bool val)
  async {
    isLoggedIn(val);
    await storage.write(key: 'log in', value: val.toString());
  }
  void saveOrRemove(bool val) async{
    isRemembered(val);

    await storage.write(key: 'Remember', value:val.toString());
  }
  Future<void> _getStoreVale() async{
    isLoggedIn((await storage.read(key: 'log in') == 'true')?true:false);
    isRemembered((await storage.read(key: 'Remember') == 'true')?true:false);
  }
  void showMessage(String incorrect){
    Get.defaultDialog(
        title: 'Incorrect $incorrect',
        middleText:
        "The $incorrect you entered is incorrect. Please try again",
        confirm: Column(
          children: [
            Divider(
              color: Colors.grey[800],
            ),
            InkWell(
              child: const SizedBox(
                height: 40,
                child: Center(child: Text('Try Again')),
              ),
              onTap: () => Get.back(),
            ),
          ],
        ),
        backgroundColor: const Color(0xffe5e5e5));
  }

}