import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panel_langues/commons/style.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:panel_langues/providers/user_provider.dart';

printer(data) {
  if (kDebugMode) {
    print(data);
  }
}

toasterError(BuildContext context, message) {
  final SnackBar bar = SnackBar(
    content: Text(
      message.toString(),
      style: primarystyle17,
    ),
    elevation: 0.0,
    width: 300,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    backgroundColor: Colors.red,
    padding: const EdgeInsets.all(8),
    // margin: const EdgeInsets.all(40),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    behavior: SnackBarBehavior.floating,
  );
  ScaffoldMessenger.of(context).showSnackBar(bar);
}

toasterSucces(BuildContext context, message) {
  final SnackBar bar = SnackBar(
    content: Text(
      message.toString(),
      style: primarystyle17,
    ),
    elevation: 0.0,
    width: 300,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    backgroundColor: Colors.green,
    padding: const EdgeInsets.all(8),
    // margin: const EdgeInsets.all(40),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    behavior: SnackBarBehavior.floating,
  );
  ScaffoldMessenger.of(context).showSnackBar(bar);
}

authorization() => {
      // "Content-Type": "Application/json",
      "Authorization": "Bearer ${UserProvider.user.tokenuser}"
    };
