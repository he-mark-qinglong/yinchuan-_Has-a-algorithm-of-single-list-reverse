//
//  BaiDuMapManager.h
//  PudongTravel
//
//  Created by duwei on 14-4-10.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMapKit.h"

@protocol BMKUserLocationDelegate;

@interface BaiDuMapManager : NSObject<BMKUserLocationDelegate>

@property (nonatomic) CLLocationCoordinate2D currentLocation;

+ (BaiDuMapManager*)ShareInstrance;

- (void)BDMStartUserLocationService;

- (void)setBDMUserLocationDelegate:(id<BMKUserLocationDelegate>)delegate;

- (void)BDMStopUserLocationService;

@end
