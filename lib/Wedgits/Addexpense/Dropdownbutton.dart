import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Dropdownbutton extends StatefulWidget {
  const Dropdownbutton({
    super.key,
    required this.items,       
    required this.onChanged,   
    this.hintText = "Select",  
  });

  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String hintText;

  @override
  State<Dropdownbutton> createState() => _DropdownbuttonState();
}

class _DropdownbuttonState extends State<Dropdownbutton> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      hint: Text(widget.hintText),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(color: Color(0xff1D2A30), width: 2),
        ),
      ),
      items: widget.items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black,
            ),
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() => selectedValue = value);
        widget.onChanged(value); // 👈 نبعته للـ parent
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please select";
        }
        return null;
      },
    );
  }
}
