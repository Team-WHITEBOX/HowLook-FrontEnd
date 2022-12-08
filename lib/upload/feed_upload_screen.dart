import 'package:flutter/material.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:glass_kit/glass_kit.dart';

class FeedUpload extends StatefulWidget {
  const FeedUpload({Key? key}) : super(key: key);

  @override
  State<FeedUpload> createState() => _FeedUploadState();
}

class _FeedUploadState extends State<FeedUpload> {
  bool isMinimalChecked = false;
  bool isCasualChecked = false;
  bool isStreetChecked = false;
  bool isAmericanCasualChecked = false;
  bool isSportyChecked = false;
  bool isEtcChecked = false;

  final myController = TextEditingController();

  final baseBorder = UnderlineInputBorder(
    borderSide: BorderSide(
      color: INPUT_BORDER_COLOR,
      width: 2.0,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'Feed Upload',
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  child: Stack(children: [
                    GlassContainer(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.9,
                      gradient: LinearGradient(
                        colors: [
                          PRIMARY_COLOR.withOpacity(0.70),
                          Color(0xFFa6ceff).withOpacity(0.40)
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderGradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.60),
                          Colors.white.withOpacity(0.10),
                          Color(0xFFa6ceff).withOpacity(0.05),
                          Color(0xFFa6ceff).withOpacity(0.6)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.0, 0.39, 0.40, 1.0],
                      ),
                      blur: 30.0,
                      borderWidth: 2,
                      elevation: 3.0,
                      isFrostedGlass: true,
                      shadowColor: Colors.black.withOpacity(0.20),
                      alignment: Alignment.center,
                      frostedOpacity: 0.12,
                      margin: EdgeInsets.all(16.0),
                      child: Center(
                        child: Icon(
                          Icons.add_photo_alternate_rounded,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                  ]),
                  onTap: () {}, //사진 업로드
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                    margin: EdgeInsets.all(8),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        maxLength: 30, // 문자길이 제한
                        keyboardType: TextInputType.text,
                        controller: myController,
                        cursorColor: PRIMARY_COLOR,
                        style: TextStyle(decorationColor: Colors.grey),
                        decoration: InputDecoration(
                            border: baseBorder,
                            enabledBorder: baseBorder,
                            // 선택된 Input 상태의 기본 스타일
                            focusedBorder: baseBorder.copyWith(
                                borderSide: baseBorder.borderSide.copyWith(
                                  color: PRIMARY_COLOR,
                                )
                            ),
                          labelText: '한줄쓰기',
                          labelStyle: TextStyle(color: Colors.grey),
                          hintText: '간단한 글을 남겨보세요:)',
                          counterText: '', // counter text를 비움으로 설정
                          counterStyle: TextStyle(color: Colors.grey)
                        ),
                        onChanged: (value) {},
                      ),
                    )),
                const SizedBox(
                  height: 5,
                ),
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
                        const SizedBox(
                          width: 30,
                        ),
                        Checkbox(
                          value: this.isMinimalChecked,
                          activeColor: PRIMARY_COLOR,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          onChanged: (value) {
                            setState(() {
                              this.isMinimalChecked = value!;
                            });
                          },
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 8,
                        ),
                        Text(
                          "캐주얼",
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Checkbox(
                          value: this.isCasualChecked,
                          activeColor: PRIMARY_COLOR,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          onChanged: (value) {
                            setState(() {
                              this.isCasualChecked = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 40,
                        ),
                        Text(
                          "스트릿",
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Checkbox(
                          value: this.isStreetChecked,
                          activeColor: PRIMARY_COLOR,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          onChanged: (value) {
                            setState(() {
                              this.isStreetChecked = value!;
                            });
                          },
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 9 + 4,
                        ),
                        Text(
                          "아메카지",
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Checkbox(
                          value: this.isAmericanCasualChecked,
                          activeColor: PRIMARY_COLOR,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          onChanged: (value) {
                            setState(() {
                              this.isAmericanCasualChecked = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 40,
                        ),
                        Text(
                          "스포티",
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Checkbox(
                          value: this.isSportyChecked,
                          activeColor: PRIMARY_COLOR,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          onChanged: (value) {
                            setState(() {
                              this.isSportyChecked = value!;
                            });
                          },
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 9 + 4,
                        ),
                        Text(
                          "기타     ",
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          width: 28,
                        ),
                        Checkbox(
                          value: this.isEtcChecked,
                          activeColor: PRIMARY_COLOR,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          onChanged: (value) {
                            setState(() {
                              this.isEtcChecked = value!;
                            });
                          },
                        ),
                      ],
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
