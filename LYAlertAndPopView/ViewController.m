//
//  ViewController.m
//  LYAlertAndPopView
//
//  Created by Lee on 2018/7/12.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "ViewController.h"
#import "LYAlertView.h"
#import "LYPopView.h"

#define klScreenWidth self.view.bounds.size.width

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"LYAlertView";
    self.view.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1];
    
    NSArray *arr = @[@"渐显AlertView",@"下坠弹簧AlertView",@"上升弹簧AlertView",@"从左往右弹簧AlertView",@"从右往左弹簧AlertView",@"直显AlertView"];
    for (NSInteger i = 0; i < arr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(20, 100 + 60*i, klScreenWidth-40, 40);
        button.backgroundColor = [UIColor orangeColor];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        button.tag = 100 + i;
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    NSArray *arr1 = @[@"上升资料View",@"下坠资料View"];
    for (NSInteger i = 0; i < arr1.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(20, 100 + 60*arr.count + 60*i, klScreenWidth-40, 40);
        button.backgroundColor = [UIColor orangeColor];
        [button setTitle:arr1[i] forState:UIControlStateNormal];
        button.tag = 1000 + i;
        [button addTarget:self action:@selector(clickButton1:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        [self addMask:button];
    }
}

-(void)addMask:(UIView *)view{
    //创建渐变效果的layer
    CAGradientLayer *graLayer = [CAGradientLayer layer];
    graLayer.frame = view.bounds;
    graLayer.colors = @[(__bridge id)[[UIColor lightGrayColor] colorWithAlphaComponent:0.8].CGColor,
                        (__bridge id)[UIColor whiteColor].CGColor,
                        (__bridge id)[[UIColor whiteColor] colorWithAlphaComponent:0.8].CGColor];
    
    graLayer.startPoint = CGPointMake(0, 0);//设置渐变方向起点
    graLayer.endPoint = CGPointMake(1, 0);  //设置渐变方向终点
    graLayer.locations = @[@(0.0), @(0.0), @(0.2)]; //colors中各颜色对应的初始渐变点
    
    //通过设置颜色渐变点(locations)动画，达到预期效果
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"locations"];
    animation.duration = 2.0f;
    animation.toValue = @[@(0.9), @(1.0), @(1.0)];
    animation.removedOnCompletion = NO;
    animation.repeatCount = HUGE_VALF;
    animation.fillMode = kCAFillModeForwards;
    [graLayer addAnimation:animation forKey:@"xindong"];
    view.layer.mask = graLayer;
}

- (void)clickButton:(UIButton*)sender {
    
    LYAlertView *alert = [[LYAlertView alloc] initWithTitle:sender.titleLabel.text message:@"缘起是诗，缘离是画，这些关于岁月，关于记忆的章节，终会被时光搁置在无法触及的红尘之外，曾经，你我一别经年，可风里，总有一段美丽会与我们不期而遇，一盏琉璃，半杯心悦，端然着那一份醉人的静，这安静行走的流年，总会被过往赋予一份清喜，一份浪漫。" cancelBtnTitle:@"取消" otherBtnTitle:@"确定" alertWidth:klScreenWidth - 120.0f clickIndexBlock:^(NSInteger clickIndex) {
        NSLog(@"点击AlertView ==== %ld",clickIndex);
    }];
    
    switch (sender.tag) {
        case 100:{
            alert.isClickViewDismiss = YES;
        }
            break;
        case 101:{
            alert.animationStyle = AnimationTopShake;
        }
            break;
        case 102:{
            alert.animationStyle = AnimationBottomShake;
        }
            break;
        case 103:{
            alert.animationStyle = AnimationLeftShake;
        }
            break;
        case 104:{
            alert.animationStyle = AnimationRightShake;
        }
            break;
        case 105:{
            alert.animationStyle = AnimationNO;
        }
            break;
            
        default:
            break;
    }
    
    [alert showAlertView];
}


- (void)clickButton1:(UIButton*)sender {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:@"7.jpg" forKey:@"headImgUrl"];
    [dic setValue:@"天地不仁以万物为刍狗" forKey:@"name"];
    [dic setValue:@"686" forKey:@"fansNum"];
    [dic setValue:@"100001" forKey:@"userId"];
    [dic setValue:@"仰天大笑出门去，我辈岂是蓬蒿人" forKey:@"sign"];
    LYPopView *popView = [[LYPopView alloc] initWithDic:[dic mutableCopy]];
    
    popView.userMaterialBlock = ^(NSString *userId) {
        NSLog(@"%@",userId);
    };
    
    switch (sender.tag) {
        case 1000:{
            
        }
            break;
        case 1001:{
            popView.popViewDirection = popViewDirectionTop;
        }
            break;
            
        default:
            break;
    }
    [popView showPopView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
