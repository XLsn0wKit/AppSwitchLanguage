

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define ChangeLanguageNotificationName @"changeLanguage"

#define AppLocalizedManager [AppLocalizable localizable]

#define AppLocalizedString(key, comment) [AppLocalizedManager localizedStringForKey:key value:comment]

@interface AppLocalizable : NSObject

@property (nonatomic,copy) void (^completion)(NSString *currentLanguage);

- (NSString *)currentLanguage; //当前语言
- (NSString *)languageFormat:(NSString*)language;
- (void)setUserlanguage:(NSString *)language;//设置当前语言

- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value;

- (UIImage *)ittemInternationalImageWithName:(NSString *)name;

+ (instancetype)localizable;

@end
