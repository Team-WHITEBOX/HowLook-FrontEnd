import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/feed/model/category_model.dart';

final categoryProvider = StateNotifierProvider<CategoryNotifier, CategoryModel>(
    (ref) => CategoryNotifier());

class CategoryNotifier extends StateNotifier<CategoryModel> {
  CategoryNotifier()
      : super(
          CategoryModel(
            gender: '',
            hashtagDTOMinimal: false,
            hashtagDTOCasual: false,
            hashtagDTOStreet: false,
            hashtagDTOAmekaji: false,
            hashtagDTOSporty: false,
            hashtagDTOGuitar: false,
            heightLow: 100,
            heightHigh: 240,
            weightLow: 20,
            weightHigh: 165,
          ),
        );

  toggleReset() {
    state = CategoryModel(
      gender: '',
      hashtagDTOMinimal: false,
      hashtagDTOCasual: false,
      hashtagDTOStreet: false,
      hashtagDTOAmekaji: false,
      hashtagDTOSporty: false,
      hashtagDTOGuitar: false,
      heightLow: 100,
      heightHigh: 240,
      weightLow: 20,
      weightHigh: 165,
    );
  }

  toggleGenderSelected({
    required String gender,
  }) {
    if (gender == "M") {
      state = state.copyWith(
        gender: "M",
      );
    } else {
      state = state.copyWith(
        gender: "F",
      );
    }
  }

  changeBodyType({
    required String bodyType,
    required int minValue,
    required int maxValue,
  }) {
    if (bodyType == "Height") {
      state = state.copyWith(
        heightLow: minValue,
        heightHigh: maxValue,
      );
    } else {
      state = state.copyWith(
        weightLow: minValue,
        weightHigh: maxValue,
      );
    }
  }

  toggleStyleSelected({required String style}) {
    if (style == "Minimal") {
      state = state.copyWith(
        hashtagDTOMinimal: !state.hashtagDTOMinimal,
      );
    } else if (style == "Casual") {
      state = state.copyWith(
        hashtagDTOCasual: !state.hashtagDTOCasual,
      );
    } else if (style == "Street") {
      state = state.copyWith(
        hashtagDTOStreet: !state.hashtagDTOStreet,
      );
    } else if (style == "AmericanCasual") {
      state = state.copyWith(
        hashtagDTOAmekaji: !state.hashtagDTOAmekaji,
      );
    } else if (style == "Sporty") {
      state = state.copyWith(
        hashtagDTOSporty: !state.hashtagDTOSporty,
      );
    } else {
      state = state.copyWith(
        hashtagDTOGuitar: !state.hashtagDTOGuitar,
      );
    }
  }

  outputCategoryModel() {
    final CategoryModel model = state;
    print('gender: ${model.gender}');
    print('hashtagDTOMinimal: ${model.hashtagDTOMinimal}');
    print('hashtagDTOCasual: ${model.hashtagDTOCasual}');
    print('hashtagDTOStreet: ${model.hashtagDTOStreet}');
    print('hashtagDTOAmekaji: ${model.hashtagDTOAmekaji}');
    print('hashtagDTOSporty: ${model.hashtagDTOSporty}');
    print('hashtagDTOGuitar: ${model.hashtagDTOGuitar}');
    print('heightLow: ${model.heightLow}');
    print('heightHigh: ${model.heightHigh}');
    print('weightLow: ${model.weightLow}');
    print('weightHigh: ${model.weightHigh}');
  }
}
