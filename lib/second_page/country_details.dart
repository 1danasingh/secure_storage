import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:secure_storage/main.dart';
import 'package:secure_storage/second_page/country.dart';

import '../login_controller.dart';

class Details extends StatelessWidget {
  final Country? country;
  final LogInController logInController = Get.find<LogInController>();

  Details({required this.country, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 0,
        actions: [
          PopupMenuButton(
              onSelected: (i) {
                if (i == 0) {
                  Get.defaultDialog(
                      title: 'Log Out',
                      middleText: 'Are you sure you want to log out ?',
                      actions: [
                        const SizedBox(width: 120,),
                        ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.grey[850]),
                          child: const Text('cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Get.offAll(() => const MyApp());
                            logInController.changeStatus(false);
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.grey[850]),
                          child: const Text('ok'),
                        )
                      ]);
                }
              },
              icon: const Icon(
                Icons.settings_outlined,
                size: 30,
              ),
              itemBuilder: (_) => [
                    const PopupMenuItem(
                      value: 0,
                      child: Text('Log out'),
                    ),
                  ])
        ],
        // actions: [IconButton(onPressed: (){
        //   PopupMenuItem(child: TextButton(onPressed: (){
        //     Get.defaultDialog(title: 'Log Out',middleText: 'Are you sure you want to log out ?',actions: [ElevatedButton(onPressed: (){}, child: Text('cancel')),ElevatedButton(onPressed: (){}, child: Text('ok'))]);
        //   }, child: const Text('Log out',style: TextStyle(color: Colors.blue),)),);
        // }, icon: const Icon(Icons.settings_outlined,size: 30,)),const SizedBox(width: 10,)
        //],
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 1.3,
          width: MediaQuery.of(context).size.width - 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey,
              boxShadow: [
                BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 15,
                    offset: const Offset(5, 5),
                    color: Colors.grey[700]!),
                BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 15,
                    offset: const Offset(-5, -5),
                    color: Colors.grey[400]!)
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // CircleAvatar(
              //   backgroundImage: NetworkImage(country.flag!),
              //   radius: 80,
              // ),
              CachedNetworkImage(
                imageUrl: (country!.flag) ?? '',
                height: 150,
                width: 300,
              ),
              textAlias('Country : ${country!.name}'),
              textAlias('Nationality : ${country!.nationality!}'),
              textAlias('Code : ${country!.code!}'),
              textAlias('ISO Code : ${country!.isoCode!}'),
            ],
          ),
        ),
      ),
    );
  }
}

Widget textAlias(String txt) {
  return Text(
    txt,
    style: const TextStyle(
        fontSize: 18, fontWeight: FontWeight.w500, color: Colors.purple),
  );
}
