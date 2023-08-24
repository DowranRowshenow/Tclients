import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';
import '../size_config.dart';

class SearchField extends StatelessWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Center(
        child: TextField(
          inputFormatters: [LengthLimitingTextInputFormatter(11)],
          controller: searchController,
          keyboardType: TextInputType.phone,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Telefon belgisi:",
            prefixIcon: const Icon(Icons.search),
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
