import 'package:flutter/material.dart';

import 'list_screen.dart';
import '../components/back_icon_button.dart';
import '../components/search_field.dart';
import '../constants.dart';
import '../helpers/database.dart';
import '../models/user_model.dart';
import '../size_config.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String count = "0";
  List<User> users = [];
  bool isDesc = false;
  final ValueNotifier<Orders> selectedOrder = ValueNotifier(Orders.id);

  void _incrementCounter() async {
    try {
      final map = await DBHelper().searchFilter(
        number: numberController.text,
        name: nameController.text,
        birth: birthController.text,
        address: addressController.text,
        passport: passportController.text,
        order: selectedOrder.value.value,
        isDesc: isDesc,
      );
      count = "${map["count"]}";
      users = map['users'];
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ListScreen(count: count, users: users),
          ),
        );
      });
    } catch (e) {
      print('ERROR: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("$e"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GÖZLEG"),
        centerTitle: true,
        elevation: elevation,
        leading: const BackIconButton(),
      ),
      body: Container(
        height: double.infinity,
        color: bgColor,
        padding: const EdgeInsets.fromLTRB(margin, 0, margin, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              SearchField(
                length: 11,
                type: TextInputType.phone,
                icon: Icons.phone,
                hint: numberField,
                controller: numberController,
              ),
              SizedBox(height: getProportionateScreenHeight(margin_2)),
              SearchField(
                icon: Icons.person,
                hint: nameField,
                controller: nameController,
              ),
              SizedBox(height: getProportionateScreenHeight(margin_2)),
              SearchField(
                icon: Icons.location_pin,
                hint: birthField,
                controller: birthController,
              ),
              SizedBox(height: getProportionateScreenHeight(margin_2)),
              SearchField(
                icon: Icons.home,
                hint: addressField,
                controller: addressController,
              ),
              SizedBox(height: getProportionateScreenHeight(margin_2)),
              SearchField(
                icon: Icons.info,
                hint: passportField,
                controller: passportController,
              ),
              SizedBox(height: getProportionateScreenHeight(margin_2)),
              Container(
                height: getProportionateScreenHeight(60),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(radius)),
                ),
                child: Row(
                  children: [
                    SizedBox(width: getProportionateScreenHeight(margin_2)),
                    const Icon(
                      Icons.sort,
                      color: Colors.black54,
                    ),
                    SizedBox(width: getProportionateScreenHeight(12)),
                    const Text(
                      "Tertiple: ",
                      style: TextStyle(fontSize: 17, color: Colors.black54),
                    ),
                    DropdownButton<Orders>(
                      alignment: AlignmentDirectional.bottomEnd,
                      borderRadius: BorderRadius.circular(radius),
                      underline: Container(),
                      elevation: elevation.toInt(),
                      value: selectedOrder.value,
                      onChanged: (Orders? newValue) {
                        if (newValue?.value == "number") {
                          selectedOrder.value = Orders.number;
                        } else if (newValue?.value == "name") {
                          selectedOrder.value = Orders.name;
                        } else {
                          selectedOrder.value = Orders.id;
                        }
                        setState(() {});
                      },
                      items: Orders.values.map((Orders order) {
                        return DropdownMenuItem<Orders>(
                          value: order,
                          child: Text(order.name),
                        );
                      }).toList(),
                    ),
                    Expanded(child: Container()),
                    const Text(
                      "Tersine: ",
                      style: TextStyle(fontSize: 17, color: Colors.black54),
                    ),
                    Checkbox(
                      value: isDesc,
                      onChanged: (value) {
                        if (value == true) {
                          isDesc = true;
                        } else {
                          isDesc = false;
                        }
                        setState(() {});
                      },
                    ),
                    SizedBox(width: getProportionateScreenHeight(12)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        elevation: elevation,
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
