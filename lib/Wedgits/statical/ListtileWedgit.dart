import 'package:expense_tracker/const/placeimages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Listtilewedgit extends StatelessWidget {
  const Listtilewedgit({
    super.key,
    required this.category,
    required this.meeklyOrmonthlyCount,
    required this.meeklyOrmonthlyTotalDecreasing,
  });

  final String category;
  final num meeklyOrmonthlyCount;
  final num meeklyOrmonthlyTotalDecreasing;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ListTile(
        leading: Image.network(Placeimages.placesImages[category]!,height: 20.h,),
        
        title: Text(
          category,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        subtitle: Text(
          "Spent: $meeklyOrmonthlyCount",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        trailing: Text(
          meeklyOrmonthlyTotalDecreasing.toString(),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
