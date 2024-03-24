import 'package:flutter/material.dart';
import 'package:penyakit_tanaman/disease_data.dart';
import 'package:url_launcher/url_launcher.dart';

class detailPenyakitTanaman extends StatefulWidget {
  final Diseases penyakit;
  const detailPenyakitTanaman({super.key, required this.penyakit});

  @override
  State<detailPenyakitTanaman> createState() => _detailPenyakitTanamanState();
}

class _detailPenyakitTanamanState extends State<detailPenyakitTanaman> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    final penyakit = widget.penyakit;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(
          'Detail of Disease',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: (isClicked) ? Icon(Icons.favorite) : Icon(Icons.favorite_outline),
            onPressed: () {
              setState(() {
                isClicked = !isClicked;
              });
              SnackBar snackBar = SnackBar(
                content: (isClicked) ? Text('Berhasil menambahkan ke favorit!') : Text('Berhasil menghapus dari favorit!'),
                backgroundColor:
                (isClicked) ? Colors.green : Colors.red,
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        tooltip: 'Increment',
        onPressed: (){
          launchURL(penyakit.imgUrls);
        },
        child: const Icon(Icons.search, color: Colors.white, size: 28),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Image.network(penyakit.imgUrls),
            ),
            Text(penyakit.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),),
            SizedBox(height: 5),
            Text('Disease Name',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),),
            Text(penyakit.name),
            SizedBox(height: 5),
            Text('Plant Name',
              style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),),
            Text(penyakit.plantName),
            SizedBox(height: 5),
            Text('Symptom',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),),
            Text(penyakit.symptom,),
          ],
        ),
      ),
    );
  }
}

Future <void> launchURL(String url) async {
  final Uri _url = Uri.parse(url);
  if(!await launchUrl(_url)){
    throw "Couldn't launch $_url";
  }
}
