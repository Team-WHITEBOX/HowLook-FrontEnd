import 'package:flutter/material.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:howlook/upload/inputFormatter.dart';

class FeedUpload extends StatefulWidget {
  const FeedUpload({Key? key}) : super(key: key);

  @override
  State<FeedUpload> createState() => _FeedUploadState();
}

class _FeedUploadState extends State<FeedUpload> {
  // 이미지 담아오기
  final ImagePicker _picker = ImagePicker();

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

  final _myController = TextEditingController();
  int maxLength = 30;

  @override
  void initState() {
    super.initState();
    _myController.addListener(_printLatestValue);
  }

  void _printLatestValue() {
    print("hi: ${_myController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'Feed Upload',
      actions: <Widget>[
        IconButton(
          onPressed: () {
            구현
          },
          icon: Icon(
            MdiIcons.progressUpload,
            size: 30,
          ),
        ),
      ],
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
                        maxLength: this.maxLength,
                        keyboardType: TextInputType.text,
                        controller: _myController,
                        cursorColor: PRIMARY_COLOR,
                        style: TextStyle(decorationColor: Colors.grey),
                        inputFormatters: [
                          Utf8LengthLimitingTextInputFormatter(maxLength)
                        ],
                        decoration: InputDecoration(
                            border: baseBorder,
                            enabledBorder: baseBorder,
                            // 선택된 Input 상태의 기본 스타일
                            focusedBorder: baseBorder.copyWith(
                                borderSide: baseBorder.borderSide.copyWith(
                              color: PRIMARY_COLOR,
                            )),
                            labelText: '한줄쓰기',
                            labelStyle: TextStyle(color: Colors.grey),
                            hintText: '간단한 글을 남겨보세요:)',
                            counterStyle: TextStyle(color: Colors.grey)),
                      ),
                    )),
                const SizedBox(
                  height: 5,
                ),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(
                          left: 25.0, top: 0.0, right: 0.0, bottom: 0.0),
                      child: Text(
                        "STYLE",
                        style: TextStyle(
                          fontFamily: 'NotoSans',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: BODY_TEXT_COLOR,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
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
