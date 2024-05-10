import 'package:meals/base_network.dart';

class MealsDataSource {
  static MealsDataSource instance = MealsDataSource();

  Future<Map<String, dynamic>> loadCategories() {
    return BaseNetwork.get(
        'categories.php');
  }

  Future<Map<String, dynamic>> loadMeals(String category) {
    return BaseNetwork.get(
        'filter.php?c=$category');
  }

  Future<Map<String, dynamic>> loadDetail(String meal) {
    return BaseNetwork.get(
        'filter.php?c=$meal');
  }
}
