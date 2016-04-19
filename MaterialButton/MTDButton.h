//
//  MTDButton.h
//  MaterialButton
//
//  Created by gaobo on 16/4/18.
//  Copyright © 2016年 mcy. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger , MTDButtonType){
    MTDButtonTypeRaised,
    MTDButtonTypeFlat,
    MTDButtonTypeFloatingAction
};

IB_DESIGNABLE
@interface MTDButton : UIButton

@property(nonatomic,strong) IBInspectable UIColor *rippleColor;
@property(nonatomic) IBInspectable NSInteger type;
//@property(nonatomic,getter=isEnabled) IBInspectable BOOL enable;
@end
