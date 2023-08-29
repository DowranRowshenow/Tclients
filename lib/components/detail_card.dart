import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';
import '../models/user_model.dart';
import 'property_card.dart';

class DetailCard extends StatelessWidget {
  const DetailCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: getProportionateScreenHeight(20),
        ),
        PropertyCard(
          order: 0,
          property: numberField,
          value: "+${user.number}",
        ),
        PropertyCard(
          property: nameField,
          value: user.name,
        ),
        PropertyCard(
          property: birthField,
          value: user.birth,
        ),
        PropertyCard(
          property: addressField,
          value: user.address,
        ),
        PropertyCard(
          order: 1,
          property: passportField,
          value: user.passport,
        ),
      ],
    );
  }
}
