import 'package:flutter/material.dart';
import 'package:manageuz/models/main_model.dart';
import 'package:url_launcher/url_launcher.dart';

InputDecoration buildInputDecoration(String hintText, IconData icon) {
  return InputDecoration(
      prefixIcon: Icon(
        icon,
        color: const Color.fromRGBO(50, 62, 72, 1),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      hintText: hintText);
}

Container buttonStyle(String name) {
  return Container(
    width: double.infinity,
    height: 50,
    decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
    child: Center(
      child: Text(
        name,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
    ),
  );
}

Text menuText(String name) {
  return Text(
    name,
    textAlign: TextAlign.center,
  );
}


Container bigCallBtn(BuildContext context, Custom info){
  return Container(
    padding: EdgeInsets.all(10),
    height: 60,
    width: MediaQuery.of(context).size.width - 50,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color(0xFFbdc3c7)
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('+${info.tel}', style: TextStyle(color: Colors.white, fontSize: 18),),
        GestureDetector(
          onTap: () async{
            await launch("tel:${info.tel}");
          },
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20)
            ),
            child: const Center(
              child: Icon(Icons.phone, color: Colors.white,),
            ),
          ),
        )
      ],
    ),
  );
}