//
//  CalloutAnnotationView.m
//  WhereWeGo
//
//  Created by lifuyong on 14-2-13.
//  Copyright (c) 2014年 lifuyong. All rights reserved.
//

#import "CalloutAnnotationView.h"

//#import "NearbyData.h"
//#import "UIView+FrameHandle.h"
@implementation CalloutAnnotationView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.canShowCallout = NO;
    }
    return self;
}
- (void)showPopView:(NearbyOtherInfo *)info
           delegate:(id<MapPopViewDelegate>)delegate
          isCarPark:(BOOL)isCarPark{
    if (self.mapPopView) {
        [self.mapPopView removeFromSuperview];
    }
    if (info != nil) {
        self.mapPopView = [[[NSBundle mainBundle] loadNibNamed:@"MapPopView" owner:self options:nil] objectAtIndex:0];
        self.centerOffset = CGPointMake(0, -120);
        self.frame = CGRectMake(0, 0, 243, 169);
        [self addSubview:self.mapPopView];
    }
    if(isCarPark){
        self.mapPopView.pMBtn.hidden = YES;
        self.mapPopView.detailBtn.hidden = YES;
       // self.mapPopView.goBtn.originX += 65;
    }
    
    self.mapPopView.delegate = delegate;
    [self.mapPopView setMapPopViewWithVenue:info];
}
@end
