import 'package:completefoodorderingappui/bakeryadminapp/HomeScreens/provider/user_provider.dart';
import 'package:completefoodorderingappui/services/notification_listener.dart';
import 'package:completefoodorderingappui/view/add_to_cart/provider/cart_provider.dart';
import 'package:completefoodorderingappui/view/orders_screen/provider/order_provider.dart';
import 'package:completefoodorderingappui/view/splash/spashscreen.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EmailOTP.config(
    appName: 'FoodOrdering',
    otpType: OTPType.numeric,
    expiry: 30000,
    emailTheme: EmailTheme.v6,
    appEmail: 'me@rohitchouhan.com',
    otpLength: 4,
  ); 
  await Firebase.initializeApp(
    // options: const FirebaseOptions(
    //     apiKey: "AIzaSyBma-vJige4ozn2JEw_Wz2Kpcwkzvd1rgE",
    //     authDomain: "groceryapp-a124b.firebaseapp.com",
    //     projectId: "groceryapp-a124b",
    //     storageBucket: "groceryapp-a124b.appspot.com",
    //     messagingSenderId: "700998957139",
    //     appId: "1:700998957139:web:2254f74a448cc7b7246ea6",
    //     measurementId: "G-GTM8FKBQK9"),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 756),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return NotificationsHandler(
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const SpashScreen(),
          ),
        );
      },
    );
  }
}