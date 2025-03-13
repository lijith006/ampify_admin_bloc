import 'package:ampify_admin_bloc/screens/productss/edit_products/bloc/edit_product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ampify_admin_bloc/common/app_colors.dart';
import 'package:ampify_admin_bloc/widgets/custom_button.dart';
import 'package:ampify_admin_bloc/common/custom_text_styles.dart';
import 'package:ampify_admin_bloc/widgets/custom_textformfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProductPage extends StatelessWidget {
  final QueryDocumentSnapshot product;

  const EditProductPage(
    this.product, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProductBloc(product)..add(LoadProduct(product)),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        body: BlocConsumer<EditProductBloc, EditProductState>(
          listener: (context, state) {
            if (state is EditProductSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
              Navigator.pop(context);
            } else if (state is EditProductError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is EditProductLoaded) {
              return _buildLoadedState(context, state);
            } else if (state is EditProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Center(child: Text('Something went wrong!'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildLoadedState(BuildContext context, EditProductLoaded state) {
    final formKey = GlobalKey<FormState>();
    final itemNameController = TextEditingController(text: state.itemName);
    final priceController = TextEditingController(text: state.price);
    final descriptionController =
        TextEditingController(text: state.description);

    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Text(
                  'Edit products',
                  style: CustomTextStyles.boldTextFieldStyle(),
                ),
                const SizedBox(height: 10),
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: state.selectedImages.length + 1,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    if (index == state.selectedImages.length) {
                      return GestureDetector(
                        onTap: () =>
                            context.read<EditProductBloc>().add(PickImage()),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.add_a_photo),
                        ),
                      );
                    }
                    final image = state.selectedImages[index];
                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.memory(image, fit: BoxFit.cover),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: GestureDetector(
                            onTap: () => context
                                .read<EditProductBloc>()
                                .add(RemoveImage(index)),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  controller: itemNameController,
                  labelText: 'Product name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a product name.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  maxLines: 4,
                  controller: descriptionController,
                  labelText: 'Product description',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a product description.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  controller: priceController,
                  labelText: 'Product price',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a product price.";
                    }
                    if (double.tryParse(value) == null) {
                      return "Please enter a valid price.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                StreamBuilder<QuerySnapshot>(
                  stream: context.read<EditProductBloc>().fetchCategories(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    return DropdownButtonFormField<String>(
                      value: state.selectedCategoryId,
                      items: snapshot.data!.docs.map((doc) {
                        return DropdownMenuItem(
                          value: doc.id,
                          child: Text(doc['name']),
                        );
                      }).toList(),
                      onChanged: (value) {
                        context.read<EditProductBloc>().add(UpdateProduct(
                              productId: product.id,
                              itemName: itemNameController.text.trim(),
                              price: priceController.text.trim(),
                              description: descriptionController.text.trim(),
                              selectedCategoryId: value,
                              selectedBrandId: state.selectedBrandId,
                            ));
                      },
                      decoration:
                          const InputDecoration(labelText: 'Select Category'),
                    );
                  },
                ),
                const SizedBox(height: 16),
                StreamBuilder<QuerySnapshot>(
                  stream: context.read<EditProductBloc>().fetchBrands(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    return DropdownButtonFormField<String>(
                      value: state.selectedBrandId,
                      items: snapshot.data!.docs.map((doc) {
                        return DropdownMenuItem(
                          value: doc.id,
                          child: Text(doc['name']),
                        );
                      }).toList(),
                      onChanged: (value) {
                        context.read<EditProductBloc>().add(UpdateProduct(
                              productId: product.id,
                              itemName: itemNameController.text.trim(),
                              price: priceController.text.trim(),
                              description: descriptionController.text.trim(),
                              selectedCategoryId: state.selectedCategoryId,
                              selectedBrandId: value,
                            ));
                      },
                      decoration:
                          const InputDecoration(labelText: 'Select Brand'),
                    );
                  },
                ),
                const SizedBox(height: 16),
                CustomButton(
                  label: 'Update Product',
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      context.read<EditProductBloc>().add(UpdateProduct(
                            productId: product.id,
                            itemName: itemNameController.text.trim(),
                            price: priceController.text.trim(),
                            description: descriptionController.text.trim(),
                            selectedCategoryId: state.selectedCategoryId,
                            selectedBrandId: state.selectedBrandId,
                          ));
                    }
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
