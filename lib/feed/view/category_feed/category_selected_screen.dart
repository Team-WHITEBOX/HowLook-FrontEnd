import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/const/colors.dart';
import '../../../common/layout/default_layout.dart';
import '../../../common/view/root_tab.dart';
import '../../component/category_slide.dart';
import '../../provider/feed/category_provider/category_check_provider.dart';
import '../../provider/feed/category_provider/category_provider.dart';


class CategorySelectScreen extends ConsumerStatefulWidget {
  const CategorySelectScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CategorySelectScreen> createState() => _CategoryScreen();
}

class _CategoryScreen extends ConsumerState<CategorySelectScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(categoryProvider);
    final stateRead = ref.read(categoryProvider.notifier);

    return DefaultLayout(
      title: '카테고리',
      actions: <Widget>[
        TextButton(
          style: ButtonStyle(
            overlayColor:
                MaterialStateColor.resolveWith((states) => Colors.transparent),
          ),
          onPressed: () {
            ref.read(categoryProvider.notifier).toggleReset();
            ref.read(isFiltering.notifier).update((state) => false);
          },
          child: const Text(
            "초기화",
            style: TextStyle(
              color: BODY_TEXT_COLOR,
            ),
          ),
        ),
      ],
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Divider(),
              // GENDER
              SizedBox(height: MediaQuery.of(context).size.height / 100),
              Row(
                children: <Widget>[
                  SizedBox(width: MediaQuery.of(context).size.width / 50),
                  const Text(
                    "GENDER",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => stateRead.toggleGenderSelected(gender: "M"),
                    child: Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width / 2.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "MEN",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: state.gender == "M"
                                  ? FontWeight.w700
                                  : FontWeight.w300,
                              color: state.gender == "M"
                                  ? Colors.black
                                  : Colors.black45,
                            ),
                          ),
                          state.gender == "M"
                              ? const Icon(Icons.check)
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => stateRead.toggleGenderSelected(gender: "F"),
                    child: Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width / 2.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "WOMEN",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: state.gender == "F"
                                  ? FontWeight.w700
                                  : FontWeight.w300,
                              color: state.gender == "F"
                                  ? Colors.black
                                  : Colors.black45,
                            ),
                          ),
                          state.gender == "F"
                              ? const Icon(Icons.check)
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 50),
              const Divider(),
              SizedBox(height: MediaQuery.of(context).size.height / 50),

              // HEIGHT/WEIGHT
              Row(
                children: <Widget>[
                  SizedBox(width: MediaQuery.of(context).size.width / 50),
                  const Text(
                    "HEIGHT",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 3),
                  const Text(
                    "WEIGHT",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 100),
              Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width / 45),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 100),
                      BodyInfoSlide(bodyType: "Height"), //드롭다운 버튼
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 100),
                      BodyInfoSlide(bodyType: "Weight"), //드롭다운 버튼
                    ],
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 50),
              const Divider(),
              SizedBox(height: MediaQuery.of(context).size.height / 50),

              // STYLE
              Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width / 50),
                  const Text(
                    "STYLE",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 50),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: <Widget>[
                      SizedBox(width: MediaQuery.of(context).size.width / 20),
                      GestureDetector(
                        onTap: () =>
                            stateRead.toggleStyleSelected(style: "Minimal"),
                        child: Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width / 2.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "미니멀",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: state.hashtagDTOMinimal
                                      ? FontWeight.w700
                                      : FontWeight.w300,
                                  color: state.hashtagDTOMinimal
                                      ? Colors.black
                                      : Colors.black45,
                                ),
                              ),
                              state.hashtagDTOMinimal
                                  ? const Icon(Icons.check)
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width / 10),
                      GestureDetector(
                        onTap: () =>
                            stateRead.toggleStyleSelected(style: "Casual"),
                        child: Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width / 2.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "캐주얼",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: state.hashtagDTOCasual
                                      ? FontWeight.w700
                                      : FontWeight.w300,
                                  color: state.hashtagDTOCasual
                                      ? Colors.black
                                      : Colors.black45,
                                ),
                              ),
                              state.hashtagDTOCasual
                                  ? const Icon(Icons.check)
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 30),
                  Row(
                    children: <Widget>[
                      SizedBox(width: MediaQuery.of(context).size.width / 20),
                      GestureDetector(
                        onTap: () =>
                            stateRead.toggleStyleSelected(style: "Street"),
                        child: Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width / 2.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "스트릿",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: state.hashtagDTOStreet
                                      ? FontWeight.w700
                                      : FontWeight.w300,
                                  color: state.hashtagDTOStreet
                                      ? Colors.black
                                      : Colors.black45,
                                ),
                              ),
                              state.hashtagDTOStreet
                                  ? const Icon(Icons.check)
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width / 10),
                      GestureDetector(
                        onTap: () => stateRead.toggleStyleSelected(
                            style: "AmericanCasual"),
                        child: Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width / 2.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "아메카지",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: state.hashtagDTOAmekaji
                                      ? FontWeight.w700
                                      : FontWeight.w300,
                                  color: state.hashtagDTOAmekaji
                                      ? Colors.black
                                      : Colors.black45,
                                ),
                              ),
                              state.hashtagDTOAmekaji
                                  ? const Icon(Icons.check)
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 30),
                  Row(
                    children: <Widget>[
                      SizedBox(width: MediaQuery.of(context).size.width / 20),
                      GestureDetector(
                        onTap: () =>
                            stateRead.toggleStyleSelected(style: "Sporty"),
                        child: Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width / 2.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "스포티",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: state.hashtagDTOSporty
                                      ? FontWeight.w700
                                      : FontWeight.w300,
                                  color: state.hashtagDTOSporty
                                      ? Colors.black
                                      : Colors.black45,
                                ),
                              ),
                              state.hashtagDTOSporty
                                  ? const Icon(Icons.check)
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width / 10),
                      GestureDetector(
                        onTap: () =>
                            stateRead.toggleStyleSelected(style: "Guitar"),
                        child: Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width / 2.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "기타",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: state.hashtagDTOGuitar
                                      ? FontWeight.w700
                                      : FontWeight.w300,
                                  color: state.hashtagDTOGuitar
                                      ? Colors.black
                                      : Colors.black45,
                                ),
                              ),
                              state.hashtagDTOGuitar
                                  ? const Icon(Icons.check)
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      ref.read(categoryProvider.notifier).toggleReset();
                      ref.read(isFiltering.notifier).update((state) => false);
                    },
                    backgroundColor: Colors.white,
                    child: const Icon(
                      Icons.refresh,
                      size: 32,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        minimumSize: Size(
                          MediaQuery.of(context).size.width * 0.67,
                          MediaQuery.of(context).size.height / 100,
                        ),
                      ),
                      onPressed: () {
                        // 여기서 모든 필터 값 중 하나라도 선택됐다면 isFiltering 값을 true로 변환
                        if (ref.read(categoryProvider.notifier).checkCategoryInitState() > 0) {
                          ref.read(isFiltering.notifier).update((state) => true);
                        } else {
                          ref.read(isFiltering.notifier).update((state) => false);
                        }

                        /* VALIDATE */
                        // 만약 현재 isFiltering이 false가 아니라면 적어도 상태의 값은 2 이상이여야 함
                        // 성별과 적어도 하나의 스타일이 선택되어야 하기 때문
                        // 키 몸무게는 모르겠다,,

                        // 여기선 현재 선택된 값을 기준으로 표시할 숫자를 변경하는 것
                        final state = ref.read(isFiltering.notifier).state;
                        if (state == true) {
                          int count = ref.read(categoryProvider.notifier).checkCategoryInitState();
                          ref.read(categoryCountProvider.notifier).update((state) => count);
                        }

                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => RootTab(),
                            ),
                            (Route<dynamic> route) => false);
                      },
                      child: const Text(
                        "계속하기",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
