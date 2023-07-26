import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panel_langues/providers/user_provider.dart';
import 'package:panel_langues/views/screen/application.dart';
import 'package:panel_langues/views/screen/login.dart';

void main() {
  Get.put(UserProvider()).logOut();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  final token = Get.put(UserProvider());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: token,
        initState: (context) => UserProvider.user.getToken(),
        builder: (context) {
          return GetMaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: UserProvider.user.tokenuser == null
                ? const Login()
                : const Application(),
          );
        });
  }
}
