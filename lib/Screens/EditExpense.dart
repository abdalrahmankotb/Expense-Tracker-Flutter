import 'package:expense_tracker/Models/AddModel.dart';
import 'package:expense_tracker/Provider/providerDB.dart';
import 'package:expense_tracker/Wedgits/Addexpense/Dropdownbutton.dart';
import 'package:expense_tracker/const/placeimages.dart';
import 'package:expense_tracker/const/places.dart';
import 'package:expense_tracker/const/ways.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:expense_tracker/Wedgits/Addexpense/textform.dart';
import 'package:provider/provider.dart';

class Editexpense extends StatefulWidget {
  const Editexpense({super.key, required this.x});
  final Addmodel x;

  @override
  State<Editexpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<Editexpense> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController tittleController;
  late TextEditingController subtittleController;
  late TextEditingController priceController;
  String? selectedPlace;
  String? selectedWay;
  @override
  void initState() {
    super.initState();
    tittleController = TextEditingController(text: widget.x.title);
    subtittleController = TextEditingController(text: widget.x.subtitle);
    priceController = TextEditingController(text: widget.x.price.toString());
    selectedPlace = widget.x.place;
    selectedWay = widget.x.way;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: const Text("Add Expense"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0).r,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // TextFormFields
                Textform(controler: tittleController, label: "Title"),
                Textform(controler: subtittleController, label: "Subtitle"),
                Textform(controler: priceController, label: "Price"),

                const SizedBox(height: 20),

                // Dropdown for Places
                Dropdownbutton(
                  items: Place.places,
                  hintText: "Select Place",
                  onChanged: (val) {
                    setState(() => selectedPlace = val);
                  },
                ),
                const SizedBox(height: 20),

                // Dropdown for Payment Method
                Dropdownbutton(
                  items: Ways.ways,
                  hintText: "Select Payment Method",
                  onChanged: (val) {
                    setState(() => selectedWay = val);
                  },
                ),
                const SizedBox(height: 30),

                // زرار Submit
                SizedBox(
                  height: 50.h,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          selectedPlace != null &&
                          selectedWay != null) {
                        final updatedExpense = Addmodel(
                          id: widget.x.id,
                          title: tittleController.text,
                          subtitle: subtittleController.text,
                          price: num.parse(priceController.text),
                          place: selectedPlace!,
                          way: selectedWay!,
                          image: Placeimages.placesImages[selectedPlace]!,
                          date: widget.x.date,
                        );

                        final provider = Provider.of<ExpenseProvider>(
                          context,
                          listen: false,
                        );
                        provider.updateExpense(updatedExpense);

                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff1D2A30),
                    ),
                    child: Text(
                      "Update",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
