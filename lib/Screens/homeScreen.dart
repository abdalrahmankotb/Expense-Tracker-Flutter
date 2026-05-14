import 'dart:math';
import 'package:expense_tracker/Provider/providerDB.dart';
import 'package:expense_tracker/Screens/AllExpense.dart';
import 'package:expense_tracker/Wedgits/HomeWedgits/CardcurrentPrice.dart';
import 'package:expense_tracker/Wedgits/HomeWedgits/HomeListtile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<String> datecurrent() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('d MMMM').format(now);
    String day = DateFormat('EEEE').format(now);
    return [formattedDate, day];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, p, _) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            elevation: 0,surfaceTintColor: Colors.transparent,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  datecurrent()[1],
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Text(
                  datecurrent()[0],
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                },
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(25.0).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Cardcurrentprice()),
                SizedBox(height: 32.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Today’s Transactions",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (contxt) => const Allexpense(),
                          ),
                        );
                      },
                      child: Text(
                        "see more >",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Expanded(
                  child: p.expenses.isEmpty
                      ? const Center(child: Text("No transactions yet."))
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: min(p.expenses.length, 5),
                          itemBuilder: (context, index) {
                            return HomeListtile(x: p.expenses[index]);
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
