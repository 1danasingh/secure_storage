import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:secure_storage/second_page/country.dart';
import 'package:dio/dio.dart';

class CountryController extends GetxController with StateMixin<List<Country?>>{
  var m=0;
  int limit = 2;
  var loadmore = true.obs;
  ScrollController scrollController = ScrollController();
  List<Country> country = [];
  @override
  void onInit() {
    super.onInit();
    getCountry();
    scrollController.addListener(() {
      if(scrollController.position.pixels >= scrollController.position.maxScrollExtent && loadmore.value){
        getCountry();
      }
    });
  }
  void getCountry() async{
    try {
      if(country.isEmpty) {
        change(null,status: RxStatus.loading());
      }
      String apiUrl = "https://api.vpay.smarttersstudio.in/v1/country?\$limit=2&\$skip=$m";
      var response = await Dio().get(apiUrl);

      final country1 = List<Country>.from(
          response.data['data'].map((jsonObj) => Country.fromJson(jsonObj)));
      country.addAll(country1);
      m = m + country1.length;
      if(country1.length<limit){
        loadmore(false);
      }
      change(country,status: country.isEmpty?RxStatus.empty():RxStatus.success());
    } catch (e) {
      Get.defaultDialog(title: 'Error',middleText: e.toString(),backgroundColor: const Color(0xffe5e5e5));

    }
  }
}