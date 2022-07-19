import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:manageuz/models/product.dart';
import 'package:manageuz/models/zakaz.dart';
import 'package:manageuz/providers/get_main_data_provider.dart';
import 'package:provider/provider.dart';

class EditPage extends StatefulWidget {
  final Zakaz? data;

  const EditPage({Key? key, this.data}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  List<Ztovarlar>? product;
  List<Ztovarlar>? realData;

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  void getProducts() async {
    await Provider.of<MainApiProvider>(context, listen: false)
        .getProducts(widget.data?.id);
    setState(() {
      realData = Provider.of<MainApiProvider>(context, listen: false)
          .product
          ?.ztovarlar;
      product = realData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mahsulotlar')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                onChanged: (s) {
                  if (s.isEmpty) {
                    product = realData;
                  } else {
                    product = realData
                        ?.where((element) =>
                            (element.nomi
                                ?.toLowerCase()
                                .contains(s.toLowerCase())) ??
                            false)
                        .toList();
                  }
                  setState(() {});
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  border:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  hintText: 'Nomini kiriting',
                ),
              ),
              SizedBox(height: 30),
              Text(
                  widget.data?.fam.toString() ??
                      '' + ' ' + (widget.data?.ism?.toString() ?? ''),
                  style: TextStyle(
                    fontSize: 24,
                  )),
              DataTable(
                horizontalMargin: 16,
                columnSpacing: 14,
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'ID',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Mahsulot nomi',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Mahsulot narxi',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Soni',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
                rows: List.generate(
                  (product?.length ?? 0) + 1,
                  (index) => index == 0
                      ? DataRow(
                          cells: <DataCell>[
                            DataCell(Text('#',
                                style: TextStyle(fontWeight: FontWeight.w700))),
                            DataCell(Text(
                                '${product?.length ?? 0} xil mahsulot',
                                style: TextStyle(fontWeight: FontWeight.w700))),
                            DataCell(Text('Jami summa',
                                style: TextStyle(fontWeight: FontWeight.w700))),
                            DataCell(Text(getSumma(product),
                                style: TextStyle(fontWeight: FontWeight.w700))),
                          ],
                        )
                      : DataRow(
                          cells: <DataCell>[
                            DataCell(Text((index).toString())),
                            DataCell(Text(
                                product?[index - 1].nomi.toString() ?? '')),
                            DataCell(Text(
                                product?[index - 1].summa.toString() ?? '')),
                            DataCell(
                              TextFormField(
                                onChanged: (s) {
                                  product?[index - 1].soni = int.parse(s);
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                  hintText:
                                      product?[index - 1].soni.toString() ?? '',
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              SizedBox(height: 20),
              RaisedButton(
                onPressed: () {
                  Provider.of<MainApiProvider>(context, listen: false)
                      .postProduct(
                          Product(ztovarlar: realData, id: widget.data?.id),
                          context);
                },
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: SizedBox(
                    width: 200,
                    child: Text(
                      "Saqlash",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  String getSumma(List<Ztovarlar>? product) {
    int summa = 0;
    product?.forEach((element) {
      summa += (element.summa ?? 0) * (element.soni ?? 0);
    });
    return summa.toString();
  }
}
