import 'package:expense_tracker/Provider/providerDB.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../Wedgits/Addexpense/textform.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  TextEditingController controller = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0).r,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              Text(
                "Please Give me Your budget",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Form(
                key: key,
                child: Column(
                  children: [Textform(controler: controller, label: "Budget")],
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                height: 50.h,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (controller.text.isNotEmpty) {
                      final provider = context.read<ExpenseProvider>();

                      await provider.addBudget(
                        num.tryParse(controller.text) ?? 0,
                      );

                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff1D2A30),
                  ),
                  child: Text(
                    "Submit",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
