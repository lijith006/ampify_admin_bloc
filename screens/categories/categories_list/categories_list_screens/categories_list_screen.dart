import 'package:ampify_admin_bloc/screens/categories/categories_list/bloc/category_bloc.dart';
import 'package:ampify_admin_bloc/screens/categories/categories_list/bloc/category_event.dart';
import 'package:ampify_admin_bloc/screens/categories/categories_list/bloc/category_state.dart';
import 'package:ampify_admin_bloc/screens/categories/edit_categories/edit_categories_screen/edit_categories_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:convert';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryBloc()..add(LoadCategories()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Categories')),
        body: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CategoryError) {
              return Center(child: Text(state.message));
            } else if (state is CategoryLoaded) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3 / 4,
                  ),
                  itemCount: state.categories.length,
                  itemBuilder: (context, index) {
                    final category = state.categories[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditCategoryScreen(category: category),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 3,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                child: Image.memory(
                                  base64Decode(category.image),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  category.name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            return const Center(child: Text('No categories found.'));
          },
        ),
      ),
    );
  }
}
