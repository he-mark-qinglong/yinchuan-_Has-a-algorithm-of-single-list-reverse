//
//  CalloutMapAnnotation.h
//  WhereWeGo
//
//  Created by lifuyong on 14-2-13.
//  Copyright (c) 2014年 lifuyong. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMapKit.h"

@class NearbyOtherInfo;
@class CarParkInfo;
@interface CalloutMapAnnotation : NSObject<BMKAnnotation> 

@property (assign, nonatomic) CLLocationDegrees latitude;
@property (assign, nonatomic) CLLocationDegrees longitude;

@property  NearbyOtherInfo *info;
@property  CarParkInfo *carInfo;
@property BOOL isStopCarPopView;
@end
