import 'package:flutter/material.dart';
import 'beginner/Sentences.dart';
import 'advance/SentencesAdvance.dart';
import 'intermediate/SentencesIntermediate.dart';

// import 'beginner/_servicesBeginner.dart';
// import 'intermediate/_servicesintermediate.dart';
// import 'advance/_servicesiAdvance.dart';


class HandlerButton extends StatefulWidget {
  const HandlerButton({Key? key}) : super(key: key);

  @override
  State<HandlerButton> createState() => _HandlerButtonState();
}

class _HandlerButtonState extends State<HandlerButton> {
  bool _loading = false;

  void _navigateToButtonTransferBeginner(BuildContext context) async {
    setState(() {
      _loading = true;
    });

    await Future.delayed(Duration(milliseconds: 500)); // Simulating a delay

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ButtonTransferBeginner(),
      ),
    );

    setState(() {
      _loading = false;
    });
  }

  void _navigateToButtonTransferIntermediate(BuildContext context) async {
    setState(() {
      _loading = true;
    });

    await Future.delayed(Duration(milliseconds: 500));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ButtonTransferIntermediate(),
      ),
    );

    setState(() {
      _loading = false;
    });
  }

  void _navigateToButtonTransferAdvance(BuildContext context) async {
    setState(() {
      _loading = true;
    });

    await Future.delayed(Duration(milliseconds: 500));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ButtonTransferAdvance(),
      ),
    );

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Handler Button'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 600),
              child: Container(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildCard(
                      "Beginner",
                      "assets/pict/icons/Beginner.jpg",
                      Icons.star,
                      _navigateToButtonTransferBeginner,
                      isNetworkImage: false,
                    ),
                    SizedBox(height: 25),
                    _buildCard(
                      "Intermediate",
                      "assets/pict/icons/Intermediate.jpg",
                      Icons.star,
                      _navigateToButtonTransferIntermediate,
                      isNetworkImage: false,
                    ),
                    SizedBox(height: 25),
                    _buildCard(
                      "Advanced",
                      "assets/pict/icons/Upper-Intermediate.jpg",
                      Icons.star,
                      _navigateToButtonTransferAdvance,
                      isNetworkImage: false,
                    ),
                    SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ),
          if (_loading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCard(String title, String imageUrl, IconData icon,
      Function(BuildContext) onPressed,
      {bool isNetworkImage = true}) {
    return InkWell(
      onTap: () {
        onPressed(context);
      },
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          height: 225,
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
            ],
          ),
        ),
      ),
    );
  }
}
