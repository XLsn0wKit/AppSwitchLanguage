//
//  ViewController.m
//  AppSwitchLanguage
//
//  Created by ginlong on 2018/2/11.
//  Copyright © 2018年 ginlong. All rights reserved.
//

#import "ViewController.h"
#import "AppLocalizableHeader.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 注册通知，用于接收改变语言的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeLanguage)
                                                 name:ChangeLanguageNotificationName
                                               object:nil];
    
    _titleLabel = [[UILabel alloc] initWithFrame:(CGRectMake(100, 400, 200, 100))];
    [self.view addSubview:_titleLabel];
    _titleLabel.textColor = [UIColor redColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:40];
    [self changeLanguage];
}

- (void)changeLanguage {
    self.title = AppLocalizedString(@"languageKey", @"简体中文");
    
    NSString *rightBarButtonItemTitle = AppLocalizedString(@"switchKey", @"切换语言");
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:rightBarButtonItemTitle
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(pushToSwitchLanguageController)];
    
    
    _titleLabel.text = AppLocalizedString(@"titleLabelKey", @"简体中文");
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                              forKeyPath:ChangeLanguageNotificationName];
}

- (void)pushToSwitchLanguageController {
    SwitchLanguageController *vc = [SwitchLanguageController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
