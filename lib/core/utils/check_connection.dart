import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

void checkConnection(BuildContext context) async {
  final connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult != ConnectivityResult.mobile &&
      connectivityResult != ConnectivityResult.wifi) {
    // عرض رسالة عدم وجود اتصال
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("لا يوجد اتصال بالإنترنت ❌"),
        backgroundColor: Colors.red,
      ),
    );
  }
}
