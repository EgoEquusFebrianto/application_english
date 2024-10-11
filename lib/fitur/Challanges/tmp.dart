import 'package:flutter/material.dart';
import 'myDictionary/dictionary.dart';
import 'Sentences/HandlerButton.dart';
import 'TranslateGames/button_translate.dart';

class Challange extends StatefulWidget {
  const Challange({Key? key}) : super(key: key);

  @override
  State<Challange> createState() => _ChallangeState();
}

class _ChallangeState extends State<Challange> {
  bool _loading = false;

  Future<void> _navigateToHandlerButton(BuildContext context) async {
    setState(() {
      _loading = true;
    });

    await Future.delayed(Duration(milliseconds: 500)); // Simulating a delay

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HandlerButton(),
      ),
    );

    setState(() {
      _loading = false;
    });
  }

  Future<void> _navigateToButtonTranslate(BuildContext context) async {
    setState(() {
      _loading = true;
    });

    await Future.delayed(Duration(milliseconds: 500)); // Simulating a delay

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ButtonTranslate(),
      ),
    );

    setState(() {
      _loading = false;
    });
  }

  Future<void> _navigateToWordListScreen(BuildContext context) async {
    setState(() {
      _loading = true;
    });

    await Future.delayed(Duration(milliseconds: 500)); // Simulating a delay

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WordListScreen(),
      ),
    );

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
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
                    _navigateToButtonTranslate,
                    isNetworkImage: false,
                  ),
                  const SizedBox(height: 10),
                  _buildCard("Word Display", "assets/pict/icons/sentences.jpeg",
                      Icons.text_fields, _navigateToHandlerButton,
                      isNetworkImage: false),
                  const SizedBox(height: 10),
                  _buildCard("Vocabulary", "assets/pict/icons/vocabullary.jpg",
                      Icons.lightbulb, _navigateToWordListScreen,
                      isNetworkImage: false),
                ],
              ),
            ),
          ),
        ),
        if (_loading) LoadingScreen(),
      ],
    );
  }

  Widget _buildCard(String title, String imageUrl, IconData icon,
      Function(BuildContext) onPressed,
      {bool isNetworkImage = true}) {
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
            image: isNetworkImage
                ? NetworkImage(imageUrl)
                : AssetImage(imageUrl) as ImageProvider,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            ListTile(
              leading: Icon(icon, color: Colors.white),
              title: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            Spacer(),
            ButtonBar(
              children: [
                TextButton(
                  child: const Text(
                    'Open',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    setState(() {
                      _loading = true;
                    });

                    Future.delayed(Duration(milliseconds: 500), () {
                      onPressed(context);
                      setState(() {
                        _loading = false;
                      });
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
          child: CircularProgressIndicator(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
