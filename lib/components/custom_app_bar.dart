import 'package:flutter/material.dart';

import '../constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key key,
    this.text,
    this.title,
  }) : super(key: key);

  final String text, title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Row(
        children: [
          Text.rich(
            TextSpan(
              text: "$text\n",
              style: Theme.of(context).textTheme.headline6,
              children: [
                TextSpan(
                  text: title,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
