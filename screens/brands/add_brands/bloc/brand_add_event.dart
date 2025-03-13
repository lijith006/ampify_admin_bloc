abstract class BrandAddEvent {}

class PickImageEvent extends BrandAddEvent {}

class BrandNameChanged extends BrandAddEvent {
  final String brandName;
  BrandNameChanged(this.brandName);
}

class RemoveImageEvent extends BrandAddEvent {}

class AddBrandEvent extends BrandAddEvent {}
