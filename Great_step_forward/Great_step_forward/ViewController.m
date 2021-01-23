//
//  ViewController.m
//  Great_step_forward
//
//  Created by Takumi  on 2018/11/22.
//  Copyright © 2018 Takumi . All rights reserved.


//画面を司るファイル．一画面につき一つViewControllerを作る必要がある？

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // コンソールにログを表示
    //        NSLog(@"Hello World!");
    // コンソールに文字を表示
    //    printf("aaa");
    
    //アプリ画面に文字を表示
        UILabel *label = [[UILabel alloc] init];
        label.text = @"Hello World!";
        [label sizeToFit];
        label.center = self.view.center;
        [self.view addSubview:label];
    
    //    int price;
    //    price = 100;
    //    NSLog(@"お会計は%d円になります。", price);
    
    
}


@end
