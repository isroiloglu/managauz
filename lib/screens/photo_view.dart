import 'package:flutter/material.dart';
import 'package:manageuz/providers/foto_provider.dart';
import 'package:manageuz/screens/photo_report.dart';
import 'package:provider/provider.dart';

import '../widgets/nav_drawer.dart';

class PhotoView extends StatefulWidget {
  PhotoView({Key? key}) : super(key: key);

  @override
  State<PhotoView> createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  TextEditingController searchController = TextEditingController();

  void fetchData() async {
    await Provider.of<FotoApiProvider>(context, listen: false).getData();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar:
          AppBar(centerTitle: true, title: const Text("Klientlar roʻyxati")),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                context.read<FotoApiProvider>().changeSearchString(value);
              },
              decoration: InputDecoration(
                hintText: 'Qidirish',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Consumer<FotoApiProvider>(
                builder: (context, data, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.customItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          title: Text(
                              '${data.customItems[index].fam} ${data.customItems[index].ism}'),
                          subtitle: Text(
                            '${data.customItems[index].balans}',
                          ),
                          leading: const CircleAvatar(
                            child: Text('rasm'),
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => PhotoReport(
                                  customerId: data.customItems[index].id,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
