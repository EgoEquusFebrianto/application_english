import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../_servicesBeginner.dart';

class ProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<BeginnerButtonListProvider>(
      builder: (context, clickedProvider, _) {
        return Container(
          width: 360,
          height: 10,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: LinearProgressIndicator(
              value: clickedProvider.completedSentences /
                  clickedProvider.totalSentences,
              backgroundColor: Colors.grey,
              color: Colors.blue,
            ),
          ),
        );
      },
    );
  }
}
