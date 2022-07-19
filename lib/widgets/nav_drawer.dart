import 'package:flutter/material.dart';
import 'package:manageuz/constants.dart';
import 'package:manageuz/models/main_model.dart';
import 'package:manageuz/functions/logout_function.dart';
import 'package:manageuz/providers/get_main_data_provider.dart';
import 'package:manageuz/screens/take_order_page.dart';
import 'package:manageuz/screens/add_custom.dart';
import 'package:manageuz/screens/home_page.dart';
import 'package:manageuz/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../screens/clients_list_view.dart';
import '../screens/photo_view.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User userData = Provider.of<MainApiProvider>(context).data!.user;
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: const Color(0xff764abc)),
              accountName: Text("Doniyorbek Turg'unboyev"),
              accountEmail: null,
            ),
            SizedBox(
              height: 50,
              child: DrawerHeader(
                margin: const EdgeInsets.all(0.0),
                decoration: const BoxDecoration(
                  color: mainColor,
                ),
                child: userData != null
                    ? Row(
                        children: [
                          Text(userData.fam + ' ' + userData.ism),
                        ],
                      )
                    : const SizedBox(
                        height: 0,
                      ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Asosiy Oynaga Qaytish"),
                leading: Icon(Icons.view_list),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  )
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.shopping_cart_checkout_outlined),
                title: Text("Zakaz Olish"),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const OrderPage()),
                  )
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Kilentlar Ro'yhati"),
                leading: Icon(Icons.view_list),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ClientsListView()),
                  )
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Foto hisobot"),
                leading: Icon(Icons.photo_camera),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PhotoView()),
                  )
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Klient Qo'shish"),
                leading: Icon(Icons.person_add_alt_sharp),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CustomAdd()),
                  )
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Arxiv Zakazlarni ko'rish"),
                leading: Icon(Icons.archive),
                onTap: () => {},
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Qarzdorliklar"),
                leading: Icon(Icons.people),
                onTap: () => {},
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Prodaja"),
                leading: Icon(Icons.leaderboard_rounded),
                onTap: () => {},
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Sozlamalar"),
                leading: Icon(Icons.settings),
                onTap: () => {},
              ),
            ),
            Container(
              height: 1.0,
              color: Color(0xFFDDDDDD),
            ),
            Card(
              child: ListTile(
                title: Text("Chiqish"),
                leading: Icon(Icons.exit_to_app),
                onTap: () async {
                  await logout(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
