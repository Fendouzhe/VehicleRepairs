//
//  NSMutableDictionary+Extension.m
//  ShuangKuai-iOS
//
//  Created by 宇中 on 2017/9/4.
//  Copyright © 2017年 com.shuangkuaimai. All rights reserved.
//

#import "NSMutableDictionary+Extension.h"
#import <objc/runtime.h>

@implementation NSMutableDictionary (Extension)


//+ (void)load {
//    
//    Method fromMethod = class_getInstanceMethod(objc_getClass("__NSDictionaryM"), @selector(setObject:forKey:));
//    Method toMethod = class_getInstanceMethod(objc_getClass("__NSDictionaryM"), @selector(em_setObject:forKey:));
//    method_exchangeImplementations(fromMethod, toMethod);
//}
//
//- (void)em_setObject:(id)emObject forKey:(NSString *)key {
//    if (emObject == nil) {
//        @try {
//            [self em_setObject:emObject forKey:key];
//        }
//        @catch (NSException *exception) {
//            NSLog(@"---------- %s Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
//            NSLog(@"%@", [exception callStackSymbols]);
//            emObject = [NSString stringWithFormat:@""];
//            [self em_setObject:emObject forKey:key];
//        }
//        @finally {}
//    }else {
//        [self em_setObject:emObject forKey:key];
//    }
//}


+ (void)load{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        id obj = [[self alloc]init];
        
        [obj swizzeMethod:@selector(setObject:forKey:) withMethod:@selector(safe_setObject:forKey:)];
        
        [obj swizzeMethod:@selector(removeObjectForKey:) withMethod:@selector(safe_removeObjectForKey:)];
        
    });
    
}


- (void)swizzeMethod:(SEL)origSelector withMethod:(SEL)newSelector

{
    
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, origSelector);//Method是运行时库的类
    
    Method swizzledMethod = class_getInstanceMethod(class, newSelector);
    
    BOOL didAddMethod = class_addMethod(class, origSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        
        class_replaceMethod(class, newSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        
    }else{
        
        method_exchangeImplementations(originalMethod, swizzledMethod);
        
    }
    
}

- (void)safe_setObject:(id)value forKey:(NSString* )key{
    
    if (value) {
        
        [self safe_setObject:value forKey:key];
        
    }else{
        
        LRLog(@"[NSMutableDictionary setObject: forKey: %@]值不能为空;",key);
        
    }
    
}

- (void)safe_removeObjectForKey:(NSString *)key{
    
    if ([self objectForKey:key]) {
        
        [self safe_removeObjectForKey:key];
        
    }else{
        
        LRLog(@"[NSMutableDictionary setObject: forKey: %@]值不能为空;",key);
        
    }
    
}




@end
