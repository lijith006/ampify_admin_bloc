// import 'dart:io';

// import 'package:ampify_admin_bloc/common/app_colors.dart';
// import 'package:ampify_admin_bloc/screens/brands/add_brands/bloc/brand_add_bloc.dart';
// import 'package:ampify_admin_bloc/screens/brands/add_brands/bloc/brand_add_event.dart';
// import 'package:ampify_admin_bloc/screens/brands/add_brands/bloc/brand_add_state.dart';
// import 'package:ampify_admin_bloc/widgets/custom_button.dart';
// import 'package:ampify_admin_bloc/widgets/custom_textformfield.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class AddBrand extends StatelessWidget {
//   AddBrand({Key? key}) : super(key: key);

//   final TextEditingController brandNameController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColorLight,
//       appBar: AppBar(
//         title: const Text('Add Brand'),
//         backgroundColor: AppColors.backgroundColorLight,
//       ),
//       body: BlocProvider(
//         create: (context) => BrandAddBloc(),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: BlocConsumer<BrandAddBloc, BrandAddState>(
//             listener: (context, state) {
//               if (state is BrandAddSuccess) {
//                 // Show success Snackbar
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text('Brand added successfully!'),
//                     backgroundColor: Colors.green,
//                   ),
//                 );

//                 // Clear text field and reset image selection
//                 brandNameController.clear();
//                 context.read<BrandAddBloc>().add(RemoveImageEvent());
//               }

//               if (state is BrandAddError) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text(state.message),
//                     backgroundColor: Colors.red,
//                   ),
//                 );
//               }
//             },
//             builder: (context, state) {
//               final bloc = BlocProvider.of<BrandAddBloc>(context);

//               File? selectedImage;
//               if (state is BrandImageSelected) {
//                 selectedImage = File(state.image.path);
//               } else if (state is BrandImageRemoved) {
//                 selectedImage = null;
//               }

//               return Column(
//                 children: [
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           // Image Selection
//                           Container(
//                             height: 200,
//                             width: 200,
//                             decoration: BoxDecoration(
//                               border: Border.all(color: Colors.grey),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: selectedImage == null
//                                 ? GestureDetector(
//                                     onTap: () => bloc.add(PickImageEvent()),
//                                     child: const Center(
//                                       child: Icon(
//                                         Icons.add_a_photo_outlined,
//                                         size: 50,
//                                       ),
//                                     ),
//                                   )
//                                 : Stack(
//                                     children: [
//                                       ClipRRect(
//                                         borderRadius: BorderRadius.circular(8),
//                                         child: Image.file(
//                                           selectedImage,
//                                           fit: BoxFit.cover,
//                                           height: 200,
//                                           width: 200,
//                                         ),
//                                       ),
//                                       Positioned(
//                                         top: 4,
//                                         right: 4,
//                                         child: GestureDetector(
//                                           onTap: () =>
//                                               bloc.add(RemoveImageEvent()),
//                                           child: Container(
//                                             decoration: const BoxDecoration(
//                                               color: Colors.red,
//                                               shape: BoxShape.circle,
//                                             ),
//                                             child: const Icon(
//                                               Icons.close,
//                                               color: Colors.white,
//                                               size: 20,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                           ),
//                           const SizedBox(height: 20),

//                           // Brand Name Input Field
//                           CustomTextFormField(
//                             controller: brandNameController,
//                             labelText: 'Brand Name',
//                             prefixicon: const Icon(Icons.business),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Brand name is required';
//                               }
//                               return null;
//                             },
//                             onChanged: (value) {
//                               bloc.add(BrandNameChanged(value));
//                             },
//                           ),
//                           const SizedBox(height: 20),

//                           // Submit Button
//                           CustomButton(
//                             label: 'Add Brand',
//                             onTap: () {
//                               if (brandNameController.text.isNotEmpty &&
//                                   selectedImage != null) {
//                                 bloc.add(AddBrandEvent());
//                               } else {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                       backgroundColor: Colors.red,
//                                       content: Text(
//                                           'Please enter brand name and select an image')),
//                                 );
//                               }
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
//---------------------------------------------------
import 'dart:io';

import 'package:ampify_admin_bloc/common/app_colors.dart';
import 'package:ampify_admin_bloc/screens/brands/add_brands/bloc/brand_add_bloc.dart';
import 'package:ampify_admin_bloc/screens/brands/add_brands/bloc/brand_add_event.dart';
import 'package:ampify_admin_bloc/screens/brands/add_brands/bloc/brand_add_state.dart';
import 'package:ampify_admin_bloc/widgets/custom_button.dart';
import 'package:ampify_admin_bloc/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBrand extends StatelessWidget {
  AddBrand({Key? key}) : super(key: key);

  final TextEditingController brandNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorLight,
      appBar: AppBar(
        title: const Text('Add Brand'),
        backgroundColor: AppColors.backgroundColorLight,
      ),
      body: BlocProvider(
        create: (context) => BrandAddBloc(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<BrandAddBloc, BrandAddState>(
            listener: (context, state) {
              if (state is BrandAddSuccess) {
                // Show success Snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Brand added successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );

                // Clear text field and reset image selection
                brandNameController.clear();
                context.read<BrandAddBloc>().add(RemoveImageEvent());
              }

              if (state is BrandAddError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              final bloc = BlocProvider.of<BrandAddBloc>(context);

              File? selectedImage;
              if (state is BrandImageSelected) {
                selectedImage = File(state.image.path);
              } else if (state is BrandImageRemoved) {
                selectedImage = null;
              }

              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 500),
                          child: Column(
                            children: [
                              // Image Selection
                              Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: selectedImage == null
                                    ? GestureDetector(
                                        onTap: () => bloc.add(PickImageEvent()),
                                        child: const Center(
                                          child: Icon(
                                            Icons.add_a_photo_outlined,
                                            size: 50,
                                          ),
                                        ),
                                      )
                                    : Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.file(
                                              selectedImage,
                                              fit: BoxFit.cover,
                                              height: 200,
                                              width: 200,
                                            ),
                                          ),
                                          Positioned(
                                            top: 4,
                                            right: 4,
                                            child: GestureDetector(
                                              onTap: () =>
                                                  bloc.add(RemoveImageEvent()),
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
                                      ),
                              ),
                              const SizedBox(height: 20),

                              // Brand Name Input Field
                              CustomTextFormField(
                                controller: brandNameController,
                                labelText: 'Brand Name',
                                prefixicon: const Icon(Icons.business),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Brand name is required';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  bloc.add(BrandNameChanged(value));
                                },
                              ),
                              const SizedBox(height: 20),

                              // Submit Button
                              CustomButton(
                                label: 'Add Brand',
                                onTap: () {
                                  if (brandNameController.text.isNotEmpty &&
                                      selectedImage != null) {
                                    bloc.add(AddBrandEvent());
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                              'Please enter brand name and select an image')),
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
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
