import 'package:ampify_admin_bloc/widgets/custom_button.dart';
import 'package:ampify_admin_bloc/widgets/custom_textformfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddBrand extends StatelessWidget {
  final TextEditingController brandNameController = TextEditingController();

  AddBrand({super.key});

  Future<void> addBrand(String name) async {
    await FirebaseFirestore.instance.collection('brands').add({'name': name});
    print('Brand added !');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        title: const Text('Add brands'),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/background.jpg'),
          fit: BoxFit.cover,
        )),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextFormField(
                      controller: brandNameController,
                      labelText: 'Category name'),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      label: 'Add brand',
                      onTap: () {
                        addBrand(brandNameController.text);
                        brandNameController.clear();
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
