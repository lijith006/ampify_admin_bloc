import 'dart:io';

import 'package:ampify_admin_bloc/common/app_colors.dart';
import 'package:ampify_admin_bloc/screens/categories/add_categories/bloc/add_category_bloc.dart';
import 'package:ampify_admin_bloc/widgets/custom_button.dart';
import 'package:ampify_admin_bloc/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCategoryScreen extends StatelessWidget {
  final TextEditingController categoryNameController = TextEditingController();

  AddCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCategoryBloc(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColorLight,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
          title: const Text('Add Category'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 500),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocBuilder<AddCategoryBloc, AddCategoryState>(
                      builder: (context, state) {
                        if (state is AddCategoryImagePicked) {
                          return _buildImagePreview(
                              context, File(state.image.path));
                        }
                        return _buildImagePlaceholder(context);
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: categoryNameController,
                      labelText: 'Category Name',
                    ),
                    const SizedBox(height: 20),
                    BlocConsumer<AddCategoryBloc, AddCategoryState>(
                      listener: (context, state) {
                        if (state is AddCategorySuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Category added successfully!')),
                          );
                          categoryNameController.clear();
                        } else if (state is AddCategoryFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.error)),
                          );
                        }
                      },
                      builder: (context, state) {
                        return CustomButton(
                          label: state is AddCategoryLoading
                              ? 'Adding...'
                              : 'Add Category',
                          onTap: () {
                            if (categoryNameController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: Colors.red,
                                    content:
                                        Text('Please enter a category name')),
                              );
                              return;
                            }

                            final addCategoryBloc =
                                context.read<AddCategoryBloc>();

                            if (state is AddCategoryImagePicked) {
                              addCategoryBloc.add(
                                AddCategorySubmitted(
                                  categoryName: categoryNameController.text,
                                  image: state.image,
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Please select an image')),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<AddCategoryBloc>().add(PickImageEvent());
      },
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Icon(Icons.add_a_photo_outlined, size: 50),
        ),
      ),
    );
  }

  Widget _buildImagePreview(BuildContext context, File image) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(
            image,
            fit: BoxFit.cover,
            height: 200,
            width: 200,
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () {
              context.read<AddCategoryBloc>().add(RemoveImageEvent());
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 20),
            ),
          ),
        ),
      ],
    );
  }
}
