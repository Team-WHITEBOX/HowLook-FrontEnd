#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "KakaoFlutterSdkPlugin.h"

FOUNDATION_EXPORT double kakao_flutter_sdk_commonVersionNumber;
FOUNDATION_EXPORT const unsigned char kakao_flutter_sdk_commonVersionString[];

