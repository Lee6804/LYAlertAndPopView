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

@property(nonatomic,assign)BOOL isClickViewDismiss;//是否点击背景能够隐藏
@property(nonatomic,assign)CGFloat titleFontSize;//标题字体大小
@property(nonatomic,strong)UIColor *titleColor;//标题字体颜色
@property(nonatomic,assign)CGFloat messageFontSize;//内容字体大小
@property(nonatomic,strong)UIColor *messageColor;//内容字体颜色
@property(nonatomic,strong)UIColor *confirmBtnColor;//确定按钮颜色
@property(nonatomic,strong)UIColor *cancelBtnColor;//取消按钮颜色
@property(nonatomic,assign)NSTextAlignment contentTextAlignment;//内容字体位置

-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelBtnTitle:(NSString *)cancelTitle otherBtnTitle:(NSString *)otherBtnTitle alertWidth:(CGFloat)aWidth clickIndexBlock:(AlertClickIndexBlock)block;

-(void)showAlertView;

@end
