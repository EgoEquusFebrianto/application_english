import 'package:flutter/material.dart';
import 'myDictionary/dictionary.dart';
import 'Sentences/HandlerButton.dart';
import 'TranslateGames/button_translate.dart';

class Challange extends StatelessWidget {
  const Challange({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Using ValueNotifier to manage loading state
    ValueNotifier<bool> loadingNotifier = ValueNotifier<bool>(false);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Challange",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              _buildCard(
                "Button Translate",
                "assets/pict/icons/button translate.webp",
                Icons.translate,
                () => _navigateToButtonTranslate(context, loadingNotifier),
                loadingNotifier,
              ),
              const SizedBox(height: 10),
              _buildCard(
                "Word Display",
                "assets/pict/icons/sentences.jpeg",
                Icons.text_fields,
                () => _navigateToHandlerButton(context, loadingNotifier),
                loadingNotifier,
              ),
              const SizedBox(height: 10),
              _buildCard(
                "Vocabulary",
                "assets/pict/icons/vocabullary.jpg",
                Icons.lightbulb,
                () => _navigateToWordListScreen(context, loadingNotifier),
                loadingNotifier,
              ),
              ValueListenableBuilder<bool>(
                valueListenable: loadingNotifier,
                builder: (context, isLoading, child) {
                  if (isLoading) {
                    return LoadingScreen();
                  }
                  return SizedBox.shrink(); // Return an empty widget when not loading
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToHandlerButton(BuildContext context, ValueNotifier<bool> loadingNotifier) async {
    loadingNotifier.value = true;
    await Future.delayed(Duration(milliseconds: 500));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HandlerButton()),
    );
    loadingNotifier.value = false;
  }

  void _navigateToButtonTranslate(BuildContext context, ValueNotifier<bool> loadingNotifier) async {
    loadingNotifier.value = true;
    await Future.delayed(Duration(milliseconds: 500));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ButtonTranslate()),
    );
    loadingNotifier.value = false;
  }

  void _navigateToWordListScreen(BuildContext context, ValueNotifier<bool> loadingNotifier) async {
    loadingNotifier.value = true;
    await Future.delayed(Duration(milliseconds: 500));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WordListScreen()),
    );
    loadingNotifier.value = false;
  }

  Widget _buildCard(
    String title,
    String imageUrl,
    IconData icon,
    VoidCallback onPressed,
    ValueNotifier<bool> loadingNotifier,
  ) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage(imageUrl), // Assuming all images are assets
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            ListTile(
              leading: Icon(icon, color: Colors.white),
              title: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            const Spacer(),
            ButtonBar(
              children: [
                TextButton(
                  child: const Text(
                    'Open',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    loadingNotifier.value = true;
                    Future.delayed(Duration(milliseconds: 500), () {
                      onPressed();
                      loadingNotifier.value = false;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: CircularProgressIndicator(color: Colors.blue),
        ),
      ),
    );
  }
}
