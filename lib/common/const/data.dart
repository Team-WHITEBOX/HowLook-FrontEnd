import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

// localhost
final emulatorIP = "10.0.2.2:3000";
final simulatorIP = "127.0.0.1:3000";

final ip = Platform.isIOS ? simulatorIP : emulatorIP;

final storage = FlutterSecureStorage();
