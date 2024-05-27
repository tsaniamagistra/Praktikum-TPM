import 'package:flutter/material.dart';
import 'package:football/api/data_source.dart';
import 'package:football/models/detail.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamPage extends StatefulWidget {
  final int leagueId;
  final int teamId;
  final String teamName;
  const TeamPage(
      {Key? key,
      required this.leagueId,
      required this.teamId,
      required this.teamName})
      : super(key: key);

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.teamName),
        actions: <Widget>[
          IconButton(
            icon: (isClicked) ? Icon(Icons.favorite, color: Colors.pinkAccent,) : Icon(Icons.favorite_outline,),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _buildDetailBody(),
      ),
    );
  }

  Widget _buildDetailBody() {
    return Container(
      child: FutureBuilder(
        future: FootballDataSource.instance
            .loadDetail(widget.leagueId, widget.teamId),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            Detail detail = Detail.fromJson(snapshot.data);
            return _buildSuccessSection(context, detail);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(BuildContext context, Detail detail) {
    final Data? data = detail.data;
    return Center(
      child: Column(
        children: [
          Image.network(data?.logoClubUrl ?? ''),
          SizedBox(height: 5),
          Text(
            data?.nameClub ?? '',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text('Head Coach',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(height: 5),
          Text(
            data?.nameClub ?? '',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          SizedBox(height: 5),
          Text('Captain',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(height: 5),
          Text(
            data?.captainName ?? '',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          SizedBox(height: 5),
          Text('Stadium Name',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(height: 5),
          Text(
            data?.stadiumName ?? '',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          SizedBox(height: 5),
          Text('Logo URL',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(height: 5),
          ElevatedButton(
              onPressed: (){
                launchURL(data?.logoClubUrl ?? '');
              }, child: Icon(Icons.arrow_outward),
          )
        ],
      ),
    );
  }
}

Future<void> launchURL(String url) async {
  final Uri _url = Uri.parse(url);
  if (!await launchUrl(_url)) {
    throw "Couldn't launch $_url";
  }
}
