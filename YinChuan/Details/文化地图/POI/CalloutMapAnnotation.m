//
//  CalloutMapAnnotation.m
//  WhereWeGo
//
//  Created by lifuyong on 14-2-13.
//  Copyright (c) 2014年 lifuyong. All rights reserved.
//

#import "CalloutMapAnnotation.h"

@implementation CalloutMapAnnotation

- (CLLocationCoordinate2D)coordinate{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = self.latitude;
    coordinate.longitude = self.longitude;
    return coordinate;
}

@end
