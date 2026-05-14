import 'package:expense_tracker/Provider/Toogle.dart';
import 'package:expense_tracker/Provider/providerDB.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensesBarGraph extends StatelessWidget {
  const ExpensesBarGraph({super.key});

  @override
  Widget build(BuildContext context) {
    final toggle = Provider.of<ToggleProvider>(context);
    final provider = Provider.of<ExpenseProvider>(context);

    final data = toggle.isWeekly
        ? provider.calculateWeeklyExpenses()
        : provider.calculateMonthlyExpenses();

    final keys = data.keys.toList();

    // أقصى قيمة مع هامش 20% عشان الأعمدة لا تتجاوز الـ SizedBox
    final maxValue = data.values.isEmpty
        ? 100.0
        : data.values.reduce((a, b) => a > b ? a : b).toDouble();
    final maxY = maxValue * 1.2;

    final barGroups = List.generate(keys.length, (index) {
      final value = data[keys[index]]!.toDouble();
      // نحسب نسبة العمود بالنسبة لـ maxY
      final normalizedValue = (value / maxY) * maxY;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: normalizedValue,
            color: Colors.blueAccent,
            width: 12,
            borderRadius: BorderRadius.circular(4),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: maxY,
              color: Colors.grey.withOpacity(0.3),
            ),
          ),
        ],
      );
    });

    return SizedBox(
      height: 200, // ارتفاع ثابت للصندوق
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: maxY,
          barGroups: barGroups,
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= keys.length) return const SizedBox();
                  return Text(
                    keys[index],
                    style: Theme.of(context).textTheme.bodyMedium,
                  );
                },
              ),
            ),
            // leftTitles: AxisTitles(
            //   sideTitles: SideTitles(
            //     showTitles: true,
            //     reservedSize: 40,
            //     interval: maxY / 5, 
            //   ),
            // ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          barTouchData: BarTouchData(enabled: true),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}
