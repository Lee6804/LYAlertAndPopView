//
//  LYAlertView.h
//  LYAlertAndPopView
//
//  Created by Lee on 2018/7/12.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , ShowAnimationStyle) {
    AnimationDefault = 0,
    AnimationLeftShake  ,
    AnimationRightShake  ,
    AnimationTopShake   ,
    AnimationBottomShake   ,
    AnimationNO         ,
};

typedef void(^AlertClickIndexBlock)(NSInteger clickIndex);

@interface LYAlertView : UIView

@property (nonatomic,copy) AlertClickIndexBlock clickBlock;

@property(nonatomic,assign)ShowAnimationStyle animationStyle;

@property(nonatomic,assign)BOOL isClickViewDismiss;//点击背景是否能够隐藏

-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelBtnTitle:(NSString *)cancelTitle otherBtnTitle:(NSString *)otherBtnTitle clickIndexBlock:(AlertClickIndexBlock)block;

-(void)showAlertView;

@end
