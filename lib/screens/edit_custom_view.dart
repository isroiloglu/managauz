import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:provider/provider.dart';

import '../models/main_model.dart';
import '../providers/edit_custom_provider.dart';
import '../widgets/nav_drawer.dart';
import '../widgets/widgets.dart';

class CustomEditView extends StatefulWidget {
  const CustomEditView({
    Key? key,
    required this.custom,
  }) : super(key: key);

  final Custom custom;

  @override
  State<CustomEditView> createState() => _CustomEditViewState();
}

class _CustomEditViewState extends State<CustomEditView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    EditCustomProvider provider = context.read<EditCustomProvider>();

    return Scaffold(
        drawer: const NavDrawer(),
        appBar:
            AppBar(centerTitle: true, title: const Text('Klientni tahrirlash')),
        body: ListView(
          children: [
            const SizedBox(height: 30),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _TextWidget(
                    title: 'Ism',
                    controller: provider.name,
                    initValue: widget.custom.ism,
                  ),
                  _TextWidget(
                    title: 'Familiya',
                    controller: provider.surname,
                    initValue: widget.custom.fam,
                  ),
                  _NumericWidget(
                    title: 'Telegram',
                    controller: provider.telegram,
                    initValue: 0,
                  ),
                  _NumericWidget(
                    title: 'Telefon',
                    controller: provider.phone,
                    initValue: widget.custom.tel ?? 0,
                  ),
                  // _NumericWidget(
                  //   title: 'Lang',
                  //   controller: provider.lang,
                  //   initValue: widget.custom.lang ?? 0,
                  // ),
                  // _NumericWidget(
                  //   title: 'Lat',
                  //   controller: provider.lat,
                  //   initValue: widget.custom.lat ?? 0,
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          provider.updateCustom(widget.custom.id, context);
                        }
                      },
                      child: buttonStyle('Yangilash'),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ));
  }
}

class _TextWidget extends StatelessWidget {
  const _TextWidget({
    Key? key,
    required this.title,
    required this.controller,
    required this.initValue,
  }) : super(key: key);

  final TextEditingController controller;
  final String title;
  final String initValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: TextFormField(
        controller: controller..text = initValue,
        enableSuggestions: false,
        autocorrect: false,
        validator: ValidationBuilder().required().build(),
        decoration: InputDecoration(
          label: Text(title),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1, color: Colors.lightGreen)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1, color: Colors.lightGreen)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1, color: Colors.lightGreen)),
        ),
      ),
    );
  }
}

class _NumericWidget extends StatelessWidget {
  const _NumericWidget({
    Key? key,
    required this.title,
    required this.controller,
    required this.initValue,
  }) : super(key: key);

  final TextEditingController controller;
  final String title;
  final int initValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: controller..text = initValue.toString(),
        enableSuggestions: false,
        autocorrect: false,
        validator: ValidationBuilder().required().build(),
        decoration: InputDecoration(
          label: Text(title),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1, color: Colors.lightGreen)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1, color: Colors.lightGreen)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1, color: Colors.lightGreen)),
        ),
      ),
    );
  }
}
