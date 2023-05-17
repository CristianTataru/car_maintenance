import 'package:car_maintenance/feature/home/home_page.dart';
import 'package:car_maintenance/models/vehicle.dart';
import 'package:flutter/material.dart';

List<Vehicle> dataList = [];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}
