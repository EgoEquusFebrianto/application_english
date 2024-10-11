import 'package:flutter/material.dart';
import 'fitur/Challanges/Sentences/HandlerButton.dart';
import 'fitur/Challanges/TranslateGames/button_translate.dart';
import 'fitur/profile/about_yeah.dart';
import 'fitur/profile/profile.dart';
import 'fitur/profile/provider/switchProvider.dart';
import 'package:provider/provider.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'fitur/Challanges/tmp.dart';
import 'package:translator/translator.dart';
import 'fitur/login_and_regist/login.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selected = 0;
  final TextEditingController _controller = TextEditingController();
  String _translatedText = '';
  String _sourceLanguage = 'en';
  String _targetLanguage = 'id';

  void translateText() async {
    final translator = GoogleTranslator();
    var translation = await translator.translate(
      _controller.text,
      from: _sourceLanguage,
      to: _targetLanguage,
    );
    setState(() {
      _translatedText = translation.text;
    });
  }

  Widget bodyPage(int index) {
    switch (index) {
      case 0:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                children: [
                  _buildFeatureCard(),
                  const SizedBox(height: 20),
                  _buildTranslationCard(),
                ],
              ),
            ),
          ),
        );
      case 1:
        return const Profile();
      default:
        return Container(); // Default widget if index is not found
    }
  }

  Widget _buildFeatureCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 10,
      shadowColor: Colors.black54,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          gradient: const LinearGradient(
            colors: [Colors.blue, Colors.lightBlueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Main Features',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                shrinkWrap: true,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: [
                  featureCard(
                    icon: Icons.display_settings_rounded,
                    title: 'Word Display',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const HandlerButton(),
                        ),
                      );
                    },
                    backgroundImage:
                        const AssetImage('assets/pict/icons/sentences.jpeg'),
                    isNetworkImage: true, // Menggunakan NetworkImage
                  ),
                  featureCard(
                    icon: Icons.touch_app_outlined,
                    title: 'Button Translate',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ButtonTranslate(),
                        ),
                      );
                    },
                    backgroundImage: const AssetImage(
                        'assets/pict/icons/button translate.webp'),
                    isNetworkImage: false, // Menggunakan AssetImage
                  ),
                  // Tambahkan card lainnya di sini jika diperlukan
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTranslationCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 20,
      shadowColor: Colors.black54,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          gradient: const LinearGradient(
            colors: [Colors.blue, Colors.lightBlueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Enter text to translate',
                  labelStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDropdownButton(_sourceLanguage, (value) {
                    setState(() {
                      _sourceLanguage = value!;
                    });
                  }),
                  const Icon(Icons.swap_horiz, color: Colors.white),
                  _buildDropdownButton(_targetLanguage, (value) {
                    setState(() {
                      _targetLanguage = value!;
                    });
                  }),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: translateText,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, // Background color
                  backgroundColor: Colors.blue, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text('Translate'),
              ),
              const SizedBox(height: 50),
              Text(
                _translatedText,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownButton(String value, void Function(String?)? onChanged) {
    return DropdownButton<String>(
      value: value,
      dropdownColor: Colors.blueAccent,
      items: const [
        DropdownMenuItem(
          value: 'en',
          child: Text('English', style: TextStyle(color: Colors.white)),
        ),
        DropdownMenuItem(
          value: 'id',
          child: Text('Indonesian', style: TextStyle(color: Colors.white)),
        ),
      ],
      onChanged: onChanged,
    );
  }

  Widget featureCard({
    required IconData icon,
    required String title,
    required Function() onTap,
    required ImageProvider
        backgroundImage, // Menggunakan ImageProvider yang lebih umum
    required bool isNetworkImage,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        splashColor: Colors.blueAccent.withOpacity(0.2),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: backgroundImage,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3),
                BlendMode.darken,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.white),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selected == 0 ? "Home" : "Profile",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      drawer: buildDrawer(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Challange()),
          );
        },
        child: const Icon(Icons.backup_table_sharp),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      body: bodyPage(selected),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Column(
            children: [
              Text(
                'Welcome to Learning App',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Your gateway to knowledge',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          buildSwitchListTile(context),
          const Divider(
            endIndent: 25,
            thickness: 2,
            color: Colors.blue,
            height: 20,
          ),
          buildDrawerListTile(context, Icons.info, 'About', AboutYeah()),
          const Divider(
            endIndent: 25,
            thickness: 2,
            color: Colors.blue,
            height: 20,
          ),
          buildDrawerListTile(context, Icons.logout, 'Logout', Login()),
          const Divider(
            endIndent: 25,
            thickness: 2,
            color: Colors.blue,
            height: 20,
          ),
        ],
      ),
    );
  }

  ListTile buildDrawerListTile(
      BuildContext context, IconData icon, String title, Widget page) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => page),
        );
      },
    );
  }

  SwitchListTile buildSwitchListTile(BuildContext context) {
    return SwitchListTile(
      title: const Text('Dark Mode'),
      value: Provider.of<SwitchModeProvider>(context).darkMode,
      onChanged: (bool val) {
        Provider.of<SwitchModeProvider>(context, listen: false).toggleTheme();
      },
    );
  }

  Logout() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  AnimatedBottomNavigationBar buildBottomNavigationBar() {
    return AnimatedBottomNavigationBar(
      backgroundColor: const Color(0xff202020),
      activeIndex: selected,
      icons: const [
        Icons.home,
        Icons.person,
      ],
      gapLocation: GapLocation.center,
      activeColor: Colors.blue,
      inactiveColor: Colors.white,
      notchSmoothness: NotchSmoothness.verySmoothEdge,
      onTap: (int index) {
        setState(() {
          selected = index;
        });
      },
    );
  }
}
