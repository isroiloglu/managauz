import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:manageuz/models/main_model.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../providers/get_main_data_provider.dart';
import '../widgets/nav_drawer.dart';

class CustomerOrder extends StatefulWidget {
  Custom info;

  CustomerOrder({Key? key, required this.info}) : super(key: key);

  @override
  State<CustomerOrder> createState() => _CustomerOrderState();
}

class _CustomerOrderState extends State<CustomerOrder> {
  @override
  void initState() {
    super.initState();
  }
  List<TextEditingController> controllerBloc = <TextEditingController>[];
  List<TextEditingController> controllerCount = <TextEditingController>[];
  TextEditingController textEditController = TextEditingController();
  Icon customIcon = const Icon(Icons.search);
  bool newOpen = true;
  Widget? customSearchBar;
  @override
  Widget build(BuildContext context) {
    List<Productcategory> prCategory =
        Provider.of<MainApiProvider>(context).prCategory;
    List<Tovarlar> tovarlar = Provider.of<MainApiProvider>(context)
        .tovarlar
        .where((element) =>
            element.sklad ==
            Provider.of<MainApiProvider>(context).active_sklad_id)
        .toList();
    int userType = Provider.of<MainApiProvider>(context).userType;

    int active_kt_id = Provider.of<MainApiProvider>(context).active_kt_id;
    double allCost = Provider.of<MainApiProvider>(context).allCost;

    if(newOpen) {
      customSearchBar = SizedBox(
        width: MediaQuery
            .of(context)
            .size
            .width - 150,
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            onChanged: (newValue) {
              if (newValue is int) {
                Provider.of<MainApiProvider>(context, listen: false)
                    .changeKategory(newValue);
              }
            },
            iconDisabledColor: Colors.white,
            iconEnabledColor: Colors.white,
            value: active_kt_id,
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.blue,
            ),
            style: TextStyle(color: Colors.white, fontSize: 18),
            isExpanded: true,
            items: prCategory.map((sklad) {
              return DropdownMenuItem(
                  value: sklad.id,
                  child: Text(sklad.name,
                      style: TextStyle(
                          inherit: false, color: Colors.white, fontSize: 18)));
            }).toList(),
          ),
        ),
      );
    }
    newOpen = false;
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: customSearchBar!,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              if (customIcon.icon == Icons.search) {
                customIcon = const Icon(Icons.cancel);
                customSearchBar =  ListTile(
                  leading: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 28,
                  ),
                  title: TextField(
                    decoration: InputDecoration(
                      hintText: 'Qidiruv...',
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                      ),
                      border: InputBorder.none,
                    ),
                    controller: textEditController,
                    onChanged: (content) {
                      Provider.of<MainApiProvider>(context, listen: false)
                          .changeSearch(tovarlar, content);
                    },
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              } else {
                customIcon = const Icon(Icons.search);
                customSearchBar = SizedBox(
                  width: MediaQuery.of(context).size.width - 150,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      onChanged: (newValue) {
                        if (newValue is int) {
                          Provider.of<MainApiProvider>(context, listen: false)
                              .changeKategory(newValue);
                        }
                      },
                      iconDisabledColor: Colors.white,
                      iconEnabledColor: Colors.white,
                      value: active_kt_id,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.blue,
                      ),
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      isExpanded: true,
                      items: prCategory.map((sklad) {
                        return DropdownMenuItem(
                            value: sklad.id,
                            child: Text(sklad.name,
                                style: TextStyle(
                                    inherit: false,
                                    color: Colors.white,
                                    fontSize: 18)));
                      }).toList(),
                    ),
                  ),
                );
              }
              setState(() {});
            },
            icon: customIcon,
          )
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: Colors.black45,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Jami Summa:',
                  style: TextStyle(fontSize: 15, color: cBlackColor),
                ),
                Text(
                  '$allCost',
                  style: TextStyle(fontSize: 15, color: cBlackColor),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: Colors.black45,
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.only(left: 2, right: 20),
                primary: false,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: tovarlar.length,
                itemBuilder: (context, index) {
                  controllerBloc.add(TextEditingController());
                  controllerCount.add(TextEditingController());
                  return GestureDetector(
                    onTap: () {},
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white24),
                          margin: EdgeInsets.only(bottom: 3),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 13,
                                child: Container(
                                  margin: const EdgeInsets.all(13),
                                  width: 71,
                                  height: 71,
                                  decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "https://via.placeholder.com/640x480.png/00ee00?text=ut",
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) {
                                        return const CircularProgressIndicator();
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 20,
                                child: SizedBox(
                                  width: 150,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tovarlar[index].nomi ?? '',
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'Medium',
                                          color: cBlackColor,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 9,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.ad_units,
                                            size: 18,
                                          ),
                                          Text(
                                            (userType == 1
                                                    ? tovarlar[index].narxi
                                                    : tovarlar[index]
                                                        .optomNarxi)
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Medium',
                                              color: cBlackColor,
                                            ),
                                          ),
                                          Container(
                                            height: 15,
                                            width: 2,
                                            color: Colors.black87,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10),
                                          ),
                                          const Icon(
                                            Icons
                                                .account_balance_wallet_outlined,
                                            size: 18,
                                          ),
                                          Text(
                                            tovarlar[index].soni.toString(),
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Medium',
                                              color: cBlackColor,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 20,
                                child: SizedBox(
                                  width: 125,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 60,
                                        child: TextFormField(
                                          maxLines: 1,
                                          controller: controllerBloc[index],
                                          cursorColor: Colors.black,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.only(left: 0),
                                              hintText: "bloc"),
                                          onChanged: (bloc) {
                                            Provider.of<MainApiProvider>(
                                                    context,
                                                    listen: false)
                                                .changeAllCost(controllerBloc,
                                                    controllerCount, tovarlar);
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      SizedBox(
                                        width: 60,
                                        child: TextFormField(
                                          maxLines: 1,
                                          controller: controllerCount[index],
                                          cursorColor: Colors.black,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  left: 0, bottom: 0),
                                              hintText: "dona"),
                                          onChanged: (count) {
                                            Provider.of<MainApiProvider>(
                                                    context,
                                                    listen: false)
                                                .changeAllCost(controllerBloc,
                                                    controllerCount, tovarlar);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 1,
                          color: Colors.black45,
                        )
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 8),
        child: SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  showAlertDialog(context, tovarlar);
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 70,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Center(
                    child: Text(
                      'Buyurtmani Yakunlash',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, List<Tovarlar> list) {
    // set up the buttons
    Widget cancelButtonW = TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text("Yo'q"),
    );
    Widget continueButtonW = TextButton(
      onPressed: () {
        continueButton(list);
      },
      child: const Text("Xa"),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Jo'natish!"),
      content: const Text(
          "Buyurtma qilingan maxsulotlarni jo'natishni hohlaysizmi?"),
      actions: [
        cancelButtonW,
        continueButtonW,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void continueButton(List<Tovarlar> list) {
    Provider.of<MainApiProvider>(context, listen: false)
        .sendData(controllerBloc, controllerCount, list, context);
  }
}
