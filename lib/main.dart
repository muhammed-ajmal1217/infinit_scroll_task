import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:refulgenceinc/controller/home_controller.dart';
import 'package:refulgenceinc/view/home.dart';

void main(){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeController(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}