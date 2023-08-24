import 'package:flutter/material.dart';

import 'package:tclients/constants.dart';

class BackIconButton extends StatelessWidget {
  const BackIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      splashRadius: splashRadius,
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
