import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_provider.dart';
import 'progressBar.dart';

class ButtonTranslate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var gameProv = Provider.of<GameProvider>(context);

    if (gameProv.clear) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        gameProv.handleCompletion(context);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cocokkan Kata!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.black87,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                  child: ProgressBarWithIndicator(),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: gameProv.sampleData1.map((data) {
                                String randomTranslation = data['translate'][0];
                                bool isActive = gameProv.activate1[data['id']] ?? true;

                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: ElevatedButton(
                                    onPressed: isActive
                                        ? () {
                                            gameProv.setOnClick(1, data['id']);
                                            gameProv.checkMatching();
                                          }
                                        : null,
                                    child: isActive ? Text(randomTranslation) : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: isActive ? Colors.orange : Colors.white,
                                      foregroundColor: isActive ? Colors.white : Colors.transparent,
                                      minimumSize: Size(double.infinity, 50),
                                      side: gameProv.onClick1 == data['id'] ||
                                              (gameProv.wrongAnswer && gameProv.onClick1 == data['id'])
                                          ? BorderSide(color: gameProv.wrongAnswer ? Colors.red : Colors.black, width: 2)
                                          : BorderSide.none,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: gameProv.sampleData2.map((data) {
                                bool isActive = gameProv.activate2[data['id']] ?? true;

                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: ElevatedButton(
                                    onPressed: isActive
                                        ? () {
                                            gameProv.setOnClick(2, data['id']);
                                            gameProv.checkMatching();
                                          }
                                        : null,
                                    child: isActive ? Text(data['word']) : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: isActive ? Colors.green : Colors.white,
                                      foregroundColor: isActive ? Colors.white : Colors.transparent,
                                      minimumSize: Size(double.infinity, 50),
                                      side: gameProv.onClick2 == data['id'] ||
                                              (gameProv.wrongAnswer && gameProv.onClick2 == data['id'])
                                          ? BorderSide(color: gameProv.wrongAnswer ? Colors.red : Colors.black, width: 2)
                                          : BorderSide.none,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Tombol dan divider
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          print("Exit Pressed");
                        },
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(25),
                          backgroundColor: Colors.red,
                        ),
                        child: Icon(
                          Icons.exit_to_app_outlined,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 15),
                      ElevatedButton(
                        onPressed: gameProv.nextSession ? () {
                          gameProv.startNewRound();
                        } : null,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                        child: Text("Selanjutnya", style: TextStyle(fontSize: 18)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Divider(
                  color: Colors.black,
                  thickness: 2,
                  height: 10,
                  indent: 80,
                  endIndent: 80,
                ),
                SizedBox(height: 5),
                Divider(
                  color: Colors.black,
                  thickness: 2,
                  height: 10,
                  indent: 50,
                  endIndent: 50,
                ),
              ],
            ),
          ),
          // Overlay for completion
          if (gameProv.clear)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Text(
                    "Round Completed!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
