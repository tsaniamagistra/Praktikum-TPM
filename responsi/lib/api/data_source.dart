import 'package:football/api/base_network.dart';

class FootballDataSource {
  static FootballDataSource instance = FootballDataSource();

  Future<Map<String, dynamic>> loadLeagues() {
    return BaseNetwork.get(
        '');
  }

  Future<Map<String, dynamic>> loadTeams(int league) {
    return BaseNetwork.get(
        '$league');
  }

  Future<Map<String, dynamic>> loadDetail(int league, int team) {
    return BaseNetwork.get(
        '$league/$team');
  }
}
