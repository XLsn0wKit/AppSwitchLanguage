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

- (void)useNumberFormatter {
    NSNumber *number = @(123456.78);
    
    //    NSNumber *num1 = [NSNumber numberWithDouble:1234567.8369];
    
    // ==================== 类方法 ====================
    //1.先创建一个NSNumerFormatter对象
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    //2.创建一个NSNumber对象
    NSNumber *number2 = [NSNumber numberWithDouble:12345.655521];
    //3.设置NSNumberFomatter的枚举值类型,
    formatter.numberStyle = kCFNumberFormatterDecimalStyle; /// 123,456.78
    //4.调用NSNumberFormatter的实例方法将NSNumebr对象转换为字符串格式:
    NSString *formatterString =[formatter stringFromNumber:number2];
    
    
    // 四舍五入的整数
    NSString *numberNoStyleStr = [NSNumberFormatter localizedStringFromNumber:number
                                                                  numberStyle:NSNumberFormatterNoStyle];
    
    // 小数形式
    NSString *numberDecimalStyleStr            = [NSNumberFormatter localizedStringFromNumber:number numberStyle:NSNumberFormatterDecimalStyle];
    
    // 货币形式 -- 本地化
    NSString *numberCurrencyStyleStr           = [NSNumberFormatter localizedStringFromNumber:number numberStyle:NSNumberFormatterCurrencyStyle];
    
    // 百分数形式
    NSString *numberPercentStyleStr            = [NSNumberFormatter localizedStringFromNumber:number numberStyle:NSNumberFormatterPercentStyle];
    
    // 科学计数
    NSString *numberScientificStyleStr         = [NSNumberFormatter localizedStringFromNumber:number numberStyle:NSNumberFormatterScientificStyle];
    
    // 朗读形式 -- 本地化
    NSString *numberSpellOutStyleStr           = [NSNumberFormatter localizedStringFromNumber:number numberStyle:NSNumberFormatterSpellOutStyle];
    
    // 序数形式 -- 本地化
    NSString *numberOrdinalStyleStr            = [NSNumberFormatter localizedStringFromNumber:number numberStyle:NSNumberFormatterOrdinalStyle];
    
    // 货币形式 ISO -- 本地化
    NSString *numberCurrencyISOStyleStr        = [NSNumberFormatter localizedStringFromNumber:number numberStyle:NSNumberFormatterCurrencyISOCodeStyle];
    
    // 货币形式 -- 本地化
    NSString *numberCurrencyPluralStyleStr     = [NSNumberFormatter localizedStringFromNumber:number numberStyle:NSNumberFormatterCurrencyPluralStyle];
    
    // 会计计数 -- 本地化
    NSString *numberCurrencyAccountingStyleStr = [NSNumberFormatter localizedStringFromNumber:number numberStyle:NSNumberFormatterCurrencyAccountingStyle];
    
    NSLog(@"No Style                  = %@",numberNoStyleStr);                // No Style                  = 1234568
    NSLog(@"Decimal Style             = %@",numberDecimalStyleStr);           // Decimal Style             = 1,234,567.837
    NSLog(@"Currency Style            = %@",numberCurrencyStyleStr);          // Currency Style            = $1,234,567.84
    NSLog(@"Percent Style             = %@",numberPercentStyleStr);           // Percent Style             = 123,456,784%
    NSLog(@"Scientific Style          = %@",numberScientificStyleStr);        // Scientific Style          = 1.2345678369E6
    // Spell Out Style           = one million two hundred thirty-four thousand five hundred sixty-seven point eight three six nine
    NSLog(@"Spell Out Style           = %@",numberSpellOutStyleStr);
    NSLog(@"Ordinal Style             = %@",numberOrdinalStyleStr);            // Ordinal Style             = 1,234,568th
    NSLog(@"Currency ISO Style        = %@",numberCurrencyISOStyleStr);        // Currency ISO Style        = USD1,234,567.84
    NSLog(@"Currency plural Style     = %@",numberCurrencyPluralStyleStr);     // Currency plural Style     = 1,234,567.84 US dollars
    NSLog(@"Currency accounting Style = %@",numberCurrencyAccountingStyleStr); // Currency accounting Style = $1,234,567.84
    
    // ==================== 定制 ====================
    
    NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
    
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    
    // 格式宽度
    numberFormatter.formatWidth = 15;
    
    // 填充符
    numberFormatter.paddingCharacter = @"?";
    
    // 填充位置
    numberFormatter.paddingPosition = kCFNumberFormatterPadBeforeSuffix;
    numberFormatter.positiveSuffix = @"元";
    
    NSLog(@"%@",[numberFormatter numberFromString:@"10000000元"]);  // 10000000
    
    // 缩放因子,你可以将一个数缩放指定比例,然后给其添加后缀,如传入一个3000,你希望表示为3千,就要用到这个属性
    // 防止影响后面的测试,故注掉
    //    numberFormatter.multiplier = @1000;
    
    //    NSLog(@"%@千",[numberFormatter numberFromString:@"1000"]);  // 1千
    
    //    numberFormatter.multiplier     = @0.001;
    //    numberFormatter.positiveSuffix = @"千";
    //    NSLog(@"%@",[numberFormatter stringFromNumber:@10000]);    // 10千
    
    // 机制不明确,负号,正号
    //    numberFormatter.negativeFormat = @"^";
    //    numberFormatter.positiveFormat = @"~0";
    
    // 貌似没什么用
    numberFormatter.allowsFloats = NO;
    numberFormatter.alwaysShowsDecimalSeparator = NO;
    numberFormatter.maximum = @1000;
    numberFormatter.minimum = @100;
    
    // 小数点样式
    numberFormatter.decimalSeparator = @".";
    
    // 零的样式
    numberFormatter.zeroSymbol       = @"-";
    
    // 前缀和后缀
    numberFormatter.positivePrefix = @"!";
    numberFormatter.positiveSuffix = @"元";
    numberFormatter.negativePrefix = @"@";
    numberFormatter.negativeSuffix = @"亏";
    
    // 指定符号,与我们在前面类方法中说明的一致
    NSLog(@"货币代码%@",numberFormatter.currencyCode);                     // 货币代码USD
    NSLog(@"货币符号%@",numberFormatter.currencySymbol);                   // 货币符号$
    NSLog(@"国际货币符号%@",numberFormatter.internationalCurrencySymbol);   // 国际货币符号USD
    NSLog(@"百分比符号%@",numberFormatter.percentSymbol);                   // 百分比符号%
    NSLog(@"千分号符号%@",numberFormatter.perMillSymbol);                   // 千分号符号‰
    NSLog(@"减号符号%@",numberFormatter.minusSign);                         // 减号符号-
    NSLog(@"加号符号%@",numberFormatter.plusSign);                          // 加号符号+
    NSLog(@"指数符号%@",numberFormatter.exponentSymbol);                    // 指数符号E
    
    // 整数最多位数
    numberFormatter.maximumIntegerDigits = 10;
    
    // 整数最少位数
    numberFormatter.minimumIntegerDigits = 2;
    
    // 小数位最多位数
    numberFormatter.maximumFractionDigits = 3;
    
    // 小数位最少位数
    numberFormatter.minimumFractionDigits = 1;
    
    // 数字分割的尺寸
    numberFormatter.groupingSize = 4;
    
    // 除了groupingSize决定的尺寸外,其他数字位分割的尺寸
    numberFormatter.secondaryGroupingSize = 2;
    
    // 最大有效数字个数
    numberFormatter.maximumSignificantDigits = 12;
    
    // 最少有效数字个数
    numberFormatter.minimumSignificantDigits = 3;
    
    NSLog(@"正数%@,负数%@",[numberFormatter stringFromNumber:@(+12135230.2346)],[numberFormatter stringFromNumber:@(-12135231.2346)]);  // 正数!12,13,5230.2346元,负数@12,13,5231.2346亏
    NSLog(@"零 = %@",[numberFormatter stringFromNumber:@(0)]); //  零 = -
    
    // 舍入值,比如以10为进位值,那么156就进位为160,154进位为150
    numberFormatter.roundingIncrement = @10;
    
    // 舍入方式
    numberFormatter.roundingMode = kCFNumberFormatterRoundHalfUp;
    NSLog(@"%@",[numberFormatter stringFromNumber:@123456.7890]);  // !12,3460元
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
