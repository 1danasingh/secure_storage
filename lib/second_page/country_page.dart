import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:secure_storage/second_page/country_controller.dart';

import '../second_page/country_details.dart';

class CountryData extends StatefulWidget {
  const CountryData({Key? key}) : super(key: key);
  @override
  State<CountryData> createState() => _CountryDataState();
}

class _CountryDataState extends State<CountryData> {
  CountryController countryController = Get.isRegistered<CountryController>()
      ? Get.find<CountryController>()
      : Get.put(CountryController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[850],
        appBar: AppBar(
          backgroundColor: Colors.grey[850],
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Tap on any Flag',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        body: (countryController.obx(
          (state) {
            if (countryController.state != null &&
                countryController.status.isSuccess) {
              return RefreshIndicator(
                onRefresh: () async {
                  countryController.getCountry();
                },
                child: ListView(
                  controller: countryController.scrollController,
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      //controller: scrollController,
                      shrinkWrap: true,
                      itemBuilder: (_, index) => Padding(
                        padding: const EdgeInsets.fromLTRB(40.0, 30, 40, 30),
                        child: InkWell(
                          onTap: () {
                            Get.to(() => Details(
                              country: countryController.state![index],
                            ));
                          },
                          child: Container(
                            height: 350,
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey[850],
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 1,
                                      blurRadius: 4,
                                      offset: const Offset(5, 5),
                                      color: Colors.grey[900]!),
                                  BoxShadow(
                                      spreadRadius: 1,
                                      blurRadius: 4,
                                      offset: const Offset(-5, -5),
                                      color: Colors.grey[800]!)
                                ]),
                            child: Center(
                              child: CircleAvatar(
                                radius: 80,
                                backgroundImage: NetworkImage(
                                    countryController.state![index]!.flag ??
                                        ''),
                              ),
                            ),
                          ),
                        ),
                      ),
                      itemCount: countryController.state!.length,
                    ),
                    (countryController.loadmore.value)
                        ? SizedBox(
                            height: 80,
                            width: Get.width,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
          onEmpty: const SizedBox(
            child: Center(child: Text('Empty')),
          ),
          onLoading: SizedBox(
              height: MediaQuery.of(context).size.height - 200,
              child: const Center(child: CircularProgressIndicator())),
          onError: (e) => SizedBox(
            child: Center(child: Text(e!)),
          ),
        )));
  }
}
