import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';
import '../size_config.dart';

class PropertyCard extends StatelessWidget {
  const PropertyCard({
    Key? key,
    this.order = 2,
    required this.property,
    required this.value,
  }) : super(key: key);

  final int order;
  final String property;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.fromLTRB(0, -5, 0, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          left: BorderSide(width: 0.5, color: Colors.black45),
          top: BorderSide(width: 0.5, color: Colors.black45),
          right: BorderSide(width: 0.5, color: Colors.black45),
          bottom: BorderSide(width: 0.5, color: Colors.black45),
        ),
        borderRadius: order == 0
            ? const BorderRadius.only(
                topLeft: Radius.circular(radius),
                topRight: Radius.circular(radius),
              )
            : order == 1
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(radius),
                    bottomRight: Radius.circular(radius),
                  )
                : const BorderRadius.all(Radius.circular(0)),
      ),
      height: getProportionateScreenHeight(120),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 5),
            width: getProportionateScreenWidth(10),
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: order == 0
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(radius),
                    )
                  : const BorderRadius.all(Radius.circular(0)),
            ),
          ),
          SizedBox(
            width: getProportionateScreenWidth(270),
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
