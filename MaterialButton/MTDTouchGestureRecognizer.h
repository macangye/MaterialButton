//
//  MTDTouchGestureRecognizer.h
//  MaterialButton
//
//  Created by gaobo on 16/4/19.
//  Copyright © 2016年 mcy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

NS_ASSUME_NONNULL_BEGIN
@protocol MTDTouchGestureRecognizerDelegate <NSObject>
@optional
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *_Nullable)event;
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *_Nullable)event;
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *_Nullable)event;
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *_Nullable)event;
@end

@interface MTDTouchGestureRecognizer : UIGestureRecognizer

@property(nonatomic,weak) id<MTDTouchGestureRecognizerDelegate> touchDelegate;
@end
NS_ASSUME_NONNULL_END