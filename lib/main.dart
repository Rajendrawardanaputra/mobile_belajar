import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';  // Import paket audioplayers

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Music App'),
      ),
      body: SongList(),
    );
  }
}

class SongList extends StatelessWidget {
  // Daftar lagu sebagai placeholder (gantilah dengan data sesungguhnya dari backend)
  List<String> songs = ['Song 1', 'Song 2', 'Song 3'];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: songs.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(songs[index]),
          onTap: () {
            // Menggunakan path relatif ke file audio
            String audioFilePath = 'assets/audio/${songs[index].toLowerCase()}.mp3';

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SongDetailScreen(song: songs[index], audioPath: audioFilePath),
              ),
            );
          },
        );
      },
    );
  }
}

class SongDetailScreen extends StatelessWidget {
  final String song;
  final String audioPath;

  SongDetailScreen({required this.song, required this.audioPath});

  AudioPlayer audioPlayer = AudioPlayer();  // Instance AudioPlayer

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(song),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Tambahkan logika untuk memutar audio
            playAudio();
          },
          child: Text('Putar Lagu'),
        ),
      ),
    );
  }

  // Fungsi untuk memutar audio
  void playAudio() async {
    int result = await audioPlayer.play(audioPath, isLocal: true);

    if (result == 1) {
      // Pemutaran audio berhasil
      print('Audio dimulai: $audioPath');
    } else {
      // Pemutaran audio gagal
      print('Gagal memulai audio');
    }
  }
}


