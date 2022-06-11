import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:secure_storage/login_controller.dart';
import 'package:secure_storage/second_page/country_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const GetMaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  LogInController logInController = Get.isRegistered<LogInController>()
      ? Get.find<LogInController>()
      : Get.put(LogInController());
  final storage = const FlutterSecureStorage();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String email = 'whyvandanaaa@gmail.com';
  String password = 'hihiyhu';

  @override
  void initState() {
    super.initState();
    readCredentials();
  }

  readCredentials() async {
    emailController.text = await storage.read(key: 'email id') ?? '';
    passwordController.text = await storage.read(key: 'password') ?? '';
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Obx(() => !(logInController.isLoggedIn.value)
        ? Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: const Text('Sign in'),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: 'Enter email'),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: 'Enter password'),
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CheckboxListTile(
                    value: logInController.isRemembered.value,
                    onChanged: (value) {
                      logInController.saveOrRemove(value!);
                    },
                    title: const Text('Remember me ?'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (emailController.text == email &&
                          passwordController.text == password) {
                        if (logInController.isRemembered.value) {
                          await storage.write(
                              key: 'email id', value: emailController.text);
                          await storage.write(
                              key: 'password', value: passwordController.text);
                        } else {
                          await storage.write(key: 'email id', value: null);
                          await storage.write(key: 'password', value: null);
                        }
                        Get.off(() => const CountryData());
                        logInController.changeStatus(true);
                      } else {
                        String incorrect = (emailController.text == email)
                            ? 'Password'
                            : 'Email';
                        logInController.showMessage(incorrect);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(Get.width, 55),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: const Text('Log In'),
                  )
                ],
              ),
            ),
          )
        : const CountryData());
  }
}
