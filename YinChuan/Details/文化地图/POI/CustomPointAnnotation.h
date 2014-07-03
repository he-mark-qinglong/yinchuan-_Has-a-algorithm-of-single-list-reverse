//
//  CustomPointAnnotation.h
//  WhereWeGo
//
//  Created by lifuyong on 14-2-13.
//  Copyright (c) 2014年 lifuyong. All rights reserved.
//

#import "BMKPointAnnotation.h"

//#import "Site.h"

@class NearbyOtherInfo;

@interface CustomPointAnnotation : BMKPointAnnotation

@property (strong, nonatomic) NearbyOtherInfo *info;
@property BOOL isStopCarPopView;
@end
