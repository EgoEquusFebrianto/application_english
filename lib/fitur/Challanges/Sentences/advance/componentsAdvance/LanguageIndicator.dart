import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../_servicesiAdvance.dart';

class LanguageIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AdvanceButtonListProvider>(
      builder: (context, clickedProvider, _) {
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(100),
              ),
              padding: EdgeInsets.all(5),
              child: Icon(
                Icons.volume_up,
                size: 30,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Language: ${clickedProvider.currentLanguage}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 15),
          ],
        );
      },
    );
  }
}
