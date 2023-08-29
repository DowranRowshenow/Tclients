import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';
import '../size_config.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
    this.height = 60,
    this.length = 100,
    this.icon = Icons.search,
    this.type = TextInputType.text,
    required this.hint,
    required this.controller,
  }) : super(key: key);

  final double height;
  final int length;
  final TextInputType type;
  final IconData icon;
  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(height),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Center(
        child: TextField(
          style: const TextStyle(fontSize: 17),
          inputFormatters: [LengthLimitingTextInputFormatter(length)],
          controller: controller,
          keyboardType: type,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "$hint:",
            prefixIcon: Icon(icon),
            contentPadding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
              vertical: getProportionateScreenHeight(14),
            ),
          ),
        ),
      ),
    );
  }
}
