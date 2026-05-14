import 'package:expense_tracker/Provider/Toogle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WeeklyMonthlyToggle extends StatelessWidget {
  const WeeklyMonthlyToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final toggle = Provider.of<ToggleProvider>(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => toggle.setWeekly(true),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: toggle.isWeekly ? Colors.black : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    "Weekly",
                    style: TextStyle(
                      color: toggle.isWeekly ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => toggle.setWeekly(false),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: !toggle.isWeekly ? Colors.black : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    "Monthly",
                    style: TextStyle(
                      color: !toggle.isWeekly ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
