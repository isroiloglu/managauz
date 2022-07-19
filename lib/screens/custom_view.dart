import 'package:flutter/material.dart';

import '../models/main_model.dart';
import '../widgets/nav_drawer.dart';
import 'edit_custom_view.dart';

class CustomView extends StatefulWidget {
  const CustomView({
    Key? key,
    required this.custom,
  }) : super(key: key);

  final Custom custom;

  @override
  State<CustomView> createState() => _CustomViewState();
}

class _CustomViewState extends State<CustomView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
          centerTitle: true, title: const Text('Klient haqida maʼlumot')),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  minRadius: 30,
                  child: Text('rasm'),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _TextFieldWidget(
                        title: '${widget.custom.fam} ${widget.custom.ism}',
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: Colors.black54,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => CustomEditView(
                          custom: widget.custom,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _LabelWidget(title: 'Balans'),
                _TextFieldWidget(title: '${widget.custom.balans ?? '***'}'),
                const _LabelWidget(title: 'Telefon'),
                _TextFieldWidget(title: '${widget.custom.tel ?? '***'}'),
                const _LabelWidget(title: 'Manzil'),
                _TextFieldWidget(title: '${widget.custom.address ?? '***'}'),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _LabelWidget extends StatelessWidget {
  const _LabelWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.black54,
        fontSize: 16,
      ),
    );
  }
}

class _TextFieldWidget extends StatelessWidget {
  const _TextFieldWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
