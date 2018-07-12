//
//  LYPopView.m
//  LYAlertAndPopView
//
//  Created by Lee on 2018/7/12.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "LYPopView.h"

#define MainScreenRect [UIScreen mainScreen].bounds
#define MainWidth [UIScreen mainScreen].bounds.size.width
#define MainHeight [UIScreen mainScreen].bounds.size.height

#define VWidth   self.frame.size.width
#define VHeight  self.frame.size.height

#define kScreenIphoneX (([[UIScreen mainScreen] bounds].size.height)==812)
#define PopViewHeight (kScreenIphoneX ? (self.popViewDirection == 0 ? 310 : 300) : 300)*1.0

#define BorderColor [UIColor colorWithRed:215.0/255.0 green:215.0/255.0 blue:215.0/255.0 alpha:1]

@interface LYPopView()

@property(nonatomic,strong)UIWindow *popWindow;
@property(nonatomic,strong)UIView *otherClearView;
@property(nonatomic,strong)UIView *popView;
@property(nonatomic,strong)UIImageView *headImg;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *signLabel;
@property(nonatomic,strong)UILabel *fansLabel;
@property(nonatomic,strong)UIView *littleLineView;
@property(nonatomic,strong)UILabel *userIDLabel;
@property(nonatomic,strong)UIButton *followBtn;
@property(nonatomic,strong)UIView *grayLineView;

@end

@implementation LYPopView

-(instancetype)initWithDic:(NSDictionary *)infoDic{
    
    self = [super init];
    if (self) {
        
        [self setupUIWithDic:infoDic];
    }
    return self;
}


-(void)setupUIWithDic:(NSDictionary *)infoDic{
    
    self.frame = MainScreenRect;
    self.backgroundColor = [UIColor colorWithWhite:.3 alpha:.7];
    
    UIView *popView = [[UIView alloc] initWithFrame:CGRectMake(0, MainHeight - PopViewHeight, MainWidth, PopViewHeight)];
    popView.backgroundColor = [UIColor whiteColor];
    self.popView = popView;
    [self addSubview:self.popView];
    
    UIView *otherClearView = [[UIView alloc] initWithFrame:CGRectZero];
    otherClearView.backgroundColor = [UIColor clearColor];
    [otherClearView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPopView)]];
    self.otherClearView = otherClearView;
    [self addSubview:self.otherClearView];
    
    UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectMake(VWidth/2 - 45, 20, 90, 90)];
    headImg.layer.cornerRadius = 45;
    headImg.clipsToBounds = YES;
    headImg.layer.borderColor = BorderColor.CGColor;
    headImg.layer.borderWidth = 0.5;
    headImg.contentMode = UIViewContentModeScaleAspectFill;
    headImg.image = [UIImage imageNamed:[infoDic objectForKey:@"headImgUrl"]];
    self.headImg = headImg;
    [self.popView addSubview:self.headImg];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, self.headImg.frame.origin.y + self.headImg.frame.size.height + 20, MainWidth - 32, 20)];
    nameLabel.text = [infoDic objectForKey:@"name"];
    nameLabel.font = [UIFont boldSystemFontOfSize:17];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel = nameLabel;
    [self.popView addSubview:self.nameLabel];
    
    UIView *littleLineView = [[UIView alloc] initWithFrame:CGRectMake(MainWidth/2 - 0.5, self.nameLabel.frame.origin.y + self.nameLabel.frame.size.height + 25, 1, 10)];
    littleLineView.backgroundColor = [UIColor colorWithRed:193.0/255.0 green:192.0/255.0 blue:197.0/255.0 alpha:1];
    self.littleLineView = littleLineView;
    [self.popView addSubview:self.littleLineView];
    
    UILabel *fansLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, self.nameLabel.frame.origin.y + self.nameLabel.frame.size.height + 20, MainWidth/2 - 36, 20)];
    fansLabel.text = [NSString stringWithFormat:@"粉丝数：%@",[infoDic objectForKey:@"fansNum"]];
    fansLabel.font = [UIFont systemFontOfSize:13];
    fansLabel.textColor = [UIColor lightGrayColor];
    fansLabel.textAlignment = NSTextAlignmentRight;
    self.fansLabel = fansLabel;
    [self.popView addSubview:self.fansLabel];
    
    UILabel *userIDLabel = [[UILabel alloc] initWithFrame:CGRectMake(MainWidth/2 + 20, self.nameLabel.frame.origin.y + self.nameLabel.frame.size.height + 20, MainWidth/2 - 36, 20)];
    userIDLabel.text = [NSString stringWithFormat:@"主播ID：%@",[infoDic objectForKey:@"userId"]];
    userIDLabel.font = [UIFont systemFontOfSize:13];
    userIDLabel.textColor = [UIColor lightGrayColor];
    userIDLabel.textAlignment = NSTextAlignmentLeft;
    self.userIDLabel = userIDLabel;
    [self.popView addSubview:self.userIDLabel];
    
    UILabel *signLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, self.fansLabel.frame.origin.y + self.fansLabel.frame.size.height + 20, MainWidth - 32, 20)];
    signLabel.text = [infoDic objectForKey:@"sign"];
    signLabel.font = [UIFont systemFontOfSize:15];
    signLabel.textColor = [UIColor lightGrayColor];
    signLabel.textAlignment = NSTextAlignmentCenter;
    self.signLabel = signLabel;
    [self.popView addSubview:self.signLabel];
    
    UIView *grayLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.signLabel.frame.origin.y + self.signLabel.frame.size.height + 20, MainWidth, 0.5)];
    grayLineView.backgroundColor = BorderColor;
    self.grayLineView = grayLineView;
    [self.popView addSubview:self.grayLineView];
    
    UIButton *followBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    followBtn.frame = CGRectMake(8, self.grayLineView.frame.origin.y + self.grayLineView.frame.size.height + 5, MainWidth - 16, 40);
    [followBtn setTitle:@"+ 关注" forState:UIControlStateNormal];
    [followBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    followBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    self.followBtn = followBtn;
    [self.popView addSubview:self.followBtn];
    
}

-(void)showPopView{
    UIWindow *popWindow = [[UIWindow alloc] initWithFrame:MainScreenRect];
    popWindow.windowLevel = UIWindowLevelAlert;
    [popWindow becomeKeyWindow];
    [popWindow makeKeyAndVisible];
    [popWindow addSubview:self];
    self.popWindow = popWindow;
    
    [self showPopViewDirection];
}

-(void)dismissPopView{
    [UIView animateWithDuration:.5 animations:^{
        self.popView.layer.position = self.popViewDirection == 0 ? CGPointMake(self.center.x,  MainHeight + PopViewHeight/2) : CGPointMake(self.center.x,  - PopViewHeight/2);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.popWindow resignKeyWindow];
    }];
}

-(void)showPopViewDirection{
    __weak typeof(self)weakSelf = self;
    switch (self.popViewDirection) {
        case popViewDirectionBottom:{
            
            self.otherClearView.frame = CGRectMake(0, 0, MainWidth, MainHeight - PopViewHeight);
            [self filletView:self.popView corners:UIRectCornerTopLeft|UIRectCornerTopRight];
            CGPoint startPoint = CGPointMake(self.center.x, PopViewHeight + MainScreenRect.size.height);
            self.popView.layer.position = startPoint;
            
            [UIView animateWithDuration:.8 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                
                weakSelf.popView.layer.position = CGPointMake(self.center.x, MainHeight - PopViewHeight/2);
                
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
        case popViewDirectionTop:{
            
            self.otherClearView.frame = CGRectMake(0, PopViewHeight, MainWidth, MainHeight - PopViewHeight);
            [self filletView:self.popView corners:UIRectCornerBottomLeft|UIRectCornerBottomRight];
            CGPoint startPoint = CGPointMake(self.center.x, - PopViewHeight);
            self.popView.layer.position = startPoint;
            
            [UIView animateWithDuration:.8 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                
                weakSelf.popView.layer.position = CGPointMake(self.center.x, PopViewHeight/2);
                
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
            
        default:
            break;
    }
}

-(void)setPopViewDirection:(ShowPopViewDirection)popViewDirection{
    _popViewDirection = popViewDirection;
}

-(void)filletView:(UIView *)view corners:(UIRectCorner)corners{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height) byRoundingCorners:corners cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
