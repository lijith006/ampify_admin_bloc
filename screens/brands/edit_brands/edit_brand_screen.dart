import 'dart:convert';
import 'package:ampify_admin_bloc/common/app_colors.dart';
import 'package:ampify_admin_bloc/models/brand_model.dart';
import 'package:ampify_admin_bloc/screens/brands/edit_brands/bloc/edit_brand_bloc.dart';
import 'package:ampify_admin_bloc/screens/brands/edit_brands/bloc/edit_brand_event.dart';
import 'package:ampify_admin_bloc/screens/brands/edit_brands/bloc/edit_brand_state.dart';
import 'package:ampify_admin_bloc/widgets/custom_button.dart';
import 'package:ampify_admin_bloc/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditBrandPage extends StatelessWidget {
  final BrandModel brand;

  const EditBrandPage({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditBrandBloc(brand)
        ..add(LoadBrandData(name: brand.name, imageBase64: brand.image)),
      child: const EditBrandView(),
    );
  }
}

class EditBrandView extends StatefulWidget {
  const EditBrandView({super.key});

  @override
  State<EditBrandView> createState() => _EditBrandViewState();
}

class _EditBrandViewState extends State<EditBrandView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(title: const Text('Edit Brand')),
      body: BlocListener<EditBrandBloc, EditBrandState>(
        listener: (context, state) {
          if (state is EditBrandSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.message), backgroundColor: Colors.green),
            );
            Navigator.pop(context);
          } else if (state is EditBrandFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<EditBrandBloc, EditBrandState>(
            builder: (context, state) {
              if (state is EditBrandLoaded) {
                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () =>
                            context.read<EditBrandBloc>().add(PickImage()),
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
                        controller: TextEditingController(text: state.name),
                        //initialValue: state.name,
                        labelText: 'Brand Name',
                        onChanged: (value) => context
                            .read<EditBrandBloc>()
                            .add(UpdateBrandName(value)),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                              child: CustomButton(
                                  label: 'Update',
                                  onTap: () => context
                                      .read<EditBrandBloc>()
                                      .add(UpdateBrand()))),
                          const SizedBox(width: 10),
                          Expanded(
                              child: CustomButton(
                                  label: 'Delete',
                                  onTap: () => context
                                      .read<EditBrandBloc>()
                                      .add(DeleteBrand()))),
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
