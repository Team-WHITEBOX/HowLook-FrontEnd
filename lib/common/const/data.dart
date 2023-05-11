import 'dart:io';

const String ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const String REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';
const String YOUR_NATIVE_APP_KEY = 'fee362483928c6b3bbbb934a9996d8cb';
const String USERMID_KEY = 'USERMID';
const String NULL_IMG_URI = 'https://howlook-s3-bucket.s3.ap-northeast-2.amazonaws.com/null';

// <- 아이디 불러오는 방법 ->
// final usermid = await storage.read(key: USERMID_KEY);
// print(usermid);

// Cloud Storage Bucket
const myFirebaseStorage = "gs://facedetection-5ac05.appspot.com";

// localhost
const emulatorIP = "10.0.2.2:3000";
const simulatorIP = "127.0.0.1:3000";
const API_SERVICE_URI = "3.34.164.14:8080";
const REDIRECT_URI = "http://3.34.164.14:8080/login/oauth2/code/kakao";

final ip = Platform.isIOS ? simulatorIP : emulatorIP;
