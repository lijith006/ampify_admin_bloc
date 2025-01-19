import 'package:ampify_admin_bloc/widgets/custom_button.dart';
import 'package:ampify_admin_bloc/widgets/custom_textformfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddCategory extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();

  Future<void> addCategory(String name) async {
    await FirebaseFirestore.instance
        .collection('categories')
        .add({'name': name});
    print('Category added!');
    //   ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text('Category added succesfully')));
  }

  AddCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        title: const Text('Add categories'),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextFormField(
                      controller: nameController, labelText: 'Category name'),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      label: 'Add category',
                      onTap: () {
                        addCategory(nameController.text);
                        nameController.clear();
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
