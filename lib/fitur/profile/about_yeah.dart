import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AboutYeah()),
            );
          },
          child: const Text('Go to About'),
        ),
      ),
    );
  }
}

class AboutYeah extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
          backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AboutUsSection(),
              const SizedBox(height: 30),
              WhyChoose(),
              const SizedBox(height: 30),
              TheTeamHeader(),
              const SizedBox(height: 30),
              TeamGrid(),
              const SizedBox(height: 30),
              FeaturesSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class AboutUsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            'ABOUT',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
        SizedBox(height: 20),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Welcome to the English Learning Application Based on Games. Here, you will enhance your English skills through interactive features such as word matching, translation, dictionary, and constructing sentences.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          ),
        ),
      ],
    );
  }
}

class WhyChoose extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            'Why Choose Us?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
        SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                'Interactive and Friendly',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Our content is designed to be engaging and user-friendly, making learning enjoyable and effective.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
            ListTile(
              title: Text(
                'Learn While Playing',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Our application integrates game mechanics to make learning English fun and motivating.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
            ListTile(
              title: Text(
                'Challenging and Logical',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Our levels are designed to challenge your logic and problem-solving skills, enhancing your cognitive abilities.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
            ListTile(
              title: Text(
                'Variety of Features',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'We offer a wide range of features, including word matching, sentence construction, translation, and more.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TheTeamHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.center,
      child: Text(
        'THE TEAM',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }
}

class TeamGrid extends StatelessWidget {
  final List<Map<String, String>> teamMembers = [
    {
      'name': 'Peter Fomas Hia',
      'image': 'assets/pict/peter.jpeg',
    },
    {
      'name': 'Joshua Bulyan Zebua',
      'image': 'assets/pict/joshua.jpeg',
    },
    {
      'name': 'Albert Putra Pratama',
      'image': 'assets/pict/albert.jpeg',
    },
    {
      'name': 'Febrianto Kudadiri',
      'image':'assets/pict/febrianto.jpeg',
    },
    // Add other team members here
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      runSpacing: 30,
      alignment: WrapAlignment.center,
      children: teamMembers.map((member) {
        return TeamCard(
          name: member['name']!,
          image: member['image']!,
        );
      }).toList(),
    );
  }
}

class TeamCard extends StatelessWidget {
  final String name;
  final String image;

  const TeamCard({
    required this.name,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width / 2 - 40;

    return Container(
      width: cardWidth,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(cardWidth, 150),
            painter: MessageBubblePainter(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                backgroundImage: AssetImage(image),
                radius: 60,
              ),
              const SizedBox(height: 60),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MessageBubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height * 0.5)
      ..quadraticBezierTo(0, 0, size.width * 0.25, 0)
      ..quadraticBezierTo(
          size.width * 0.5, 0, size.width * 0.5, size.height * 0.25)
      ..quadraticBezierTo(size.width * 0.5, size.height * 0.5,
          size.width * 0.75, size.height * 0.5)
      ..quadraticBezierTo(
          size.width, size.height * 0.5, size.width, size.height * 0.75)
      ..quadraticBezierTo(
          size.width, size.height, size.width * 0.75, size.height)
      ..quadraticBezierTo(
          size.width * 0.5, size.height, size.width * 0.5, size.height * 0.75)
      ..quadraticBezierTo(size.width * 0.5, size.height * 0.5,
          size.width * 0.25, size.height * 0.5)
      ..quadraticBezierTo(0, size.height * 0.5, 0, size.height * 0.25)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class FeaturesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            'FEATURES',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
        SizedBox(height: 20),
        ListTile(
          leading: Icon(Icons.translate, color: Colors.blue),
          title: Text(
            'Translation Games',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'Enhance your translation skills by translating words and sentences between English and your native language.',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.justify,
          ),
        ),
        ListTile(
          leading: Icon(Icons.spellcheck, color: Colors.blue),
          title: Text(
            'Word Matching',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'Match English words with their meanings or synonyms to improve your vocabulary.',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.justify,
          ),
        ),
        ListTile(
          leading: Icon(Icons.sentiment_satisfied, color: Colors.blue),
          title: Text(
            'Sentence Construction',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'Construct grammatically correct sentences from given words, enhancing your grammar and syntax skills.',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.justify,
          ),
        ),
        ListTile(
          leading: Icon(Icons.book, color: Colors.blue),
          title: Text(
            'Interactive Dictionary',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'Access a comprehensive dictionary with audio pronunciations, example sentences, and more.',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
