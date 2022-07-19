import 'package:flutter/material.dart';
import '../providers/add_custom_provider.dart';
import 'package:form_validator/form_validator.dart';
import 'package:provider/provider.dart';

// import '../providers/get_main_data_provider.dart';
import '../widgets/nav_drawer.dart';
import '../widgets/widgets.dart';

class CustomAdd extends StatefulWidget {
  CustomAdd({Key? key}) : super(key: key);

  @override
  State<CustomAdd> createState() => _CustomAddState();
}

class _CustomAddState extends State<CustomAdd> {
  int _type = 1;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AddCustomProvider provider = context.read<AddCustomProvider>();

    return Scaffold(
        drawer: const NavDrawer(),
        appBar: AppBar(centerTitle: true, title: const Text("Kilent Qo'shish")),
        body: ListView(
          children: [
            const SizedBox(height: 30),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _TextWidget(title: 'Ism', controller: provider.name),
                  _TextWidget(title: 'Familiya', controller: provider.surname),
                  _NumericWidget(title: 'Balans', controller: provider.balance),
                  const Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      "Mijoz Turi",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.green)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 5, bottom: 5),
                      child: DropdownButton(
                        value: _type,
                        isExpanded: true,
                        items: const [
                          DropdownMenuItem(value: 1, child: Text("Oddiy")),
                          DropdownMenuItem(value: 2, child: Text("Ulgurji")),
                        ],
                        onChanged: (int? value) {
                          setState(() {
                            _type = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  _NumericWidget(
                      title: 'Telegram', controller: provider.telegram),
                  _NumericWidget(title: 'Telefon', controller: provider.phone),
                  _NumericWidget(title: 'Lang', controller: provider.lang),
                  _NumericWidget(title: 'Lat', controller: provider.lat),
                  _TextWidget(title: 'Manzil', controller: provider.address),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          provider.addCustom(_type, context);
                        }
                      },
                      child: buttonStyle('Post'),
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
  }) : super(key: key);

  final TextEditingController controller;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: TextFormField(
        controller: controller,
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
  }) : super(key: key);

  final TextEditingController controller;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: controller,
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
