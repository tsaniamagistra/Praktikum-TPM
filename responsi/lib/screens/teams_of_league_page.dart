import 'package:flutter/material.dart';
import 'package:football/api/data_source.dart';
import 'package:football/models/team.dart';
import 'package:football/screens/detail_of_team_page.dart';

class LeaguePage extends StatelessWidget {
  final int leagueId;
  final String leagueName;
  const LeaguePage({Key? key, required this.leagueId, required this.leagueName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$leagueName'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _buildTeamsBody(),
      ),
    );
  }

  Widget _buildTeamsBody() {
    return Container(
      child: FutureBuilder(
        future: FootballDataSource.instance.loadTeams(leagueId),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            Team team = Team.fromJson(snapshot.data);
            return _buildSuccessSection(context, team);
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

  Widget _buildSuccessSection(BuildContext context, Team team) {
    return GridView.builder(
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: team.data?.length ?? 0,
        itemBuilder: (context, index) {
          final Data? data = team.data?[index];
          if (data == null) {
            return Container();
          }
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return TeamPage(leagueId: leagueId, teamId: data.idClub!, teamName: data.nameClub!);
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
                        data.logoClubUrl ?? '',
                        height: MediaQuery.of(context).size.height * 0.13,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      data.nameClub ?? '',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      data.headCoach ?? '',
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
