//
//  ViewController.m
//  KK_NO_COMPILE
//
//  Created by TsuiYuenHong on 2017/9/8.
//  Copyright © 2017年 TsuiYuenHong. All rights reserved.
//

#import "ViewController.h"
#import "KKNoCompileEngine.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *testLabel;
@property (weak, nonatomic) IBOutlet UIImageView *testImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 启动 KKNoCompileEngine
    [KKNoCompileEngine startEngineWithJSPath:@"/Users/TsuiYuenHong/Desktop/main.js" host:@"127.0.0.1" port:9527];
    [KKNoCompileEngine enableDebugLog:YES];
    
    [self configUI];
}

- (void)configUI{
    self.testLabel.text = @"2";
    self.testLabel.textColor = [UIColor redColor];
    [self.testLabel sizeToFit];
    
    self.testImageView.image = [UIImage imageNamed:@"1"];
}

- (IBAction)clickReloadBtn:(id)sender {
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
