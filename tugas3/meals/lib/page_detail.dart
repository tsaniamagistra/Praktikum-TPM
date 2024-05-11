import 'package:flutter/material.dart';
import 'package:meals/meals_data_source.dart';
import 'package:meals/model_detail.dart';

class DetailPage extends StatelessWidget {
  final String idMeal;
  const DetailPage({Key? key, required this.idMeal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Detail'),
      ),
      body: SingleChildScrollView(
        child: _buildDetailBody(),
      ),
    );
  }

  Widget _buildDetailBody() {
    return FutureBuilder(
      future: MealsDataSource.instance.loadDetail(idMeal),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return _buildErrorSection();
        }
        if (snapshot.hasData) {
          DetailModel mealsModel = DetailModel.fromJson(snapshot.data);
          return _buildSuccessSection(context, mealsModel);
        }
        return _buildLoadingSection();
      },
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

  Widget _buildSuccessSection(BuildContext context, DetailModel data) {
    final Meals? detail = data.meals?.first;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Image.network(
                  detail?.strMealThumb ?? '',
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
                SizedBox(height: 8),
                Text(
                  detail?.strMeal ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Ingredients:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          _buildIngredientsList(detail),
          SizedBox(height: 8),
          Text(
            'Instructions:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            detail?.strInstructions ?? '',
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientsList(Meals? detail) {
    List<String?> ingredients = _extractIngredients(detail);
    List<String?> measures = _extractMeasures(detail);

    List<Widget> ingredientWidgets = List.generate(
      ingredients.length,
          (index) => Text('- ${ingredients[index]}: ${measures[index]}'),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: ingredientWidgets,
    );
  }

  List<String?> _extractIngredients(Meals? detail) {
    List<String?> ingredients = [];
    if (detail != null) {
      if (detail.strIngredient1 != null && detail.strIngredient1!.isNotEmpty) {
        ingredients.add(detail.strIngredient1);
      }
      if (detail.strIngredient2 != null && detail.strIngredient2!.isNotEmpty) {
        ingredients.add(detail.strIngredient2);
      }
      if (detail.strIngredient3 != null && detail.strIngredient3!.isNotEmpty) {
        ingredients.add(detail.strIngredient3);
      }
      if (detail.strIngredient4 != null && detail.strIngredient4!.isNotEmpty) {
        ingredients.add(detail.strIngredient4);
      }
      if (detail.strIngredient5 != null && detail.strIngredient5!.isNotEmpty) {
        ingredients.add(detail.strIngredient5);
      }
      if (detail.strIngredient6 != null && detail.strIngredient6!.isNotEmpty) {
        ingredients.add(detail.strIngredient6);
      }
      if (detail.strIngredient7 != null && detail.strIngredient7!.isNotEmpty) {
        ingredients.add(detail.strIngredient7);
      }
      if (detail.strIngredient8 != null && detail.strIngredient8!.isNotEmpty) {
        ingredients.add(detail.strIngredient8);
      }
      if (detail.strIngredient9 != null && detail.strIngredient9!.isNotEmpty) {
        ingredients.add(detail.strIngredient9);
      }
      if (detail.strIngredient10 != null && detail.strIngredient10!.isNotEmpty) {
        ingredients.add(detail.strIngredient10);
      }
      if (detail.strIngredient11 != null && detail.strIngredient11!.isNotEmpty) {
        ingredients.add(detail.strIngredient11);
      }
      if (detail.strIngredient12 != null && detail.strIngredient12!.isNotEmpty) {
        ingredients.add(detail.strIngredient12);
      }
      if (detail.strIngredient13 != null && detail.strIngredient13!.isNotEmpty) {
        ingredients.add(detail.strIngredient13);
      }
      if (detail.strIngredient14 != null && detail.strIngredient14!.isNotEmpty) {
        ingredients.add(detail.strIngredient14);
      }
    }
    return ingredients;
  }


  List<String?> _extractMeasures(Meals? detail) {
    List<String?> measures = [];
    if (detail != null) {
      if (detail.strMeasure1 != null && detail.strMeasure1!.isNotEmpty) {
        measures.add(detail.strMeasure1);
      }
      if (detail.strMeasure2 != null && detail.strMeasure2!.isNotEmpty) {
        measures.add(detail.strMeasure2);
      }
      if (detail.strMeasure3 != null && detail.strMeasure3!.isNotEmpty) {
        measures.add(detail.strMeasure3);
      }
      if (detail.strMeasure4 != null && detail.strMeasure4!.isNotEmpty) {
        measures.add(detail.strMeasure4);
      }
      if (detail.strMeasure5 != null && detail.strMeasure5!.isNotEmpty) {
        measures.add(detail.strMeasure5);
      }
      if (detail.strMeasure6 != null && detail.strMeasure6!.isNotEmpty) {
        measures.add(detail.strMeasure6);
      }
      if (detail.strMeasure7 != null && detail.strMeasure7!.isNotEmpty) {
        measures.add(detail.strMeasure7);
      }
      if (detail.strMeasure8 != null && detail.strMeasure8!.isNotEmpty) {
        measures.add(detail.strMeasure8);
      }
      if (detail.strMeasure9 != null && detail.strMeasure9!.isNotEmpty) {
        measures.add(detail.strMeasure9);
      }
      if (detail.strMeasure10 != null && detail.strMeasure10!.isNotEmpty) {
        measures.add(detail.strMeasure10);
      }
      if (detail.strMeasure11 != null && detail.strMeasure11!.isNotEmpty) {
        measures.add(detail.strMeasure11);
      }
      if (detail.strMeasure12 != null && detail.strMeasure12!.isNotEmpty) {
        measures.add(detail.strMeasure12);
      }
      if (detail.strMeasure13 != null && detail.strMeasure13!.isNotEmpty) {
        measures.add(detail.strMeasure13);
      }
      if (detail.strMeasure14 != null && detail.strMeasure14!.isNotEmpty) {
        measures.add(detail.strMeasure14);
      }
    }
    return measures;
  }

}
