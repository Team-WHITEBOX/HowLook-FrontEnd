import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:howlook/upload/inputFormatter.dart';

class ReviewUpload extends StatefulWidget {
  const ReviewUpload({Key? key}) : super(key: key);

  @override
  State<ReviewUpload> createState() => _ReviewUploadState();
}

class _ReviewUploadState extends State<ReviewUpload> {

  final baseBorder = UnderlineInputBorder(
    borderSide: BorderSide(
      color: INPUT_BORDER_COLOR,
      width: 2.0,
    ),
  );

  bool toggleValue = false;
  bool isSelected = false;

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
      title: 'Review Upload',
      actions: <Widget>[
        IconButton(onPressed: () {
          //업로드 기능 구현
        }, icon: Icon(MdiIcons.progressUpload, size: 30,)),
      ],
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
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
                  onTap: () {
                    //사진업로드 기능 구현
                  }, //사진 업로드
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  margin: EdgeInsets.only(left: 15.0, top: 0.0,right: 0.0,bottom: 0.0),
                  alignment: Alignment.topLeft,
                  child: Button(),),
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
                        inputFormatters: [Utf8LengthLimitingTextInputFormatter(maxLength)],
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
                            counterStyle: TextStyle(color: Colors.grey)
                        ),
                      ),
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Button(){
    return Row(
      children: [AnimatedContainer(
        duration: Duration(milliseconds: 500),
        height: 40.0,
        width: 100.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: toggleValue ? PRIMARY_COLOR.withOpacity(0.5) : Color(0xFFa6ceff).withOpacity(0.5)
        ),
        child: Stack(
          children: <Widget>[
            AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
            top: 3.0,
            left: toggleValue ? 60.0 : 0.0,
            right: toggleValue ? 0.0 : 60.0,
            child: InkWell(
              onTap: toggleButton,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                transitionBuilder:
                (Widget child, Animation<double> animation){
                  return RotationTransition(
                      child: child, turns: animation);
                },
                child: toggleValue ? Icon(MdiIcons.accountCircle,color: PRIMARY_COLOR,size: 35.0,key:UniqueKey())
                    :Icon(MdiIcons.accountSupervisorCircle,color: Color(0xFFa6ceff),size: 35.0,key:UniqueKey())
              )
            ),)
          ],
        ),
      ),
        const SizedBox(
          width: 10,
        ),
        Container(
          child: toggleValue ? Text('크리에이터 평가',style: TextStyle(color: PRIMARY_COLOR, fontWeight: FontWeight.w200))
              : Text('일반 평가',style: TextStyle(color: Color(0xFFa6ceff), fontWeight: FontWeight.w200))
        )
      ],
    );
  }

  toggleButton(){
    setState(() {
      toggleValue = !toggleValue;
    });
  }
}
