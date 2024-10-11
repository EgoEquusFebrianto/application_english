import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Word.dart';
import 'EndGamePage.dart';

class ButtonTranslate extends StatefulWidget {
  @override
  _ButtonTranslateState createState() => _ButtonTranslateState();
}

class _ButtonTranslateState extends State<ButtonTranslate> {
  int points = 0; // Jumlah poin
  List<MapEntry<String, String>> selectedPairs =
      []; // List pasangan kata yang dipilih oleh pengguna
  int currentRound = 1; // Perulangan saat ini
  int totalRounds = 3; // Total perulangan
  List<MapEntry<String, String>> shuffledPairs =
      []; // List pasangan kata yang sudah diacak
  List<List<MapEntry<String, String>>> wordPairsGroups =
      []; // Grup pasangan kata
  int currentPairsGroupIndex =
      0; // Indeks grup pasangan kata yang sedang ditampilkan

  @override
  void initState() {
    super.initState();
    // Bagi data kata menjadi grup berdasarkan jumlah pasangan kata yang ingin ditampilkan pada setiap putaran
    List<List<MapEntry<String, String>>> groupedPairs =
        splitWordPairs(WordPairs.data, 5);
    wordPairsGroups = groupedPairs;
    // Inisialisasi putaran pertama
    shuffledPairs = groupedPairs[currentPairsGroupIndex].toList()..shuffle();
  }

  // Fungsi untuk membagi data kata menjadi grup berdasarkan jumlah pasangan kata yang ingin ditampilkan pada setiap putaran
  List<List<MapEntry<String, String>>> splitWordPairs(
      Map<String, String> wordPairs, int groupSize) {
    List<MapEntry<String, String>> pairsList = wordPairs.entries.toList();
    List<List<MapEntry<String, String>>> result = [];

    for (int i = 0; i < pairsList.length; i += groupSize) {
      int end =
          (i + groupSize < pairsList.length) ? i + groupSize : pairsList.length;
      result.add(pairsList.sublist(i, end));
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Translate Game'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.all(40),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Cocokkan Kata Yang Tepat !",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.white),
                        ),
                        Text(
                          "Selamat Bermain...",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Points: $points',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black),
                    ),
                    // Menampilkan pasangan kata Inggris-Indonesia
                    for (var pair in shuffledPairs)
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  selectPair(pair);
                                },
                                child: Text(
                                  pair.key,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: 11,
                                      ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                              width: 20,
                            ), // Menam
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  selectPair(pair);
                                },
                                child: Text(
                                  pair.value,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: 11,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Text(
              'Round $currentRound of $totalRounds',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black),
            ),
            SizedBox(height: 5),
            Divider(
                color: Colors.black, // Warna garis
                thickness: 2, // Ketebalan garis (dalam satuan logical pixels)
                height: 10,
                indent: 90,
                endIndent: 90),
            SizedBox(height: 5),
            Divider(
                color: Colors.black, // Warna garis
                thickness: 2, // Ketebalan garis (dalam satuan logical pixels)
                height: 10,
                indent: 50,
                endIndent: 50),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk mengecek pencocokan pasangan kata
  void selectPair(MapEntry<String, String> pair) {
    setState(() {
      selectedPairs.add(pair); // Tambahkan pasangan yang dipilih oleh pengguna

      if (selectedPairs.length == 2) {
        // Jika pengguna telah memilih dua pasangan kata
        MapEntry<String, String> firstPair = selectedPairs[0];
        MapEntry<String, String> secondPair = selectedPairs[1];

        // Cek apakah pasangan kata cocok
        if ((shuffledPairs.contains(firstPair) &&
                shuffledPairs.contains(secondPair)) &&
            ((firstPair.key == pair.key && secondPair.value == pair.value) ||
                (secondPair.key == pair.key &&
                    firstPair.value == pair.value))) {
          // Jika pasangan kata cocok
          points += 5;
          shuffledPairs.remove(firstPair); // Hapus pasangan kata dari tampilan
          shuffledPairs.remove(secondPair);
        } else {
          // Jika pasangan kata tidak cocok
          if (points > 0) {
            points -= 1; // Pengurangan poin hanya jika poin lebih besar dari 0
          }

          // Bergetar tombol jika pasangan kata tidak cocok
          HapticFeedback.vibrate();
        }

        // Bersihkan daftar pasangan kata yang dipilih
        selectedPairs.clear();

        if (shuffledPairs.isEmpty) {
          // Jika semua pencocokan telah selesai pada satu putaran
          if (currentRound < totalRounds) {
            // Lanjutkan ke putaran berikutnya
            currentRound++;
            if (currentPairsGroupIndex < wordPairsGroups.length - 1) {
              // Lanjutkan ke grup kata berikutnya jika masih ada
              currentPairsGroupIndex++;
              shuffledPairs = wordPairsGroups[currentPairsGroupIndex].toList()
                ..shuffle();
            } else {
              // Jika sudah mencapai grup kata terakhir, selesai permainan
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => EndGamePage(
                    points: points,
                  ),
                ),
              );
            }
          } else {
            // Tampilkan halaman akhir jika semua putaran telah selesai
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => EndGamePage(points: points),
              ),
            );
          }
        }
      }
    });
  }
}
