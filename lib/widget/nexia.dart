// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class Nexia extends StatefulWidget {
  const Nexia({required this.taper, super.key});

  final Function taper;

  @override
  _NexiaState createState() => _NexiaState();
}

class _NexiaState extends State<Nexia> with TickerProviderStateMixin {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onHighlightChanged: (value) {
          setState(() {
            isTapped = value;
          });
        },
        onTap: () => widget.taper(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastLinearToSlowEaseIn,
          height: isTapped ? 100 : 220,
          width: isTapped ? 200 : 290,
          child: Image.asset(fit: BoxFit.cover, 'assets/nexia.png'),
        ),
      ),
    );
  }
}
