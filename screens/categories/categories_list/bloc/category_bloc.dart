import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'category_event.dart';
import 'category_state.dart';
import 'package:ampify_admin_bloc/models/category_model.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  CategoryBloc() : super(CategoryInitial()) {
    on<LoadCategories>(_onLoadCategories);
    on<UpdateCategory>(_onUpdateCategory);
    on<DeleteCategory>(_onDeleteCategory);
  }

  Future<void> _onLoadCategories(
      LoadCategories event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());
    try {
      final snapshot = await firestore.collection('categories').get();
      final categories = snapshot.docs
          // ignore: unnecessary_cast
          .map((doc) => Category.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError('Failed to load categories.'));
    }
  }

  Future<void> _onUpdateCategory(
      UpdateCategory event, Emitter<CategoryState> emit) async {
    try {
      await firestore.collection('categories').doc(event.category.id).update({
        'name': event.category.name,
        'image': event.category.image,
      });
      add(LoadCategories());
    } catch (e) {
      emit(CategoryError('Failed to update category.'));
    }
  }

  Future<void> _onDeleteCategory(
      DeleteCategory event, Emitter<CategoryState> emit) async {
    try {
      final productsSnapshot = await firestore
          .collection('products')
          .where('categoryId', isEqualTo: event.categoryId)
          .get();

      if (productsSnapshot.docs.isNotEmpty) {
        emit(CategoryError(
            'Cannot delete category: Products exist under this category.'));
        return;
      }

      await firestore.collection('categories').doc(event.categoryId).delete();
      add(LoadCategories());
    } catch (e) {
      emit(CategoryError('Failed to delete category.'));
    }
  }
}
