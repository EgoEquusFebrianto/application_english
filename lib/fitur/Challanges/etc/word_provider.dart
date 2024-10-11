class WordProvider {
  static Future<Map<String, dynamic>> fetchWords() async {
    List<List<Map<String, dynamic>>> words = [
      [
        {'id': 1, 'ind': 'saya', 'eng': 'I'},
        {'id': 2, 'ind': 'lebih', 'eng': 'more'},
        {'id': 3, 'ind': 'menyukai', 'eng': 'like'},
        {'id': 4, 'ind': 'teh', 'eng': 'tea'},
        {'id': 5, 'ind': 'daripada', 'eng': 'than'},
        {'id': 6, 'ind': 'kopi', 'eng': 'coffee'},
      ],
      [
        {'id': 7, 'ind': 'saya', 'eng': 'I'},
        {'id': 8, 'ind': 'kamu', 'eng': 'you'},
        {'id': 9, 'ind': 'dia pria', 'eng': 'he'},
        {'id': 10, 'ind': 'dia perempuan', 'eng': 'she'},
        {'id': 11, 'ind': 'kami', 'eng': 'we'},
        {'id': 12, 'ind': 'mereka', 'eng': 'they'}
      ],
      [
        {'id': 13, 'ind': 'bisakah', 'eng': 'Can'},
        {'id': 14, 'ind': 'anda', 'eng': 'you'},
        {'id': 15, 'ind': 'membantu', 'eng': 'help'},
        {'id': 16, 'ind': 'saya', 'eng': 'me'},
        {'id': 17, 'ind': 'lagi', 'eng': 'again'},
      ]
    ];

    List<Map<String, dynamic>> data = [
      {
        'bahasa_indo': 'saya lebih menyukai teh daripada kopi',
        'bahasa_inggris': 'I more like tea than coffee',
        'kata': words[0],
      },
      {
        'bahasa_indo': 'saya kamu dia laki-laki dia perempuan kami mereka',
        'bahasa_inggris': 'I you he she we they',
        'kata': words[1],
      },
      {
        'bahasa_indo': 'bisakah anda membantu saya lagi',
        'bahasa_inggris': 'Can you help me again',
        'kata': words[2],
      },
    ];

    return Future.value({'data': data});
  }
}
