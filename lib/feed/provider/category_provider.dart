import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/feed/model/category_model.dart';

final categoryProvider = StateNotifierProvider<CategoryNotifier, CategoryModel>(
    (ref) => CategoryNotifier());

class CategoryNotifier extends StateNotifier<CategoryModel> {
  CategoryNotifier()
      : super(
          CategoryModel(
            isManChecked: false,
            isWomanChecked: false,
            isMinimalChecked: false,
            isCasualChecked: false,
            isStreetChecked: false,
            isAmericanCasualChecked: false,
            isSportyChecked: false,
            isEtcChecked: false,
            minHeight: 100,
            maxHeight: 240,
            minWeight: 20,
            maxWeight: 165,
          ),
        );

  void toggleReset() {
    state = state.copyWith();
  }

  void toggleGenderSelected({required String gender}) {
    if (gender == "Man") {
      state = state.isWomanChecked
          ? state.copyWith(
              isManChecked: !state.isManChecked,
              isWomanChecked: !state.isWomanChecked,
            )
          : state.copyWith(
              isManChecked: !state.isManChecked,
            );
    } else {
      state = state = state.isManChecked
          ? state.copyWith(
              isWomanChecked: !state.isWomanChecked,
              isManChecked: !state.isManChecked,
            )
          : state.copyWith(
              isWomanChecked: !state.isWomanChecked,
            );
    }
  }

  void changeBodyType({
    required String BodyType,
    required double minValue,
    required double maxValue,
  }) {
    if (BodyType == "Height") {
      state = state.copyWith(
        minHeight: minValue.toInt(),
        maxHeight: maxValue.toInt(),
      );
    } else {
      state = state.copyWith(
        minWeight: minValue.toInt(),
        maxWeight: maxValue.toInt(),
      );
    }
  }

  void toggleStyleSelected({required String style}) {
    if (style == "Minimal") {
      state = state.copyWith(
        isMinimalChecked: !state.isMinimalChecked,
      );
    } else if (style == "Casual") {
      state = state.copyWith(
        isCasualChecked: !state.isCasualChecked,
      );
    } else if (style == "Street") {
      state = state.copyWith(
        isStreetChecked: !state.isStreetChecked,
      );
    } else if (style == "AmericanCasual") {
      state = state.copyWith(
        isAmericanCasualChecked: !state.isAmericanCasualChecked,
      );
    } else if (style == "Sporty") {
      state = state.copyWith(
        isSportyChecked: !state.isSportyChecked,
      );
    } else {
      state = state.copyWith(
        isEtcChecked: !state.isEtcChecked,
      );
    }
  }
}
