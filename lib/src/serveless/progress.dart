import 'package:flutter/material.dart';
import 'package:flutter_webrtc_demo/src/serveless/models.dart';

class ServerlessProgress extends StatelessWidget {
  final SeverlessSteps step;
  const ServerlessProgress({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    int position = SeverlessSteps.values.indexOf(step);
    List<Widget> items = List.generate(
      SeverlessSteps.values.length,
      (index) => CircleAvatar(
        backgroundColor: position == index ? Colors.purple[200] : null,
        radius: 25,
        child: Text(index.toString()),
      ),
    );

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 500),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [...items.map((e) => e)],
        ),
      ),
    );
  }
}
