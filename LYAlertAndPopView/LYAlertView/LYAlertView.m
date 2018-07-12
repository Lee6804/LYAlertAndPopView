//
//  LYAlertView.m
//  LYAlertAndPopView
//
//  Created by Lee on 2018/7/12.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "LYAlertView.h"

#define MainScreenRect [UIScreen mainScreen].bounds
#define MainWidth [UIScreen mainScreen].bounds.size.width
#define AVWidth (MainWidth - 120.0f)

#define Margin 16//边距
#define BtnHeight 40//btn的高度

@interface LYAlertView()

@property (nonatomic,strong)UIWindow *alertWindow;
@property (nonatomic,strong)UIView *alertView;
@property (nonatomic,strong)UILabel *titleLab;
@property (nonatomic,strong)UILabel *messageLab;
@property (nonatomic,strong)UIButton *cancelBtn;
@property (nonatomic,strong)UIButton *otherBtn;

@end

@implementation LYAlertView

-(void)initialize{
    self.isClickViewDismiss = NO;
}

-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelBtnTitle:(NSString *)cancelTitle otherBtnTitle:(NSString *)otherBtnTitle clickIndexBlock:(AlertClickIndexBlock)block{
    
    self = [super init];
    if(self){
        
        [self initialize];
        
        [self setupUIWithTitle:(NSString *)title message:(NSString *)message cancelBtnTitle:(NSString *)cancelTitle otherBtnTitle:(NSString *)otherBtnTitle clickIndexBlock:(AlertClickIndexBlock)block];
    }
    return self;
}

-(void)setupUIWithTitle:(NSString *)title message:(NSString *)message cancelBtnTitle:(NSString *)cancelTitle otherBtnTitle:(NSString *)otherBtnTitle clickIndexBlock:(AlertClickIndexBlock)block{
    
    self.backgroundColor = [UIColor colorWithWhite:.3 alpha:.7];
    self.frame = MainScreenRect;
    UIView *alertView =[[UIView alloc] init];
    alertView.backgroundColor=[UIColor whiteColor];
    alertView.layer.cornerRadius=6.0;
    alertView.layer.masksToBounds=YES;
    alertView.userInteractionEnabled=YES;
    self.alertView = alertView;
    
    if (title) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(Margin, Margin, AVWidth - Margin*2, 20)];
        titleLabel.text = title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:17];
        self.titleLab = titleLabel;
    }
    
    UILabel *messageLabel = [[UILabel alloc] init];
    messageLabel.frame = CGRectMake(Margin, _titleLab.frame.size.height+_titleLab.frame.origin.y+8, AVWidth - Margin*2, [self getSize:Margin*2 str:message].size.height);
    messageLabel.backgroundColor = [UIColor whiteColor];
    messageLabel.text = message;
    messageLabel.textColor = [UIColor lightGrayColor];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont systemFontOfSize:14];
    messageLabel.numberOfLines = 0;
    self.messageLab = messageLabel;
    
    //计算alertView的高度
    self.alertView.frame = CGRectMake(0, 0, AVWidth, self.messageLab.frame.origin.y + self.messageLab.frame.size.height + 20 + BtnHeight);
    self.alertView.center = self.center;
    [self addSubview:self.alertView];
    
    [self.alertView addSubview:self.titleLab];
    [self.alertView addSubview:self.messageLab];
    
    if (cancelTitle) {
        UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelBtn setTitle:cancelTitle forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancelBtn setBackgroundColor:[UIColor lightGrayColor]];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        cancelBtn.layer.cornerRadius = 3;
        cancelBtn.layer.masksToBounds = YES;
        [cancelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.cancelBtn = cancelBtn;
        [self.alertView addSubview:self.cancelBtn];
    }
    
    if (otherBtnTitle) {
        UIButton *otherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [otherBtn setTitle:otherBtnTitle forState:UIControlStateNormal];
        [otherBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        otherBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        otherBtn.layer.cornerRadius = 3;
        otherBtn.layer.masksToBounds = YES;
        [otherBtn setBackgroundColor:[UIColor redColor]];
        [otherBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.otherBtn = otherBtn;
        [self.alertView addSubview:self.otherBtn];
    }
    
    CGFloat btnLeftSpace = Margin;//btn到左边距
    CGFloat btn_y = _alertView.frame.size.height - 10 - BtnHeight;
    
    if (cancelTitle && !otherBtnTitle) {
        
        self.cancelBtn.tag = 0;
        self.cancelBtn.frame = CGRectMake(btnLeftSpace, btn_y, AVWidth-btnLeftSpace*2, BtnHeight);
        
    }else if (!cancelTitle && otherBtnTitle){
        
        self.otherBtn.tag=0;
        self.otherBtn.frame=CGRectMake(btnLeftSpace, btn_y, AVWidth-btnLeftSpace*2, BtnHeight);
        
    }else if (cancelTitle && otherBtnTitle){
        
        self.cancelBtn.tag = 0;
        self.otherBtn.tag = 1;
        CGFloat btnSpace = Margin;//两个btn之间的间距
        
        CGFloat btn_w =(AVWidth-btnLeftSpace*2-btnSpace)/2;
        self.cancelBtn.frame = CGRectMake(btnLeftSpace, btn_y, btn_w, BtnHeight);
        self.otherBtn.frame = CGRectMake(_alertView.frame.size.width-btn_w-btnLeftSpace, btn_y, btn_w, BtnHeight);
    }
    
    self.clickBlock=block;
}

-(void)btnClick:(UIButton *)btn{
    
    !_clickBlock ? : _clickBlock(btn.tag);
    [self dismissAlertView];
}

-(void)showAlertView{
    
    if (self.isClickViewDismiss) {
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAlertView)]];
    }
    
    UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:MainScreenRect];
    alertWindow.windowLevel=UIWindowLevelAlert;
    [alertWindow becomeKeyWindow];
    [alertWindow makeKeyAndVisible];
    [alertWindow addSubview:self];
    self.alertWindow = alertWindow;
    
    [self setShowAnimation];
}


-(void)dismissAlertView{
    
    [self removeFromSuperview];
    [self.alertWindow resignKeyWindow];
}


-(void)setShowAnimation{
    
    __weak typeof(self)weakSelf = self;
    switch (self.animationStyle) {
            
        case AnimationDefault:{
            
            [UIView animateWithDuration:0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                [weakSelf.alertView.layer setValue:@(0) forKeyPath:@"transform.scale"];
                
            } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:0.23 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    
                    [weakSelf.alertView.layer setValue:@(1.2) forKeyPath:@"transform.scale"];
                    
                } completion:^(BOOL finished) {
                    
                    [UIView animateWithDuration:0.09 delay:0.02 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        
                        [weakSelf.alertView.layer setValue:@(.9) forKeyPath:@"transform.scale"];
                        
                    } completion:^(BOOL finished) {
                        
                        [UIView animateWithDuration:0.05 delay:0.02 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                            
                            [weakSelf.alertView.layer setValue:@(1.0) forKeyPath:@"transform.scale"];
                            
                        } completion:^(BOOL finished) {
                            
                            
                        }];
                        
                    }];
                    
                }];
                
            }];
            
        }
            
            break;
            
        case AnimationLeftShake:{
            
            CGPoint startPoint = CGPointMake(-AVWidth, self.center.y);
            self.alertView.layer.position=startPoint;
            //damping:阻尼，范围0-1，阻尼越接近于0，弹性效果越明显
            //velocity:弹性复位的速度
            [UIView animateWithDuration:.8 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                
                weakSelf.alertView.layer.position=self.center;
                
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
            
        case AnimationRightShake:{
            
            CGPoint startPoint = CGPointMake(AVWidth*2, self.center.y);
            self.alertView.layer.position=startPoint;
            
            [UIView animateWithDuration:.8 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                
                weakSelf.alertView.layer.position=self.center;
                
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
            
        case AnimationTopShake:{
            
            CGPoint startPoint = CGPointMake(self.center.x, -self.alertView.frame.size.height);
            self.alertView.layer.position=startPoint;
            
            [UIView animateWithDuration:.8 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                
                weakSelf.alertView.layer.position=self.center;
                
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
        case AnimationBottomShake:{
            
            CGPoint startPoint = CGPointMake(self.center.x, self.alertView.frame.size.height + MainScreenRect.size.height);
            self.alertView.layer.position=startPoint;
            
            [UIView animateWithDuration:.8 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                
                weakSelf.alertView.layer.position=self.center;
                
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
            
        case AnimationNO:{
            
        }
            break;
            
        default:
            
            break;
    }
}

- (CGRect)getSize:(CGFloat)lessWidth str:(NSString *)str{
    CGRect labelSize = [str boundingRectWithSize:CGSizeMake(AVWidth-lessWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil] context:nil];
    return labelSize;
}

-(void)setAnimationStyle:(ShowAnimationStyle)animationStyle{
    _animationStyle=animationStyle;
}

-(void)setIsClickViewDismiss:(BOOL)isClickViewDismiss{
    _isClickViewDismiss = isClickViewDismiss;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
