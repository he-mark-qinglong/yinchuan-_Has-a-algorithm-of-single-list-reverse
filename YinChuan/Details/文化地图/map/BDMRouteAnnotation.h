//
//  BDMRouteAnnotation.h
//  PudongTravel
//
//  Created by duwei on 14-4-11.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "BMKPointAnnotation.h"

typedef enum
{
    BDMPositionOriginPoint = 0,   //定位位置原点
    BDMPositionStartPoint,        //起点
    BDMPositionEndPoint,          //终点
    BDMPositionBusPoint,          //公交
    BDMPositionMetroPoint = 4,    //地铁
    BDMPositionDrivingPoint,      //驾乘
    BDMPosttionWalkPoint          //步行
}BDMPosition;

@interface BDMRouteAnnotation : BMKPointAnnotation

@property (nonatomic) BDMPosition annotationType;

@end
