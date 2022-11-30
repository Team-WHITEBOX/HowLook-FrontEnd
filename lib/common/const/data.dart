import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';
const YOUR_NATIVE_APP_KEY = 'fee362483928c6b3bbbb934a9996d8cb';


// localhost
final emulatorIP = "10.0.2.2:3000";
final simulatorIP = "127.0.0.1:3000";
final API_SERVICE_URI = "3.34.164.14:8080";
final REDIRECT_URI = "http://3.34.164.14:8080/login/oauth2/code/kakao";

final ip = Platform.isIOS ? simulatorIP : emulatorIP;

final storage = FlutterSecureStorage();
