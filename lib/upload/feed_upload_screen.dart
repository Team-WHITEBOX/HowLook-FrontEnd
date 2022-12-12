import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:howlook/common/secure_storage/secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:howlook/upload/inputFormatter.dart';

class FeedUpload extends ConsumerStatefulWidget {
  const FeedUpload({Key? key}) : super(key: key);

  @override
  ConsumerState<FeedUpload> createState() => _FeedUploadState();
}

class _FeedUploadState extends ConsumerState<FeedUpload> {
  var dio = new Dio();

  // 위치 정보 불러오기
  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  // 이미지 담아오기
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? _selectedImages = [];
  var formData;
  dynamic sendData;

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage(
      maxHeight: 3000,
      maxWidth: 3000,
      imageQuality: 100, // 이미지 크기 압축을 위해 퀄리티를 30으로 낮춤.
    );

    setState(() {
      if (selectedImages!.isNotEmpty) {
        _selectedImages!.addAll(selectedImages);
      } else {
        print('no image');
      }
    });
  }

  // 이미지 서버 업로드
  Future<dynamic> patchUserProfileImage(WidgetRef ref) async {
    var gps = await getCurrentLocation();
    final storage = ref.read(secureStorageProvider);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    try {
      dio.options.contentType = 'multipart/form-data';
      dio.options.maxRedirects.isFinite;

      final List<MultipartFile> files = _selectedImages!
          .map((img) => MultipartFile.fromFileSync(img.path))
          .toList();

      formData = FormData.fromMap({
        "content": contents,
        "hashtagDTO.amekaji": isAmericanCasualChecked,
        "hashtagDTO.casual": isCasualChecked,
        "hashtagDTO.guitar": isEtcChecked,
        "hashtagDTO.minimal": isMinimalChecked,
        "hashtagDTO.sporty": isSportyChecked,
        "hashtagDTO.street": isStreetChecked,
        "latitude": gps.latitude,
        "longitude": gps.longitude,
        "uploadFileDTO.files": files,
        //'uploadFileDTO.files': await MultipartFile.fromFile(sendData),
      });

      final resp = await dio.post(
        // MainFeed 관련 api IP주소 추가하기
        'http://$API_SERVICE_URI/feed/register',
        options: Options(
          headers: {
            'authorization': 'Bearer $accessToken',
          },
        ),
        data: formData,
      );
      print('성공적으로 업로드했습니다');
      return resp.statusCode;
    } catch (e) {
      print(e);
    }
  }

  String contents = '';
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
          onPressed: () async {
            final statuscode = await patchUserProfileImage(ref);
            if (statuscode == 200) {
              Navigator.pop(context);
            }
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
                  child: Stack(
                    children: [
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
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PageView.builder(
                              itemCount: _selectedImages!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  child: Image.file(
                                    File(_selectedImages![index].path),
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: () async {
                    selectImages();
                  }, //사진 업로드
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      onChanged: (value) {
                        contents = value;
                      },
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
                  ),
                ),
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
