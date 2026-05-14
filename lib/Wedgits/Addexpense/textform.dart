import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Textform extends StatelessWidget {
  const Textform({super.key, required this.controler, required this.label});
  final TextEditingController controler;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        keyboardAppearance: Brightness.dark,
        controller: controler,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          label: Text(label),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15).r),
        ),
        validator: (value){
          if(value == null || value.isEmpty){
            return "Please enter $label";
          }
          return null;
        },
      ),
    );
  }
}
