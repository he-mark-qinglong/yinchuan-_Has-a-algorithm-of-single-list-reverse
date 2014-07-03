//
//  CarPointAnnotation.h
//  PudongTravel
//
//  Created by jiangjunli on 14-6-3.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "BMKPointAnnotation.h"
@class CarParkInfo;
@interface CarPointAnnotation : BMKPointAnnotation

@property (strong, nonatomic) CarParkInfo *info;
@end
