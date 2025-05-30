// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../common/app_colors.dart';
// import '../../../../common/custom_text_styles.dart';
// import '../../../../widgets/custom_button.dart';
// import '../../../../widgets/custom_drop_down.dart';
// import '../../../../widgets/custom_textformfield.dart';
// import '../../../../widgets/validators_widget.dart';
// import '../bloc/add_product_bloc.dart';
// import '../bloc/add_product_event.dart';

// class AddProduct extends StatefulWidget {
//   AddProduct({super.key});

//   @override
//   State<AddProduct> createState() => _AddProductState();
// }

// class _AddProductState extends State<AddProduct> {
//   final TextEditingController itemNameController = TextEditingController();

//   final TextEditingController priceController = TextEditingController();

//   final TextEditingController descriptionController = TextEditingController();

//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   String? selectedCategoryId;

//   String? selectedBrandId;

//   Stream<QuerySnapshot> _fetchCategories() {
//     return FirebaseFirestore.instance.collection('categories').snapshots();
//   }

//   Stream<QuerySnapshot> _fetchBrands() {
//     return FirebaseFirestore.instance.collection('brands').snapshots();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => AddProductBloc(),
//       child: Scaffold(
//         backgroundColor: AppColors.backgroundColorLight,
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           shadowColor: Colors.transparent,
//         ),
//         body: BlocConsumer<AddProductBloc, AddProductState>(
//           listener: (context, state) {
//             if (state is AddProductErrorState) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   backgroundColor: Colors.red,
//                   content: Text(state.error),
//                 ),
//               );
//             } else if (state is AddProductSuccessState) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   backgroundColor: Colors.green,
//                   content: Text(state.message),
//                 ),
//               );
//               Navigator.pop(context);
//             }
//           },
//           builder: (context, state) {
//             return SingleChildScrollView(
//               child: Container(
//                 child: Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: Form(
//                     key: formKey,
//                     child: Column(
//                       children: [
//                         // Product Image
//                         Text(
//                           'Add products',
//                           style: CustomTextStyles.boldTextFieldStyle(),
//                         ),
//                         const SizedBox(height: 10),

//                         // Image grid
//                         GridView.builder(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           gridDelegate:
//                               const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 4,
//                             crossAxisSpacing: 8,
//                             mainAxisSpacing: 8,
//                           ),
//                           itemCount: state is ImagesPickedState
//                               ? state.images.length < 4
//                                   ? state.images.length + 1
//                                   : state.images.length
//                               : 1,
//                           itemBuilder: (context, index) {
//                             if (index ==
//                                     (state is ImagesPickedState
//                                         ? state.images.length
//                                         : 0) &&
//                                 (state is ImagesPickedState
//                                     ? state.images.length < 4
//                                     : true)) {
//                               return GestureDetector(
//                                 onTap: () => context
//                                     .read<AddProductBloc>()
//                                     .add(PickProductImagesEvent()),
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     color: AppColors.backgroundColorLight,
//                                     border: Border.all(
//                                         color: const Color.fromARGB(
//                                             255, 138, 136, 136)),
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   child: const Icon(Icons.add_a_photo_outlined),
//                                 ),
//                               );
//                             }

//                             return Stack(
//                               children: [
//                                 Container(
//                                   decoration: BoxDecoration(
//                                     border: Border.all(color: Colors.grey),
//                                     borderRadius: BorderRadius.circular(8),
//                                     image: DecorationImage(
//                                       image: MemoryImage(
//                                           (state as ImagesPickedState)
//                                               .images[index]),
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ),
//                                 Positioned(
//                                   top: 4,
//                                   right: 4,
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       // Remove image
//                                       context
//                                           .read<AddProductBloc>()
//                                           .add(RemoveImageEvent(index));
//                                     },
//                                     child: Container(
//                                       decoration: const BoxDecoration(
//                                         color: Colors.red,
//                                         shape: BoxShape.circle,
//                                       ),
//                                       child: const Icon(
//                                         Icons.close,
//                                         color: AppColors.light,
//                                         size: 20,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             );
//                           },
//                         ),

//                         const SizedBox(height: 16),

//                         // Item Name
//                         CustomTextFormField(
//                           controller: itemNameController,
//                           labelText: 'Product name',
//                           validator: (value) {
//                             return Validators.validateField(value,
//                                 emptyErrorMessage:
//                                     'Please enter a product name');
//                           },
//                         ),
//                         const SizedBox(height: 16),

//                         // Product Description
//                         CustomTextFormField(
//                           maxLines: 4,
//                           controller: descriptionController,
//                           labelText: 'Product description',
//                         ),
//                         const SizedBox(height: 16),

//                         // Product Price
//                         CustomTextFormField(
//                           controller: priceController,
//                           labelText: 'Product price',
//                           keyboardType: const TextInputType.numberWithOptions(
//                               decimal: true),
//                           inputFormatters: [
//                             FilteringTextInputFormatter.digitsOnly
//                           ],
//                         ),
//                         const SizedBox(height: 16),

//                         Row(
//                           children: [
//                             Expanded(
//                               child: CustomDropdown(
//                                 stream: _fetchCategories(),
//                                 label: 'Select Category',
//                                 selectedValue: selectedCategoryId,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     selectedCategoryId = value;
//                                   });
//                                 },
//                               ),
//                             ),
//                             const SizedBox(width: 5),
//                             Expanded(
//                               child: CustomDropdown(
//                                 stream: _fetchBrands(),
//                                 label: 'Select Brand',
//                                 selectedValue: selectedBrandId,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     selectedBrandId = value;
//                                   });
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 24),

//                         // Submit Button
//                         CustomButton(
//                           label: 'Add Product',
//                           onTap: () {
//                             if (formKey.currentState!.validate()) {
//                               context.read<AddProductBloc>().add(
//                                     AddProductEvents(
//                                       itemName: itemNameController.text.trim(),
//                                       price: priceController.text.trim(),
//                                       description:
//                                           descriptionController.text.trim(),
//                                       selectedCategoryId: selectedCategoryId,
//                                       selectedBrandId: selectedBrandId,
//                                       images: state is ImagesPickedState
//                                           ? state.images
//                                           : [],
//                                     ),
//                                   );
//                             }
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//------------------------------------------------------------------------
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/custom_text_styles.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../../../../widgets/custom_textformfield.dart';
import '../../../../widgets/validators_widget.dart';
import '../bloc/add_product_bloc.dart';
import '../bloc/add_product_event.dart';

class AddProduct extends StatefulWidget {
  AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController itemNameController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? selectedCategoryId;

  String? selectedBrandId;

  Stream<QuerySnapshot> _fetchCategories() {
    return FirebaseFirestore.instance.collection('categories').snapshots();
  }

  Stream<QuerySnapshot> _fetchBrands() {
    return FirebaseFirestore.instance.collection('brands').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddProductBloc(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColorLight,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        body: BlocConsumer<AddProductBloc, AddProductState>(
          listener: (context, state) {
            if (state is AddProductErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(state.error),
                ),
              );
            } else if (state is AddProductSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(state.message),
                ),
              );
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 600),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              // Product Image
                              Text(
                                'Add products',
                                style: CustomTextStyles.boldTextFieldStyle(),
                              ),
                              const SizedBox(height: 10),

                              // Image grid
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                  ),
                                  itemCount: state is ImagesPickedState
                                      ? state.images.length < 4
                                          ? state.images.length + 1
                                          : state.images.length
                                      : 1,
                                  itemBuilder: (context, index) {
                                    if (index ==
                                            (state is ImagesPickedState
                                                ? state.images.length
                                                : 0) &&
                                        (state is ImagesPickedState
                                            ? state.images.length < 4
                                            : true)) {
                                      return GestureDetector(
                                        onTap: () => context
                                            .read<AddProductBloc>()
                                            .add(PickProductImagesEvent()),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color:
                                                AppColors.backgroundColorLight,
                                            border: Border.all(
                                                color: const Color.fromARGB(
                                                    255, 138, 136, 136)),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: const Icon(
                                              Icons.add_a_photo_outlined),
                                        ),
                                      );
                                    }

                                    return Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            image: DecorationImage(
                                              image: MemoryImage(
                                                  (state as ImagesPickedState)
                                                      .images[index]),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 4,
                                          right: 4,
                                          child: GestureDetector(
                                            onTap: () {
                                              // Remove image
                                              context
                                                  .read<AddProductBloc>()
                                                  .add(RemoveImageEvent(index));
                                            },
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.close,
                                                color: AppColors.light,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),

                              const SizedBox(height: 16),

                              // Item Name
                              CustomTextFormField(
                                controller: itemNameController,
                                labelText: 'Product name',
                                validator: (value) {
                                  return Validators.validateField(value,
                                      emptyErrorMessage:
                                          'Please enter a product name');
                                },
                              ),
                              const SizedBox(height: 16),

                              // Product Description
                              CustomTextFormField(
                                maxLines: 4,
                                controller: descriptionController,
                                labelText: 'Product description',
                              ),
                              const SizedBox(height: 16),

                              // Product Price
                              CustomTextFormField(
                                controller: priceController,
                                labelText: 'Product price',
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                              ),
                              const SizedBox(height: 16),

                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: CustomDropdown(
                                        stream: _fetchCategories(),
                                        label: 'Select Category',
                                        selectedValue: selectedCategoryId,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedCategoryId = value;
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: CustomDropdown(
                                        stream: _fetchBrands(),
                                        label: 'Select Brand',
                                        selectedValue: selectedBrandId,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedBrandId = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),

                              // Submit Button
                              CustomButton(
                                label: 'Add Product',
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    context.read<AddProductBloc>().add(
                                          AddProductEvents(
                                            itemName:
                                                itemNameController.text.trim(),
                                            price: priceController.text.trim(),
                                            description: descriptionController
                                                .text
                                                .trim(),
                                            selectedCategoryId:
                                                selectedCategoryId,
                                            selectedBrandId: selectedBrandId,
                                            images: state is ImagesPickedState
                                                ? state.images
                                                : [],
                                          ),
                                        );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
