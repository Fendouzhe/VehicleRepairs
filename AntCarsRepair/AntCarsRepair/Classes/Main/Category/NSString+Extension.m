//
//  NSString+Extension.m
//  01-QQ聊天
//
//  Created by Apple on 15/6/22.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)


/**
 *  设置行间距和字间距并计算高度
 */
-(CGSize)textSizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize lineSpce:(CGFloat)lineSpce textAlignment:(NSTextAlignment)textAlignment{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = textAlignment;
    paraStyle.lineSpacing = lineSpce;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle};
    
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
}

-(CGSize)textSizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize{
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}



-(instancetype)appendWebpFormater{
    return [self stringByAppendingString:@"?w=0&h=0&q=70&format=webp"];
}

-(instancetype)appendWebpFormaterWithWidth:(CGFloat)width height:(CGFloat)height{
    return [self appendWebpFormaterWithWidth:width height:height quality:100];
}

-(instancetype)appendWebpFormaterWithWidth:(CGFloat)width height:(CGFloat)height quality:(NSInteger)quality{
    return [self stringByAppendingString:[NSString stringWithFormat:@"?w=%ld&h=%ld&q=%ld&format=webp",(NSInteger)width,(NSInteger)height,quality]];
}

///没有webp
-(instancetype)appendFormaterWithWidth:(CGFloat)width height:(CGFloat)height quality:(NSInteger)quality{
    return [self stringByAppendingString:[NSString stringWithFormat:@"?w=%ld&h=%ld&q=%ld",(NSInteger)width,(NSInteger)height,quality]];
}
///没有webp和图片质量
-(instancetype)appendFormaterWithWidth:(CGFloat)width height:(CGFloat)height{
    return [self stringByAppendingString:[NSString stringWithFormat:@"?w=%ld&h=%ld",(NSInteger)width,(NSInteger)height]];
}

- (BOOL)isPhoneNumber:(NSString *)str {

//    NSString *mobileNum = [str trimmingWhitespace];
//
//    if (mobileNum.length != 11)
//    {
//        return NO;
//    }
//    /**
//     * 手机号码:
//     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
//     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
//     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
//     * 电信号段: 133,153,180,181,189,177,1700
//     */
//    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
//    /**
//     * 中国移动：China Mobile
//     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
//     */
//    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
//    /**
//     * 中国联通：China Unicom
//     * 130,131,132,155,156,185,186,145,176,1709
//     */
//    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
//    /**
//     * 中国电信：China Telecom
//     * 133,153,180,181,189,177,1700
//     */
//    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
//
//
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//
//    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
//        || ([regextestcm evaluateWithObject:mobileNum] == YES)
//        || ([regextestct evaluateWithObject:mobileNum] == YES)
//        || ([regextestcu evaluateWithObject:mobileNum] == YES))
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
    
    NSString *mobileNum = [str trimmingWhitespace];
    if (mobileNum.length != 11){
        return NO;
    }
    NSString *phone = @"^[1-2]{1}[0-9]{10}$";//@"^[1-2]{1}\\d{10}$";//适配200手机号
    //NSString *phone = @"^1[0-9]{10}$";//适配到199手机号
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phone];
    if ([predicate evaluateWithObject:mobileNum] == YES) {
        return YES;
    }else{
        return NO;
    }

}

///判断是不是手机号码
- (BOOL)judgePhoneNumber{
    
//    NSString *mobileNum = [self trimmingWhitespace];
//
//    if (mobileNum.length != 11)
//    {
//        return NO;
//    }
//    /**
//     * 手机号码:
//     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
//     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
//     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
//     * 电信号段: 133,153,180,181,189,177,1700
//     */
//    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
//    /**
//     * 中国移动：China Mobile
//     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
//     */
//    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
//    /**
//     * 中国联通：China Unicom
//     * 130,131,132,155,156,185,186,145,176,1709
//     */
//    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
//    /**
//     * 中国电信：China Telecom
//     * 133,153,180,181,189,177,1700
//     */
//    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
//
//
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//
//    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
//        || ([regextestcm evaluateWithObject:mobileNum] == YES)
//        || ([regextestct evaluateWithObject:mobileNum] == YES)
//        || ([regextestcu evaluateWithObject:mobileNum] == YES))
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
    //只粗略验证
    NSString *mobileNum = [self trimmingWhitespace];
    if (mobileNum.length != 11){
        return NO;
    }
    NSString *phone = @"^[1-2]{1}[0-9]{10}$";//@"^[1-2]{1}\\d{10}$";//适配200手机号
    //NSString *phone = @"^1[0-9]{10}$";//适配到199手机号
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phone];
    if ([predicate evaluateWithObject:mobileNum] == YES) {
        return YES;
    }else{
        return NO;
    }
}

//身份证号
+ (BOOL)checkIsIdentityCard:(NSString *)identityCard{
    
    identityCard = [identityCard trimmingWhitespace];
    
    if (identityCard.length != 18) return NO;
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
    //  NSString *regex = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:identityCard]) return NO;
    
    //** 开始进行校验 *//
    
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[identityCard substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [identityCard substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }
    else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;

}

//判断是否是身份证号
- (BOOL)checkIsIdentityCard{
    //去除空格和换行
    NSString *identityCard = [self trimmingWhitespace];
    
    if (identityCard.length != 18) return NO;
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
    //  NSString *regex = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:identityCard]) return NO;
    
    //** 开始进行校验 *//
    
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[identityCard substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [identityCard substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }
    else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
}

///判断是否正确银行卡号码
- (BOOL)checKisCardNumber{
    
    NSString *cardNo = [self trimmingWhitespace];
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    //最后一位
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    //偏移到最后一位
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    allsum = oddsum + evensum;
    allsum += lastNum;
    
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}

/**
 *  判断名称是否合法
 *  @param name 名称
 *  @return yes / no
 */
-(BOOL)isNameValid{
    BOOL isValid = NO;
    NSString *name = self;
    if (name.length > 0)
    {
        for (NSInteger i=0; i<name.length; i++)
        {
            unichar chr = [name characterAtIndex:i];
            
            if (chr < 0x80)
            { //字符
                if (chr >= 'a' && chr <= 'z')
                {
                    isValid = YES;
                }
                else if (chr >= 'A' && chr <= 'Z')
                {
                    isValid = YES;
                }
                else if (chr >= '0' && chr <= '9')
                {
                    isValid = NO;
                }
                else if (chr == '-' || chr == '_')
                {
                    isValid = YES;
                }
                else
                {
                    isValid = NO;
                }
            }
            else if (chr >= 0x4e00 && chr < 0x9fa5)
            { //中文
                isValid = YES;
            }
            else
            { //无效字符
                isValid = NO;
            }
            
            if (!isValid)
            {
                break;
            }
        }
    }
    
    return isValid;
}


///移除前后空格
- (instancetype)trimmingWhitespace{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

//返回图片格式
+ (instancetype)contentTypeForImage:(UIImage *)image{
    uint8_t c;
    NSData *data ;
    if ( UIImagePNGRepresentation(image)==nil) {
        data = UIImageJPEGRepresentation(image, 1);
    }else{
        data = UIImagePNGRepresentation(image);
    }
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"jpeg";
        case 0x89:
            return @"png";
        case 0x47:
            return @"gif";
        case 0x49:
        case 0x4D:
            return @"tiff";
        case 0x52:
            if ([data length] < 12) {
                return nil;
            }
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                return @"webp";
            }
            return nil;
    }
    return nil;
}

//计算字节数
- (NSInteger) countOfNumericInString {
    NSString *str = self;
    NSInteger length = [str lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    length -= (length - str.length) / 2;
    length = (length +1) / 2;
    //LRLog(@"str = %@ length = %lu",str, length);
    return length;
}

//截取指定字节数
- (instancetype) subTextStringToLen:(NSInteger)len {
    NSString *str = self;
    if(str.length<=len)return str;
    int count=0;
    NSMutableString *sb = [NSMutableString string];
    
    for (int i=0; i<str.length; i++) {
        NSRange range = NSMakeRange(i, 1) ;
        NSString *aStr = [str substringWithRange:range];
        count += [aStr lengthOfBytesUsingEncoding:NSUTF8StringEncoding]>1?2:1;
        [sb appendString:aStr];
        if(count >= len*2) {
            return (i==str.length-1)?[sb copy]:[NSString stringWithFormat:@"%@...",[sb copy]];
        }
    }
    return str;
}

///*
// /** 检查护照是否合法 */
//public static final String PASSPORT1 = "/^[a-zA-Z]{5,17}$/";
//public static final String PASSPORT2 = "/^[a-zA-Z0-9]{5,17}$/";
///** 港澳通行证验证     */
//public static final String HKMAKAO = "/^[HMhm]{1}([0-9]{10}|[0-9]{8})$/";
///** 台湾通行证验证     */
//public static final String TAIWAN1 = " /^[0-9]{8}$/";
//public static final String TAIWAN2 = "/^[0-9]{10}$/";
// */
/** 检查护照是否合法 */
- (BOOL)checkHuZhao{
    /*
    NSString *numStr = [self trimmingWhitespace];
    NSString *CU = @"^[a-zA-Z]{5,17}$";
    NSString *CT = @"^[a-zA-Z0-9]{5,17}$";

    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];

    if (([regextestmobile evaluateWithObject:numStr] == YES) || ([regextestcm evaluateWithObject:numStr] == YES)){
        return YES;
    }else{
        return NO;
    }
     */
    //简单验证（非E、D、S、P、G开头且后面为8位数字）
    NSString *numStr = [self trimmingWhitespace];
    if (numStr.length != 9) {
        return NO;
    }
    if ([numStr hasPrefix:@"E"] || [numStr hasPrefix:@"e"] || [numStr hasPrefix:@"D"] || [numStr hasPrefix:@"d"] || [numStr hasPrefix:@"S"] || [numStr hasPrefix:@"s"] || [numStr hasPrefix:@"P"] || [numStr hasPrefix:@"p"] || [numStr hasPrefix:@"G"] || [numStr hasPrefix:@"g"]) {
        return NO;
    }
    NSString *last = [numStr substringFromIndex:numStr.length-8];
    LRLog(@"last = %@",last);
//    NSString *predicateStr = @"^[0-9]*$";
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",predicateStr];
//    return [predicate evaluateWithObject:last];
    return [last checkDigtalChacter];
}

/** 港澳通行证验证 */
- (BOOL)checkGangAoPassport{
    /*
    NSString *numStr = [self trimmingWhitespace];
    NSString *CU = @"^[HMhm]{1}([0-9]{10}|[0-9]{8})$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    return [regextestmobile evaluateWithObject:numStr];
     */
    //简单验证
    NSString *numStr = [self trimmingWhitespace];
    if (numStr.length != 11) {
        return NO;
    }
    if (![numStr hasPrefix:@"h"] && ![numStr hasPrefix:@"H"] && ![numStr hasPrefix:@"M"] && ![numStr hasPrefix:@"m"]) {
        return NO;
    }
    NSString *last = [numStr substringFromIndex:1];
    return [last checkEnglishDigtalChacter];
    //return YES;
}

/** 台湾通行证验证 */
- (BOOL)checkTWPassport{
    
    NSString *numStr = [self trimmingWhitespace];
    NSString *CU = @"^[0-9]{8}$";
    NSString *CT = @"^[0-9]{10}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:numStr] == YES) || ([regextestcm evaluateWithObject:numStr] == YES)){
        return YES;
    }else{
        return NO;
    }
}

//  /^[a-zA-Z]{3}\d{12}$/
/** 外国人永久居留身份证 */
- (BOOL)checkWGJZcard{
    NSString *numStr = [self trimmingWhitespace];
    NSString *predictStr = @"^[a-zA-Z]{3}\\d{12}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",predictStr];
    return [predicate evaluateWithObject:numStr];
}

//由26个英文字母组成的字符串
- (BOOL)checkEnglishChacter{
    NSString *numStr = [self trimmingWhitespace];
    NSString *predictStr = @"^[A-Za-z]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",predictStr];
    return [predicate evaluateWithObject:numStr];
}

//由26个大写英文字母组成的字符串
- (BOOL)checkEnglishUPChacter{
    NSString *numStr = [self trimmingWhitespace];
    NSString *predictStr = @"^[A-Z]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",predictStr];
    return [predicate evaluateWithObject:numStr];
}

//由26个小写英文字母组成的字符串
- (BOOL)checkEnglishLowChacter{
    NSString *numStr = [self trimmingWhitespace];
    NSString *predictStr = @"^[a-z]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",predictStr];
    return [predicate evaluateWithObject:numStr];
}

//由26个英文字母和数字组成的字符串
- (BOOL)checkEnglishDigtalChacter{
    NSString *numStr = [self trimmingWhitespace];
    NSString *predictStr = @"^[A-Za-z0-9]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",predictStr];
    return [predicate evaluateWithObject:numStr];
}

//是否数字组成
- (BOOL)checkDigtalChacter{
    NSString *numStr = [self trimmingWhitespace];
    NSString *predictStr = @"^[0-9]*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",predictStr];
    return [predicate evaluateWithObject:numStr];
}

//获取指定月的第一天和最后一天  调用格式（yyyy-MM）
+ (NSString *)getMonthBeginAndEndWith:(NSString *)dateStr{
    
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM"];
    NSDate *newDate=[format dateFromString:dateStr];
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSMonthCalendarUnit startDate:&beginDate interval:&interval forDate:newDate];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return @"";
    }
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyy.MM.dd"];
    NSString *beginString = [myDateFormatter stringFromDate:beginDate];
    NSString *endString = [myDateFormatter stringFromDate:endDate];
    NSString *s = [NSString stringWithFormat:@"%@-%@",beginString,endString];
    return s;
}

//获取指定月的最后一天  调用格式（yyyy-MM）
+ (NSString *)getMonthEndWith:(NSString *)dateStr{
    
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM"];
    NSDate *newDate=[format dateFromString:dateStr];
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSMonthCalendarUnit startDate:&beginDate interval:&interval forDate:newDate];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return @"";
    }
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyy-MM-dd"];
    //NSString *beginString = [myDateFormatter stringFromDate:beginDate];
    NSString *endString = [myDateFormatter stringFromDate:endDate];
    return endString;
}

@end
