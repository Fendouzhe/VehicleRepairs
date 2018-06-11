//
//  NSString+Extension.h
//  01-QQ聊天
//
//  Created by Apple on 15/6/22.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Extension)

/**
 *  设置行间距和字间距并计算高度
 */
-(CGSize)textSizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize lineSpce:(CGFloat)lineSpce textAlignment:(NSTextAlignment)textAlignment;
/**
 *  计算字符串实际占据的区域
 */
-(CGSize)textSizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

-(instancetype)appendWebpFormaterWithWidth:(CGFloat)width height:(CGFloat)height quality:(NSInteger)quality;

-(instancetype)appendWebpFormaterWithWidth:(CGFloat)width height:(CGFloat)height;

-(instancetype)appendWebpFormater;
///没有webp
-(instancetype)appendFormaterWithWidth:(CGFloat)width height:(CGFloat)height quality:(NSInteger)quality;
///没有webp和图片质量
-(instancetype)appendFormaterWithWidth:(CGFloat)width height:(CGFloat)height;

- (BOOL)isPhoneNumber:(NSString *)str;
///判断是不是手机号码
- (BOOL)judgePhoneNumber;

//判断是否是身份证号
+ (BOOL)checkIsIdentityCard:(NSString *)identityCard;

//判断是否是身份证号
- (BOOL)checkIsIdentityCard;

///判断是否正确银行卡号码
- (BOOL)checKisCardNumber;

/**
 *  判断名称是否合法
 *  @param name 名称
 *  @return yes / no
 */
-(BOOL)isNameValid;

///移除前后空格
- (instancetype)trimmingWhitespace;
//返回图片格式
+ (instancetype)contentTypeForImage:(UIImage *)image;

//计算字节数
- (NSInteger) countOfNumericInString;

//截取指定字节数
- (instancetype) subTextStringToLen:(NSInteger)len;

/** 检查护照是否合法 */
- (BOOL)checkHuZhao;

/** 港澳通行证验证 */
- (BOOL)checkGangAoPassport;

/** 台湾通行证验证 */
- (BOOL)checkTWPassport;

/** 外国人永久居留身份证 */
- (BOOL)checkWGJZcard;

//由26个英文字母组成的字符串
- (BOOL)checkEnglishChacter;

//由26个大写英文字母组成的字符串
- (BOOL)checkEnglishUPChacter;

//由26个小写英文字母组成的字符串
- (BOOL)checkEnglishLowChacter;

//由26个英文字母和数字组成的字符串
- (BOOL)checkEnglishDigtalChacter;

//是否数字组成
- (BOOL)checkDigtalChacter;

//获取指定月的第一天和最后一天  调用格式（yyyy-MM）
+ (NSString *)getMonthBeginAndEndWith:(NSString *)dateStr;

//获取指定月的最后一天  调用格式（yyyy-MM）
+ (NSString *)getMonthEndWith:(NSString *)dateStr;

@end
