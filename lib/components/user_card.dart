import 'package:flutter/material.dart';
import 'package:tclients/components/ripple_container.dart';
import 'package:tclients/constants.dart';
import 'package:tclients/models/user_model.dart';
import 'package:tclients/screens/detail_screen.dart';

import '../size_config.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return RippleContainer(
      margin: const EdgeInsets.only(top: 15),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailScreen(user: user)),
        );
      },
      borderRadius: radius,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
        ),
        height: getProportionateScreenHeight(80),
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
              width: getProportionateScreenWidth(300),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  Text(
                    "+${user.number}",
                    maxLines: 1,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: Container()),
            const Center(
              child: Icon(Icons.arrow_right_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
