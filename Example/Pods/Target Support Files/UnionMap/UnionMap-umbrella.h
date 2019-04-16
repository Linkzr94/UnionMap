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

#import "AMapAdepter.h"
#import "AMapSearchProxy.h"
#import "AMapViewProxy.h"
#import "Target_AMapAdepter.h"
#import "UMConfig.h"
#import "UMManager.h"
#import "UMRequest.h"
#import "UMResponder.h"
#import "UMRoute.h"
#import "UnionMap.h"

FOUNDATION_EXPORT double UnionMapVersionNumber;
FOUNDATION_EXPORT const unsigned char UnionMapVersionString[];

