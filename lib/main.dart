import 'package:expense_tracker/Firebase/Auth/AuthGate.dart' show AuthGate;
import 'package:expense_tracker/Firebase/firebase_options.dart';
import 'package:expense_tracker/Provider/Toogle.dart';
import 'package:expense_tracker/Provider/providerDB.dart';
import 'package:expense_tracker/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.requestPermission();
  runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider<ExpenseProvider>(
        create: (_) => ExpenseProvider()
          ..listenToBudget()
          ..listenToExpenses(),
      ),
      ChangeNotifierProvider<ToggleProvider>(
        create: (_) => ToggleProvider(),
      ),
    ],
    child: const MainApp(),
  ),
);

}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Expense Tracker',
          theme: AppTheme.getTheme(),
          home: const AuthGate(),
        );
      },
    );
  }
}
