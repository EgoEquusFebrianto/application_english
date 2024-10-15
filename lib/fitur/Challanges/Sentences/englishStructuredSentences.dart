import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '_services.dart';

class ButtonTransfer extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final useState = Provider.of<ClickedButtonListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider Prototype'),
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (didPop) {
            return;
          }
          final bool shouldPop = await _showBackDialog(context) ?? false;
          if (context.mounted && shouldPop) {
            Navigator.pop(context);
          }
        },
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Terjemahkan kalimat berikut menjadi kalimat Inggris",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600
                ),
                ),
                SizedBox(height: 20),
                Text(
                  "${useState.elementList[useState.indexing]['kalimat']}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 15),
                Consumer<ClickedButtonListProvider>(
                  builder: (context, clickedProvider, _) {
                    return Container(
                      width: 400,
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.transparent, 
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.black,
                          width: 2.5,
                          style: BorderStyle.solid
                        )),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: clickedProvider.firstContainer.map((item) {
                          return item['cursor']
                              ? AnimatedButton(
                                  index: item['id'],
                                  onPressed: () {
                                    bool access = item['cursor'];
                                    clickedProvider.updateElement(
                                        access, item['id']);
                                    clickedProvider.updateFirstContainer(
                                        access, item);
                                    clickedProvider.updateListAnswer(
                                        0, item['id']);
                                  },
                                  child: Text('${item['word']}'),
                                )
                              : SizedBox.shrink();
                        }).toList(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                Consumer<ClickedButtonListProvider>(
                  builder: (context, clickedProvider, _) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      color: Colors.transparent,
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: clickedProvider.element.map((item) {
                          return !item['cursor']
                              ? AnimatedButton(
                                  index: item['id'],
                                  onPressed: () {
                                    bool access = item['cursor'];
                                    clickedProvider.updateElement(
                                        access, item['id']);
                                    clickedProvider.updateFirstContainer(
                                        access, item);
                                    clickedProvider.updateListAnswer(
                                        1, item['id']);
                                  },
                                  child: Text('${item['word']}'),
                                )
                              : SizedBox.shrink();
                        }).toList(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        context
                            .read<ClickedButtonListProvider>()
                            .updateIndexElement();
                        print(context.read<ClickedButtonListProvider>().answer);
                        print(context.read<ClickedButtonListProvider>().elementList[0]['typeAns']);
                      },
                      label: Text("Check"),
                      icon: Icon(Icons.arrow_forward_ios),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                        fixedSize: Size(200, 30),
                        elevation: 5,
                        shadowColor: Colors.red,
                      ),
                    ),
                    SizedBox(width: 45),
                  ],
                ),
              ],
            ),
            Consumer<ClickedButtonListProvider>(
              builder: (context, clickedProvider, _) {
                if (clickedProvider.showAnimation) {
                  return _buildAnimationBox(
                    show: clickedProvider.showAnimation,
                    color: clickedProvider.showCorrectAnimation
                        ? Color.fromARGB(255, 60, 150, 22)
                        : Colors.red.shade900,
                    icon: clickedProvider.showCorrectAnimation
                        ? Icons.check
                        : Icons.close,
                  );
                } else if (clickedProvider.showAllElementsExplored) {
                  Future.delayed(Duration(seconds: 2), () {
                    if (context.mounted) {
                      Navigator.pop(context);
                      clickedProvider.notify();
                    }
                  });
                  return Center(
                    child: Container(
                      width: 200,
                      height: 100,
                      color: Colors.black.withOpacity(0.7),
                      child: Center(
                        child: Text(
                          'All sentences explored!',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedButton extends StatelessWidget {
  final int index;
  final VoidCallback onPressed;
  final Widget child;

  AnimatedButton({
    required this.index,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0.0, 50.0 * value),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.amber[300]
        ),
      ),
    );
  }
}

Widget _buildAnimationBox({
  required bool show,
  required Color color,
  required IconData icon,
}) {
  return Center(
    child: AnimatedOpacity(
      opacity: show ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: color.withOpacity(0.82),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          icon,
          size: 100,
          color: Colors.white,
        ),
      ),
    ),
  );
}

Future<bool?> _showBackDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Are you sure you want to leave this page?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Nevermind'),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
          TextButton(
            child: const Text('Leave'),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ],
      );
    },
  );
}
