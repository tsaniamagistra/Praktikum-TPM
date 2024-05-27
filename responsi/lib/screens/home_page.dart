import 'package:flutter/material.dart';
import 'package:football/api/data_source.dart';
import 'package:football/models/league.dart';
import 'package:football/screens/teams_of_league_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leagues'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _buildLeaguesBody(),
      ),
    );
  }

  Widget _buildLeaguesBody() {
    return Container(
      child: FutureBuilder(
        future: FootballDataSource.instance.loadLeagues(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            League league = League.fromJson(snapshot.data);
            return _buildSuccessSection(context, league);
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

  Widget _buildSuccessSection(BuildContext context, League league) {
    return GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: league.data?.length ?? 0,
        itemBuilder: (context, index) {
          final Data? data = league.data?[index];
          if (data == null) {
            return Container();
          }
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LeaguePage(leagueId: data.idLeague!, leagueName: data.leagueName!);
              }));
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.network(
                        data.logoLeagueUrl ?? '',
                        height: MediaQuery.of(context).size.height * 0.13,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      data.leagueName ?? '',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      data.country ?? '',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
