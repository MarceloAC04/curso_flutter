import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

class AdaptativeButton extends StatelessWidget {
  final String? label;
  final Function()? onPressed;

  AdaptativeButton({this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
    );

    return UniversalPlatform.isIOS
        ? CupertinoButton(
          onPressed: onPressed!,
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(label!),
        )
        : ElevatedButton(
          style: style,
          onPressed: onPressed!,
          child: Text(label!),
        );
  }
}
