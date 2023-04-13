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
                    const SizedBox(width: 30),
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
                const SizedBox(height: 10),
                // ** 성별 체크박스 **
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: [
                        SizedBox(width: 20),
                        Text(
                          "MEN",
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(width: 10),
                        Checkbox(
                          value: state.isManChecked,
                          activeColor: PRIMARY_COLOR,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          onChanged: (value) {
                            ref
                                .read(categoryProvider.notifier)
                                .toggleGenderSelected(gender: "Man");
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        Text(
                          "WOMEN",
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Checkbox(
                          value: state.isWomanChecked,
                          activeColor: PRIMARY_COLOR,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          onChanged: (value) {
                            ref
                                .read(categoryProvider.notifier)
                                .toggleGenderSelected(gender: "Woman");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                /////////////////////////////////////////////
                Row(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 30),
                            Text(
                              "키",
                              style: TextStyle(
                                fontFamily: 'NotoSans',
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: BODY_TEXT_COLOR,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 10000),
                        _Slide(BodyType: "Height"),
                      ],
                    ),
                    // const SizedBox(width: 10),
                    // Column(
                    //   children: [
                    //     Row(
                    //       children: [
                    //         // const SizedBox(width: 30),
                    //         Text(
                    //           "몸무게",
                    //           style: TextStyle(
                    //             fontFamily: 'NotoSans',
                    //             fontSize: 15,
                    //             fontWeight: FontWeight.w400,
                    //             color: BODY_TEXT_COLOR,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //     SizedBox(
                    //         height: MediaQuery.of(context).size.height / 10000),
                    //     _Slide(BodyType: "Weight"),
                    //   ],
                    // ),
                  ],
                ),
                /////////////////////////////////////////////

                // ******** 스타일 ********
                // ** 스타일 텍스트 **
                Row(
                  children: [
                    const SizedBox(width: 30),
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
                SizedBox(height: MediaQuery.of(context).size.height / 10000),
                // ** 스타일 체크박스 **
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: <Widget>[
                        const SizedBox(width: 40),
                        Text(
                          "미니멀",
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 30),
                        Checkbox(
                          value: state.isMinimalChecked,
                          activeColor: PRIMARY_COLOR,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          onChanged: (value) {
                            ref
                                .read(categoryProvider.notifier)
                                .toggleStyleSelected(style: "Minimal");
                          },
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width / 8),
                        Text(
                          "캐주얼",
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 30),
                        Checkbox(
                          value: state.isCasualChecked,
                          activeColor: PRIMARY_COLOR,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          onChanged: (value) {
                            ref
                                .read(categoryProvider.notifier)
                                .toggleStyleSelected(style: "Casual");
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        const SizedBox(width: 40),
                        Text(
                          "스트릿",
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 30),
                        Checkbox(
                          value: state.isStreetChecked,
                          activeColor: PRIMARY_COLOR,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          onChanged: (value) {
                            ref
                                .read(categoryProvider.notifier)
                                .toggleStyleSelected(style: "Street");
                          },
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 9 + 4),
                        Text(
                          "아메카지",
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Checkbox(
                          value: state.isAmericanCasualChecked,
                          activeColor: PRIMARY_COLOR,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          onChanged: (value) {
                            ref
                                .read(categoryProvider.notifier)
                                .toggleStyleSelected(style: "AmericanCasual");
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        const SizedBox(width: 40),
                        Text(
                          "스포티",
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 30),
                        Checkbox(
                          value: state.isSportyChecked,
                          activeColor: PRIMARY_COLOR,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          onChanged: (value) {
                            ref
                                .read(categoryProvider.notifier)
                                .toggleStyleSelected(style: "Sporty");
                          },
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 9 + 4),
                        const Text(
                          "기타     ",
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 28),
                        Checkbox(
                          value: state.isEtcChecked,
                          activeColor: PRIMARY_COLOR,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          onChanged: (value) {
                            ref
                                .read(categoryProvider.notifier)
                                .toggleStyleSelected(style: "Etc");
                          },
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
                            Color(0xFF1D002D),
                            //Color(0xFFa17fe0),
                            Color(0xFF603674),
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
                            Navigator.of(context).pushReplacement(
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

class _Slide extends ConsumerStatefulWidget {
  String? BodyType;

  _Slide({
    required this.BodyType,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<_Slide> createState() => _SlideState();
}

class _SlideState extends ConsumerState<_Slide> {
  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      '~ 150cm',
      '150 ~ 157cm',
      '155 ~ 162cm',
      '160 ~ 167cm',
      '165 ~ 172cm',
    ];
    String? selectedValue;

    List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
      List<DropdownMenuItem<String>> _menuItems = [];
      for (var item in items) {
        _menuItems.addAll(
          [
            DropdownMenuItem<String>(
              value: item,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 13),
                ),
              ),
            ),
            //If it's last item, we will not add Divider after it.
            if (item != items.last)
              const DropdownMenuItem<String>(
                enabled: false,
                child: Divider(),
              ),
          ],
        );
      }
      return _menuItems;
    }

    List<double> _getCustomItemsHeights() {
      List<double> _itemsHeights = [];
      for (var i = 0; i < (items.length * 2) - 1; i++) {
        if (i.isEven) {
          _itemsHeights.add(40);
        }
        //Dividers indexes will be the odd indexes
        if (i.isOdd) {
          _itemsHeights.add(4);
        }
      }
      return _itemsHeights;
    }

    return Padding(
      // padding: EdgeInsets.zero,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField2(
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          hint: Text(
            '선택하기',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
            ),
          ),
          items: _addDividersAfterItems(items),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value as String;
            });
          },
          onSaved: (value) {
            selectedValue = value.toString();
          },
          buttonStyleData: const ButtonStyleData(
            height: 60,
            padding: EdgeInsets.only(left: 15, right: 10),
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.black45,
            ),
            iconSize: 30,
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          menuItemStyleData: MenuItemStyleData(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            customHeights: _getCustomItemsHeights(),
          ),
        ),
      ),
    );
  }
}
