import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';
import '../models/user_model.dart';
import '../size_config.dart';

class PopupMenu extends StatelessWidget {
  const PopupMenu({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      tooltip: "",
      splashRadius: splashRadius,
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            value: 1,
            child: Row(
              children: [
                const Icon(Icons.copy, color: Colors.black45),
                SizedBox(width: getProportionateScreenWidth(5)),
                const Text("Copy"),
              ],
            ),
            onTap: () {
              Clipboard.setData(ClipboardData(text: user.toString()));
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Ýatda Saklandy!"),
              ));
            },
          ),
          PopupMenuItem(
            value: 2,
            child: Row(
              children: [
                const Icon(Icons.share, color: Colors.black45),
                SizedBox(width: getProportionateScreenWidth(5)),
                const Text("Share"),
              ],
            ),
          ),
          PopupMenuItem(
            value: 3,
            child: Row(
              children: [
                const Icon(Icons.save, color: Colors.black45),
                SizedBox(width: getProportionateScreenWidth(5)),
                const Text("Save"),
              ],
            ),
          ),
        ];
      },
    );
  }
}
