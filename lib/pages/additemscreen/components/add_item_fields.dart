import 'package:flutter/material.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class AddProductFields extends StatelessWidget {
  const AddProductFields({
    this.lines = 1,
    this.ontap,
    this.hint,
    this.type = TextInputType.name,
  });

  final String? hint;
  final int? lines;
  final ontap;
  final TextInputType type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(3.w),
      child: TextField(
        maxLines: lines,
        autofocus: false,
        keyboardType: type,
        style: TextStyle(color: Theme.of(context).shadowColor),
        decoration: InputDecoration(
            labelStyle: TextStyle(color: Theme.of(context).primaryColor),
            fillColor: Colors.teal,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(35.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(35.0)),
            ),
            labelText: hint),
        onChanged: ontap,
      ),
    );
  }
}
