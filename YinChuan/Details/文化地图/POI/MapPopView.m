//
//  MapPopView.m
//  WhereWeGo
//
//  Created by lifuyong on 14-2-12.
//  Copyright (c) 2014年 lifuyong. All rights reserved.
//

#import "MapPopView.h"
//#import "CommonHeader.h"
//#import "NearbyData.h"

@interface MapPopView ()



@property BOOL ispop;
@end

@implementation MapPopView

//- (void)setMapPopViewWithVenue:(NearbyOtherInfo *)info
//{
//    self.info = info;
//    [self.detailBtn setBackgroundImage:[UIImage imageNamed:@"2_s.png"]
//                              forState:UIControlStateSelected];
//    [self.goBtn setBackgroundImage:[UIImage imageNamed:@"4_s.png"] forState:UIControlStateSelected];
//    [self.pMBtn setBackgroundImage:[UIImage imageNamed:@"3_s.png"] forState:UIControlStateSelected];
//    self.labelTitle.text = info->merName;
//    self.labelAddress.text = info->address;
//}
//
////照搬文化云的，在这里暂时没有什么用处，留着以后可能会用
//- (IBAction)goHereButtonClicked:(id)sender {
//    if ([self.delegate respondsToSelector:@selector(addRounteLineWithPosition:)]) {
//        CLLocationCoordinate2D pos = {self.info->lat, self.info->lng};
//        [self.delegate addRounteLineWithPosition:pos];
//    }
//}
//
//- (IBAction)pmbtnclick:(id)sender {
//    if ([self.delegate respondsToSelector:@selector(pmViewPopView:)]) {
//        [self.delegate pmViewPopView:sender];
//    }
//}
//
//-(IBAction)viewDetail:(id)sender{
//    if ([self.delegate respondsToSelector:@selector(viewPopViewDetailInScenicSpot:)]) {
//        [self.delegate viewPopViewDetailInScenicSpot:self.info];
//    }
//}
//
//- (void)addRounteLine{
//    [self goHereButtonClicked:nil];
//}
//
@end
