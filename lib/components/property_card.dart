import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';
import '../size_config.dart';

class PropertyCard extends StatelessWidget {
  const PropertyCard({
    Key? key,
    required this.property,
    required this.value,
  }) : super(key: key);

  final String property;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, -5, 0, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          top: BorderSide(width: 0.5, color: Colors.black45),
          bottom: BorderSide(width: 0.5, color: Colors.black45),
        ),
        borderRadius: BorderRadius.circular(radius),
      ),
      height: getProportionateScreenHeight(140),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 5),
            width: getProportionateScreenWidth(10),
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
                bottomLeft: Radius.circular(radius),
              ),
            ),
          ),
          SizedBox(
            width: getProportionateScreenWidth(280),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$property:",
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                Text(
                  value,
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: Container()),
          Center(
            child: IconButton(
              splashColor: Colors.white70,
              splashRadius: splashRadius,
              icon: const Icon(Icons.copy),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: value));
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Ýatda Saklandy!"),
                ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
