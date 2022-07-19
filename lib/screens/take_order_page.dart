import 'package:flutter/material.dart';
import 'package:manageuz/models/main_model.dart';
import 'package:manageuz/providers/get_main_data_provider.dart';
import 'package:manageuz/screens/customer_order.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../widgets/nav_drawer.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Category> hududlar = Provider.of<MainApiProvider>(context).hududlar;

    int active_hudud = Provider.of<MainApiProvider>(context).active_hudud_id;

    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Manage.uz',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  // UnmodifiableListView(customers);
                  context.read<MainApiProvider>().changeSearchString(value);
                },
                decoration: InputDecoration(
                  hintText: 'Qidirish',
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(height: 20),
            hududlar != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Hududni tanlang",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        DropdownButton(
                          onChanged: (newValue) {
                            assert(newValue is int);
                            if (newValue is int) {
                              Provider.of<MainApiProvider>(context,
                                      listen: false)
                                  .changeHudud(newValue);
                            }
                          },
                          value: active_hudud,
                          isExpanded: true,
                          items: hududlar.map((hudud) {
                            return DropdownMenuItem(
                                value: hudud.id, child: Text(hudud.name));
                          }).toList(),
                        )
                      ],
                    ),
                  )
                : const SizedBox(height: 0),
            const SizedBox(height: 10),
            Expanded(
              child: Consumer<MainApiProvider>(
                builder: (context, data, child) {
                  return ListView.builder(
                    itemCount: data.customItems.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            onTap: () {
                              Provider.of<MainApiProvider>(context,
                                      listen: false)
                                  .changeKlient(data.customItems[index].id);
                              _showDialog(data.customItems[index]);
                            },
                            title: Container(
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Text(
                                '${data.customItems[index].ism} ${data.customItems[index].fam}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                            ),
                            leading: CircleAvatar(
                              backgroundColor: Colors.brown.shade800,
                              minRadius: 12,
                              maxRadius: 26,
                              child: Text(data.customItems[index].ism == ""
                                  ? "0"
                                  : data.customItems[index].ism[0]),
                            ),
                            subtitle: data.customItems[index].address != null
                                ? Text(
                                    'Address: ${data.customItems[index].address}',
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  )
                                : const Text(
                                    'Address:',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  ),
                          ),
                          Divider()
                        ],
                      );
                    },
                    shrinkWrap: true,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _showDialog(Custom costumer) async {
    await showDialog<String>(
      context: context,
      builder: (context) {
        int active_sklad_id =
            Provider.of<MainApiProvider>(context).active_sklad_id;
        List<Skladlar> skladlar =
            Provider.of<MainApiProvider>(context).skladlar;
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: cWhiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 2,
              insetPadding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Skladni tanlang",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        DropdownButton(
                          onChanged: (newValue) {
                            assert(newValue is int);
                            if (newValue is int) {
                              Provider.of<MainApiProvider>(context,
                                      listen: false)
                                  .changeSklad(newValue);
                            }
                          },
                          value: active_sklad_id == -1
                              ? skladlar[0].id
                              : active_sklad_id,
                          isExpanded: true,
                          items: skladlar.map((sklad) {
                            return DropdownMenuItem(
                                value: sklad.id, child: Text(sklad.nomi));
                          }).toList(),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    MaterialButton(
                      onPressed: () {
                        if (active_sklad_id == -1) {
                          Provider.of<MainApiProvider>(context, listen: false)
                              .active_sklad_id = skladlar[0].id;
                        }
                        Navigator.pop(context);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                CustomerOrder(info: costumer)));
                      },
                      //since this is only a UI app
                      color: Colors.blue,
                      elevation: 0,
                      minWidth: 400,
                      height: 55,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        'Buyurtma berish',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'SFUIDisplay',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
