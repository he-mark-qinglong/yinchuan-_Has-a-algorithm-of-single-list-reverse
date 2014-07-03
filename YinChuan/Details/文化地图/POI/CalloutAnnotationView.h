//
//  CalloutAnnotationView.h
//  WhereWeGo
//
//  Created by lifuyong on 14-2-13.
//  Copyright (c) 2014年 lifuyong. All rights reserved.
//

#import "BMKAnnotationView.h"
#import "MapPopView.h"
@class CarParkInfo;
@class NearbyOtherInfo;
@interface CalloutAnnotationView : BMKAnnotationView

@property (strong, nonatomic) MapPopView *mapPopView;

- (void)showPopView:(NearbyOtherInfo *)info delegate:(id<MapPopViewDelegate>)delegate
          isCarPark:(BOOL)isCarPark;
@end
