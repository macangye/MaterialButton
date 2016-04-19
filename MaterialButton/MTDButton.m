//
//  MTDButton.m
//  MaterialButton
//
//  Created by gaobo on 16/4/18.
//  Copyright © 2016年 mcy. All rights reserved.
//

#import "MTDButton.h"
#import "MTDRippleLayer.h"
#import "UIColor+MTDHexColor.h"

@interface MTDButton()

@property(nonatomic,strong) MTDRippleLayer *rippleLayer;

@end

@implementation MTDButton


- (instancetype)init
{
    if(self = [super init]){
        [self initLayer];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder]){
        [self initLayer];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        [self initLayer];
    }
    return self;
}

- (void)initLayer
{
    if(self.backgroundColor == nil){
        self.backgroundColor = [UIColor colorHexRGBA:@"#D6D6D6"];
    }
    self.layer.cornerRadius = 2.5;
    self.imageView.clipsToBounds = NO;
    self.imageView.contentMode = UIViewContentModeCenter;
    
    ///默认灰色
    _rippleColor = [UIColor colorWithWhite:0.5 alpha:1];
    _rippleLayer = [[MTDRippleLayer alloc] initWithSuperView:self];
    _rippleLayer.rippleColor = _rippleColor;
}

- (void)setRippleColor:(UIColor *)rippleColor {
    _rippleColor = rippleColor;
    _rippleLayer.rippleColor = _rippleColor;
}


- (void)prepareForInterfaceBuilder
{
    [super prepareForInterfaceBuilder];
    if(self.backgroundColor == nil){
        self.backgroundColor = [UIColor colorHexRGBA:@"#D6D6D6"];
    }
}

@end
