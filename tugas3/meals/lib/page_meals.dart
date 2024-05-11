import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:meals/meals_data_source.dart';
import 'package:meals/model_meals.dart';
import 'package:meals/page_detail.dart';

class MealsPage extends StatelessWidget {
  final String category;
  const MealsPage({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$category Meals'),
      ),
      body: _buildMealsBody(),
    );
  }

  Widget _buildMealsBody() {
    return FutureBuilder(
      future: MealsDataSource.instance.loadMeals(category),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return _buildErrorSection();
        }
        if (snapshot.hasData) {
          MealsModel mealsModel = MealsModel.fromJson(snapshot.data);
          return _buildSuccessSection(context, mealsModel);
        }
        return _buildLoadingSection();
      },
    );
  }

  Widget _buildErrorSection() {
    return Center(
      child: Text("Error"),
    );
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(BuildContext context, MealsModel data) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      itemCount: data.meals?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        final Meals? meal = data.meals?[index];
        if (meal == null) {
          return Container();
        }
        return InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DetailPage(idMeal: meal.idMeal!);
            }));
          },
          child: Card(
            child: Column(
              children: [
                Image.network(
                  meal.strMealThumb ?? '',
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    meal.strMeal ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      staggeredTileBuilder: (int index) =>
          StaggeredTile.fit(1),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
}
