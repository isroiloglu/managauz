import 'package:flutter/material.dart';


Padding CustomInput(TextEditingController controller, Function validation, bool error, String error_text, String label,){
  return Padding(
    padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
    child: TextField(
      controller: controller,
      onChanged: (newvalue) {
        validation();
      },
      decoration: error
          ? InputDecoration(
          errorText: error_text,
          label: Text(label),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  width: 1, color: Colors.lightGreen)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  width: 1, color: Colors.lightGreen)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  width: 1, color: Colors.lightGreen)))
          : InputDecoration(
          label: Text(label),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  width: 1, color: Colors.lightGreen)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  width: 1, color: Colors.lightGreen)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  width: 1, color: Colors.lightGreen))),
    ),
  );
}