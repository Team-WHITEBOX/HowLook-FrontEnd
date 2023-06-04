import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/feed/provider/category_provider.dart';

class BodyInfoSlide extends ConsumerStatefulWidget {
  String? bodyType;

  BodyInfoSlide({
    required this.bodyType,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<BodyInfoSlide> createState() => _BodyInfoSlideState();
}

class _BodyInfoSlideState extends ConsumerState<BodyInfoSlide> {
  final List weight = [
    ' ~ 39kg', // 20
    '40kg ~ 49kg',
    '50kg ~ 59kg',
    '60kg ~ 69kg',
    '70kg ~ 79kg',
    '80kg ~ 89kg',
    '90kg ~ 99kg',
    '100kg ~ ', // 300
  ];
  final List height = [
    ' ~ 139cm', //20
    '140cm ~ 149cm',
    '150cm ~ 159cm',
    '160cm ~ 169cm',
    '170cm ~ 179cm',
    '180cm ~ 189cm',
    '190cm ~ ' //300
  ];

  String? selectedHeight;
  String? selectedWeight;

  List<int> getWeightMinMax(int index) {
    final item = weight[index];
    final range = item.split(" ~ ");
    int min, max;
    if (index == 0) {
      min = 20;
      max = int.parse(range[1].replaceAll("kg", "").trim());
    } else if (index == weight.length - 1) {
      min = int.parse(range[0].replaceAll("kg", "").trim());
      max = 300;
    } else {
      min = int.parse(range[0].replaceAll("kg", "").trim());
      max = int.parse(range[1].replaceAll("kg", "").trim());
    }
    return [min, max];
  }

  List<int> getHeightMinMax(int index) {
    final item = height[index];
    final range = item.split(" ~ ");
    int min, max;
    if (index == 0) {
      min = 20;
      max = int.parse(range[1].replaceAll("cm", "").trim());
    } else if (index == height.length - 1) {
      min = int.parse(range[0].replaceAll("cm", "").trim());
      max = 300;
    } else {
      min = int.parse(range[0].replaceAll("cm", "").trim());
      max = int.parse(range[1].replaceAll("cm", "").trim());
    }
    return [min, max];
  }

  @override
  Widget build(BuildContext context) {
    final category = ref.watch(categoryProvider);
    final categoryRead = ref.read(categoryProvider.notifier);

    return Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Row(
            children: const [
              SizedBox(width: 4),
              Expanded(
                child: Text(
                  '선택하기',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black45,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          items: (widget.bodyType == "Height" ? height : weight)
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          value: widget.bodyType == "Height" ? selectedHeight : selectedWeight,
          onChanged: (value) {
            setState(() {
              widget.bodyType == "Height"
                  ? selectedHeight = value
                  : selectedWeight = value;
            });

            widget.bodyType == "Height"
                ? categoryRead.changeBodyType(
                    bodyType: "Height",
                    minValue:
                        getHeightMinMax(height.indexOf(selectedHeight))[0],
                    maxValue:
                        getHeightMinMax(height.indexOf(selectedHeight))[1],
                  )
                : categoryRead.changeBodyType(
                    bodyType: "Weight",
                    minValue:
                        getWeightMinMax(weight.indexOf(selectedWeight))[0],
                    maxValue:
                        getWeightMinMax(weight.indexOf(selectedWeight))[1],
                  );
          },
          buttonStyleData: ButtonStyleData(
            height: 45,
            width: MediaQuery.of(context).size.width / 2.5,
            padding: const EdgeInsets.only(left: 15, right: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey),
              color: Colors.white,
            ),
          ),
          iconStyleData:
              const IconStyleData(icon: Icon(Icons.expand_more), iconSize: 24),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 250,
            width: MediaQuery.of(context).size.width / 2.5,
            padding: null,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            elevation: 8,
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: MaterialStateProperty.all<double>(6),
              thumbVisibility: MaterialStateProperty.all<bool>(true),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 45,
            padding: EdgeInsets.only(left: 14, right: 14),
          ),
        ),
      ),
    );
  }
}
