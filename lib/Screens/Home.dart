import 'package:expense_tracker/Screens/AddExpense.dart';
import 'package:expense_tracker/Screens/Statical.dart';
import 'package:expense_tracker/Screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.current});
  final String current;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int sizeoficons = 27;
  int currentIndex = 0;
  List<String> datecurrent() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('d MMMM').format(now);
    String day = DateFormat('EEEE').format(now);
    return [formattedDate, day];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: currentIndex == 0 ? Homescreen() : Statical(),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(14).r,
        decoration: BoxDecoration(
          color: const Color(0xffF6F6F6),
          borderRadius: BorderRadius.circular(180.r),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 5.r),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(180)).r,
          child: BottomNavigationBar(
            selectedItemColor: Colors.black12,
            unselectedItemColor: const Color.fromARGB(255, 95, 95, 95),
            currentIndex: currentIndex,
            onTap: (value) {
              setState(() {
                if (value == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddExpense()),
                  );
                } else {
                  currentIndex = value;
                }
              });
            },
            
            backgroundColor: Colors.white,
            items: [
              BottomNavigationBarItem(
                icon: currentIndex == 0
                    ? CircleAvatar(
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.home,
                          color: Colors.white,
                          size: sizeoficons.r,
                        ),
                      )
                    : Icon(
                        Icons.home,
                        size: sizeoficons.r,
                        color: Colors.grey[800],
                      ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: currentIndex == 1
                    ? CircleAvatar(
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: sizeoficons.r,
                        ),
                      )
                    : Icon(
                        Icons.add,
                        size: sizeoficons.r,
                        color: Colors.grey[800],
                      ),
                label: "Add",
              ),
              BottomNavigationBarItem(
                icon: currentIndex == 2
                    ? CircleAvatar(
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.stacked_bar_chart,
                          color: Colors.white,
                          size: sizeoficons.r,
                        ),
                      )
                    : Icon(
                        Icons.stacked_bar_chart,
                        size: sizeoficons.r,
                        color: Colors.grey[800],
                      ),
                label: "Statical",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
