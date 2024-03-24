import 'package:flutter/material.dart';
import 'package:penyakit_tanaman/detail_penyakit_tanaman.dart';
import 'package:penyakit_tanaman/disease_data.dart';

class daftarPenyakitTanaman extends StatefulWidget {
  const daftarPenyakitTanaman({super.key});

  @override
  State<daftarPenyakitTanaman> createState() => _daftarPenyakitTanamanState();
}

class _daftarPenyakitTanamanState extends State<daftarPenyakitTanaman> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(
          'Plant Diseases',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: listDisease.length,
        itemBuilder: (context, index) {
          final Diseases penyakit = listDisease[index];
          return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return detailPenyakitTanaman(penyakit: penyakit);
              }));
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Image.network(penyakit.imgUrls),),
                    SizedBox(height: 5),
                    Text(penyakit.name),
                  ],
                ),
              )
            ),
          );
        },
      ),
    );
  }
}
