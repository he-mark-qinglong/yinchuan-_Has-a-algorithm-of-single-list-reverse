//
//  CarMapPopView.h
//  PudongTravel
//
//  Created by jiangjunli on 14-5-30.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NearbyOtherInfo;

@protocol MapPopViewDelegate <NSObject>
@required
- (void)addRounteLineWithVenue:(NearbyOtherInfo *)info;
@end

@interface CarMapPopView : UIView
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *goHerer;
@property (weak, nonatomic) id<MapPopViewDelegate> delegate;
@end
