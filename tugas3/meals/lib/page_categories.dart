import 'package:flutter/material.dart';
import 'package:meals/meals_data_source.dart';
import 'package:meals/model_categories.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Categories'),
      ),
      body: _buildCategoriesBody(),
    );
  }

  Widget _buildCategoriesBody() {
    return Container(
      child: FutureBuilder(
        future: MealsDataSource.instance.loadCategories(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            CategoriesModel categoriesModel = CategoriesModel.fromJson(snapshot.data);
            return _buildSuccessSection(categoriesModel);
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

  Widget _buildSuccessSection(CategoriesModel data) {
    return PageView.builder(
      itemCount: data.categories?.length ?? 0,
      itemBuilder: (context, index) {
        final Categories? category = data.categories?[index];
        if (category == null) {
          return Container();
        }
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.network(category.strCategoryThumb ?? '')
                ),
                SizedBox(height: 5),
                Text(category.strCategory ?? ''),
                SizedBox(height: 5),
                Text(category.strCategoryDescription ?? ''),
              ],
            ),
          ),
        );
      },
    );
  }
}
