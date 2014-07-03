//
//  MapPopView.h
//  WhereWeGo
//
//  Created by lifuyong on 14-2-12.
//  Copyright (c) 2014年 lifuyong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@class NearbyOtherInfo;

@protocol MapPopViewDelegate <NSObject>
@required
- (void)addRounteLineWithPosition:(CLLocationCoordinate2D)coordinate;

@optional
-(void)viewPopViewDetailInScenicSpot:(NearbyOtherInfo *)info;

-(void)pmViewPopView:(id)sender;

@end


@interface MapPopView : UIView

@property (weak, nonatomic) id<MapPopViewDelegate> delegate;
@property (strong, nonatomic) NearbyOtherInfo *info;
@property (weak, nonatomic) IBOutlet UIButton *goBtn;
@property (weak, nonatomic) IBOutlet UIButton *pMBtn;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelAddress;
- (void)setMapPopViewWithVenue:(NearbyOtherInfo *)info;

@end
