import 'package:expense_tracker/Models/AddModel.dart';
import 'package:expense_tracker/Provider/providerDB.dart';
import 'package:expense_tracker/Screens/EditExpense.dart';
import 'package:expense_tracker/const/placeimages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomeListtile extends StatelessWidget {
  const HomeListtile({super.key, required this.x});
  final Addmodel x;
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, p, _) {
        return InkWell(
          splashColor: Colors.blueGrey,
          onDoubleTap: () {
            p.deleteExpense(x);
          },
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Editexpense(x: x)),
            );
          },
          child: Card(
            elevation: 1,
            color: Colors.white,
            child: ListTile(
              leading: Image.network(
                Placeimages.placesImages[x.place]!,
                height: 25.h,
              ),
              title: Text(
                x.title,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              subtitle: Text(
                x.subtitle,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              trailing: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      Text(
                        x.place,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        x.way,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
