//
//  implBMKSearchDelegate.h
//  PudongTravel
//
//  Created by mark on 14-5-27.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMapKit.h"

@interface implBMKSearchDelegate : NSObject<BMKSearchDelegate>{
    BMKMapView *_mapView;
}
@property BMKMapView *mapView;
@end
