import 'dart:convert';
import 'package:ampify_admin_bloc/screens/categories/edit_categories/bloc/edit_category_bloc.dart';
import 'package:ampify_admin_bloc/screens/categories/edit_categories/bloc/edit_category_event.dart';
import 'package:ampify_admin_bloc/screens/categories/edit_categories/bloc/edit_category_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ampify_admin_bloc/common/app_colors.dart';
import 'package:ampify_admin_bloc/models/category_model.dart';
import 'package:ampify_admin_bloc/widgets/custom_button.dart';
import 'package:ampify_admin_bloc/widgets/custom_textformfield.dart';

class EditCategoryScreen extends StatelessWidget {
  final Category category;
  const EditCategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditCategoryBloc()
        ..add(LoadCategoryEvent(
            name: category.name, imageBase64: category.image)),
      child: EditCategoryView(categoryId: category.id),
    );
  }
}

class EditCategoryView extends StatefulWidget {
  final String categoryId;
  const EditCategoryView({super.key, required this.categoryId});

  @override
  _EditCategoryViewState createState() => _EditCategoryViewState();
}

class _EditCategoryViewState extends State<EditCategoryView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditCategoryBloc, EditCategoryState>(
      listener: (context, state) {
        if (state is EditCategoryUpdated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Category updated successfully!')),
          );
          Navigator.pop(context);
        } else if (state is EditCategoryDeleted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Category deleted successfully!')),
          );
          Navigator.pop(context);
        } else if (state is EditCategoryError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(title: const Text('Edit Category')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<EditCategoryBloc, EditCategoryState>(
            builder: (context, state) {
              if (state is EditCategoryLoaded) {
                _nameController.text = state.name;
                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () =>
                            context.read<EditCategoryBloc>().pickImage(),
                        child: state.imageBase64 == null
                            ? Container(
                                height: 150,
                                width: 150,
                                color: Colors.grey[300],
                                child: const Icon(Icons.add_a_photo),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.memory(
                                  base64Decode(state.imageBase64!),
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        controller: _nameController,
                        labelText: 'Category Name',
                        validator: (value) => value == null || value.isEmpty
                            ? 'Enter category name'
                            : null,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              label: 'Update',
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<EditCategoryBloc>().add(
                                        UpdateCategoryEvent(
                                          id: widget.categoryId,
                                          name: _nameController.text,
                                          imageBase64: state.imageBase64,
                                        ),
                                      );
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomButton(
                              label: 'Delete',
                              onTap: () => context.read<EditCategoryBloc>().add(
                                    DeleteCategoryEvent(id: widget.categoryId),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
