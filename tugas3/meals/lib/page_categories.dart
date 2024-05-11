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
            CategoriesModel categoriesModel =
                CategoriesModel.fromJson(snapshot.data);
            return _buildSuccessSection(context, categoriesModel);
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

  Widget _buildSuccessSection(BuildContext context, CategoriesModel data) {
    return ListView.builder(
      itemCount: data.categories?.length ?? 0,
      itemBuilder: (context, index) {
        final Categories? category = data.categories?[index];
        if (category == null) {
          return Container();
        }
        return InkWell(
          onTap: () {
            _showCategoryDetailsDialog(context, category);
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    category.strCategoryThumb ?? '',
                    height: 106,
                  ),
                  SizedBox(height: 5),
                  Text(
                    category.strCategory ?? '',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                      _truncateDescription(category.strCategoryDescription) ??
                          '',
                      textAlign: TextAlign.justify),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String? _truncateDescription(String? description) {
    if (description != null && description.length > 170) {
      return description.substring(0, 170) + '...';
    }
    return description;
  }

  void _showCategoryDetailsDialog(BuildContext context, Categories category) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(
                  category.strCategoryThumb ?? '',
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            category.strCategory ?? '',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {

                            },
                            child: Text(
                              'See Meals >>',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(category.strCategoryDescription ?? '',
                          textAlign: TextAlign.justify),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
