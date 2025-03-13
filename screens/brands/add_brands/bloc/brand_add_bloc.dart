import 'dart:convert';
import 'package:ampify_admin_bloc/models/brand_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'brand_add_event.dart';
import 'brand_add_state.dart';

class BrandAddBloc extends Bloc<BrandAddEvent, BrandAddState> {
  final ImagePicker _picker = ImagePicker();
  String? brandName;
  XFile? selectedImage;

  BrandAddBloc() : super(BrandAddInitial()) {
    on<PickImageEvent>(_onPickImage);
    on<BrandNameChanged>(_onBrandNameChanged);
    on<AddBrandEvent>(_onAddBrand);
    on<RemoveImageEvent>(_onRemoveImage);
  }

  void _onPickImage(PickImageEvent event, Emitter<BrandAddState> emit) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage = image;
      emit(BrandImageSelected(image));
    }
  }

  void _onBrandNameChanged(
      BrandNameChanged event, Emitter<BrandAddState> emit) {
    brandName = event.brandName;
  }

  void _onRemoveImage(RemoveImageEvent event, Emitter<BrandAddState> emit) {
    selectedImage = null;
    emit(BrandImageRemoved());
  }

  void _onAddBrand(AddBrandEvent event, Emitter<BrandAddState> emit) async {
    if (brandName == null || brandName!.isEmpty || selectedImage == null) {
      emit(BrandAddError('Please fill all fields and select an image.'));
      return;
    }

    try {
      // Check if brand exists
      final exists = await FirebaseFirestore.instance
          .collection('brands')
          .where('name', isEqualTo: brandName!.trim())
          .get();
      if (exists.docs.isNotEmpty) {
        emit(BrandAddError('Brand already exists!'));
        return;
      }

      // Encode image
      final bytes = await selectedImage!.readAsBytes();
      final base64Image = base64Encode(bytes);

      // Create BrandModel object
      String brandId = FirebaseFirestore.instance.collection('brands').doc().id;
      BrandModel brand =
          BrandModel(id: brandId, name: brandName!.trim(), image: base64Image);

      // Add brand to Firestore
      await FirebaseFirestore.instance
          .collection('brands')
          .doc(brandId)
          .set(brand.toMap());

      emit(BrandAddSuccess());
    } catch (e) {
      emit(BrandAddError('Error adding brand: $e'));
    }
  }
}
