import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/feed/provider/category_provider.dart';
import 'package:howlook/feed/view/category_feed_screen.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreen();
}

class _CategoryScreen extends ConsumerState<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(categoryProvider);
    return DefaultLayout(
      title: '카테고리',
      actions: <Widget>[
        TextButton(
          onPressed: () {
            ref.read(categoryProvider.notifier).toggleReset();
          },
          child: Text(
            "초기화",
            style: TextStyle(
              color: BODY_TEXT_COLOR,
            ),
          ),
        ),
      ],
      child: SingleChildScrollView(
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width / 20),
                    Text(
                      "GENDER",
                      style: TextStyle(
                        fontFamily: 'NotoSans',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: BODY_TEXT_COLOR,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 100),
                // ** 성별 체크박스 **
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: [
                        Checkbox(
                          value: ref.watch(categoryProvider).gender == "M",
                          activeColor: PRIMARY_COLOR,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          onChanged: (value) {
                            ref
                                .read(categoryProvider.notifier)
                                .toggleGenderSelected(
                                    gender: value! ? "M" : "F"); // 수정된 부분
                            print(ref.watch(categoryProvider).gender);
                          },
                          visualDensity: VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity,
                          ),
                        ),
                        Text(
                          "MEN",
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: ref.watch(categoryProvider).gender ==
                              "F", // 수정된 부분
                          activeColor: PRIMARY_COLOR,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          onChanged: (value) {
                            ref
                                .read(categoryProvider.notifier)
                                .toggleGenderSelected(
                                    gender: value! ? "F" : "M"); // 수정된 부분
                            print(ref.watch(categoryProvider).gender);
                          },
                          visualDensity: VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity,
                          ),
                        ),
                        Text(
                          "WOMEN",
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 30),

                /////////////////////////////////////////////
                Row(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width / 20),
                    Text(
                      "HIEGHT / WEIGHT",
                      style: TextStyle(
                        fontFamily: 'NotoSans',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: BODY_TEXT_COLOR,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 100),
                Row(
                  children: [
                    // SizedBox(width: 20),
                    SizedBox(width: MediaQuery.of(context).size.width / 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "키",
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: BODY_TEXT_COLOR,
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 100),
                        _HeightSlide(BodyType: "Height"), //드롭다운 버튼
                      ],
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width / 20),
                    // SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "몸무게",
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: BODY_TEXT_COLOR,
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 100),
                        _WeightSlide(BodyType: "Weight"), //드롭다운 버튼
                      ],
                    ),
                  ],
                ),
                /////////////////////////////////////////////

                // ******** 스타일 ********
                // ** 스타일 텍스트 **

                SizedBox(height: MediaQuery.of(context).size.height / 30),
                Row(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width / 20),
                    Text(
                      "STYLE",
                      style: TextStyle(
                        fontFamily: 'NotoSans',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: BODY_TEXT_COLOR,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 100),
                // ** 스타일 체크박스 **
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: <Widget>[
                        // const SizedBox(width: 40),
                        Checkbox(
                            value: state.hashtagDTOMinimal,
                            activeColor: PRIMARY_COLOR,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            onChanged: (value) {
                              ref
                                  .read(categoryProvider.notifier)
                                  .toggleStyleSelected(style: "Minimal");

                              print(ref
                                  .watch(categoryProvider)
                                  .hashtagDTOMinimal);
                            },
                            visualDensity: VisualDensity.standard),
                        // const SizedBox(width: 30),
                        Text(
                          "미니멀",
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width / 8),
                        Checkbox(
                            value: state.hashtagDTOCasual,
                            activeColor: PRIMARY_COLOR,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            onChanged: (value) {
                              ref
                                  .read(categoryProvider.notifier)
                                  .toggleStyleSelected(style: "Casual");

                              print(
                                  ref.watch(categoryProvider).hashtagDTOCasual);
                            },
                            visualDensity: VisualDensity.standard),
                        // const SizedBox(width: 30),
                        Text(
                          "캐주얼",
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        // const SizedBox(width: 40),
                        Checkbox(
                            value: state.hashtagDTOStreet,
                            activeColor: PRIMARY_COLOR,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            onChanged: (value) {
                              ref
                                  .read(categoryProvider.notifier)
                                  .toggleStyleSelected(style: "Street");
                              print(
                                  ref.watch(categoryProvider).hashtagDTOStreet);
                            },
                            visualDensity: VisualDensity.standard),
                        // const SizedBox(width: 30),
                        Text(
                          "스트릿",
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 9 + 4),
                        Checkbox(
                            value: state.hashtagDTOAmekaji,
                            activeColor: PRIMARY_COLOR,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            onChanged: (value) {
                              ref
                                  .read(categoryProvider.notifier)
                                  .toggleStyleSelected(style: "AmericanCasual");
                              print(ref
                                  .watch(categoryProvider)
                                  .hashtagDTOAmekaji);
                            },
                            visualDensity: VisualDensity.standard),
                        // const SizedBox(width: 15),
                        Text(
                          "아메카지",
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        // const SizedBox(width: 40),
                        Checkbox(
                            value: state.hashtagDTOSporty,
                            activeColor: PRIMARY_COLOR,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            onChanged: (value) {
                              ref
                                  .read(categoryProvider.notifier)
                                  .toggleStyleSelected(style: "Sporty");

                              print(
                                  ref.watch(categoryProvider).hashtagDTOSporty);
                            },
                            visualDensity: VisualDensity.standard),
                        // const SizedBox(width: 30),
                        Text(
                          "스포티",
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 9 + 4),
                        Checkbox(
                            value: state.hashtagDTOGuitar,
                            activeColor: PRIMARY_COLOR,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            onChanged: (value) {
                              ref
                                  .read(categoryProvider.notifier)
                                  .toggleStyleSelected(style: "Etc");
                              print(
                                  ref.watch(categoryProvider).hashtagDTOGuitar);
                            },
                            visualDensity: VisualDensity.standard),
                        // const SizedBox(width: 28),
                        const Text(
                          "기타     ",
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                          colors: [
                            Colors.black,
                            //Color(0xFFa17fe0),
                            Colors.grey,
                            // #F9E79F
                          ],
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            minimumSize: Size(300, 50),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(
                              MaterialPageRoute(
                                builder: (_) => CategoryFeedScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "계속하기",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeightSlide extends ConsumerStatefulWidget {
  String? BodyType;

  _HeightSlide({
    required this.BodyType,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<_HeightSlide> createState() => _HeightSlideState();
}

class _HeightSlideState extends ConsumerState<_HeightSlide> {
  final List items = [
    '~ 139cm', //20
    '140cm ~ 149cm',
    '150cm ~ 159cm',
    '160cm ~ 169cm',
    '170cm ~ 179cm',
    '180cm ~ 189cm',
    '190cm ~' //300
  ];

  String? selectedValue;

  List<int> getMinMax(int index) {
    final item = items[index];
    final range = item.split(" ~ ");
    int min, max;
    if (index == 0) {
      min = 20;
      max = int.parse(range[0].replaceAll("cm", "").trim());
    } else if (index == items.length - 1) {
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
    return Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Row(
            children: const [
              Icon(
                Icons.list,
                size: 16,
                color: Colors.white,
              ),
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Text(
                  'Height',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          items: items
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
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value as String?;
            });
            ref.read(categoryProvider.notifier).changeBodyType(
                BodyType: "Height",
                minValue: getMinMax(items.indexOf(selectedValue))[0],
                maxValue: getMinMax(items.indexOf(selectedValue))[1]);
            print(ref.watch(categoryProvider).heightLow);
            print(ref.watch(categoryProvider).heightHigh);
          },
          buttonStyleData: ButtonStyleData(
            height: 50,
            width: 160,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.grey,
              ),
              color: Colors.white,
            ),
            elevation: 2,
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.arrow_forward_ios_outlined,
            ),
            iconSize: 14,
            // iconEnabledColor: Colors.yellow,
            // iconDisabledColor: Colors.grey,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            width: 200,
            padding: null,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.white,
            ),
            elevation: 8,
            offset: const Offset(-20, 0),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: MaterialStateProperty.all<double>(6),
              thumbVisibility: MaterialStateProperty.all<bool>(true),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.only(left: 14, right: 14),
          ),
        ),
      ),
    );
  }
}

class _WeightSlide extends ConsumerStatefulWidget {
  String? BodyType;

  _WeightSlide({
    required this.BodyType,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<_WeightSlide> createState() => _WeightSlideState();
}

class _WeightSlideState extends ConsumerState<_WeightSlide> {
  final List items = [
    '~ 39kg', //20
    '40kg ~ 49kg',
    '50kg ~ 59kg',
    '60kg ~ 69kg',
    '70kg ~ 79kg',
    '80kg ~ 89kg',
    '90kg ~ 99kg',
    '100kg ~', //300
  ];

  String? selectedValue;

  List<int> getMinMax(int index) {
    final item = items[index];
    final range = item.split(" ~ ");
    int min, max;
    if (index == 0) {
      min = 20;
      max = int.parse(range[0].replaceAll("kg", "").trim());
    } else if (index == items.length - 1) {
      min = int.parse(range[0].replaceAll("kg", "").trim());
      max = 300;
    } else {
      min = int.parse(range[0].replaceAll("kg", "").trim());
      max = int.parse(range[1].replaceAll("kg", "").trim());
    }
    return [min, max];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Row(
            children: const [
              Icon(
                Icons.list,
                size: 16,
                color: Colors.white,
              ),
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Text(
                  'Weight',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          items: items
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
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value as String?;
            });
            ref.read(categoryProvider.notifier).changeBodyType(
                BodyType: "Weight",
                minValue: getMinMax(items.indexOf(selectedValue))[0],
                maxValue: getMinMax(items.indexOf(selectedValue))[1]);
            print(ref.watch(categoryProvider).weightLow);
            print(ref.watch(categoryProvider).weightHigh);
          },
          buttonStyleData: ButtonStyleData(
            height: 50,
            width: 160,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.grey,
              ),
              color: Colors.white,
            ),
            elevation: 2,
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.arrow_downward_outlined,
            ),
            iconSize: 14,
            // iconEnabledColor: Colors.yellow,
            // iconDisabledColor: Colors.grey,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            width: 200,
            padding: null,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.white,
            ),
            elevation: 8,
            offset: const Offset(-20, 0),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: MaterialStateProperty.all<double>(6),
              thumbVisibility: MaterialStateProperty.all<bool>(true),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.only(left: 14, right: 14),
          ),
        ),
      ),
    );
  }
}
