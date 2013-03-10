//
//  THRadarView.h
//  CoreMotionTest
//
//  Created by Austen Green on 3/10/13.
//  Copyright (c) 2013 Austen Green. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THRadarView : UIView
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, readonly) NSArray *dataViews;
@property (nonatomic, assign) CGFloat angle;

- (void)addDataView:(UIView *)view atRadius:(CGFloat)radius angle:(CGFloat)angleInRadians;


@end
