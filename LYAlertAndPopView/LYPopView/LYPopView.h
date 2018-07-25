//
//  LYPopView.h
//  LYAlertAndPopView
//
//  Created by Lee on 2018/7/12.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , ShowPopViewDirection) {
    popViewDirectionBottom = 0 ,
    popViewDirectionTop        ,
};

typedef void (^userMaterialBlock)(NSString *userId);

@interface LYPopView : UIView

@property(nonatomic,assign)ShowPopViewDirection popViewDirection;

@property(nonatomic,copy)userMaterialBlock userMaterialBlock;

-(instancetype)initWithDic:(NSDictionary *)infoDic;

-(void)showPopView;

@end
