//
//  FMUIStyle.m
//  Pods
//
//  Created by yitailong on 2019/5/18.
//

#import "FMUIStyle.h"
#import <objc/runtime.h>

@implementation FMUIStyle

+ (instancetype)style {
    static dispatch_once_t onceToken;
    static FMUIStyle *uiStyle;
    dispatch_once(&onceToken, ^{
        uiStyle = [[self alloc] init];
        [uiStyle prepareFromClass:[uiStyle class]];
    });
    return uiStyle;
}

- (void)prepareFromClass:(Class)class{
    while ([class isSubclassOfClass:[FMUIStyle class]]) {
        [self propertiesForClass:class];
        class = [class superclass];
    }
}

- (void)propertiesForClass:(Class)class {
    
    @autoreleasepool {
        //get the propertys list
        unsigned int propertyCount = 0;
        objc_property_t *propertys = class_copyPropertyList(class, &propertyCount);
        
        for (int i = 0; i < propertyCount; i ++) {
            
            //get a property
            objc_property_t property = propertys[i];
            const char *propertyName = property_getName(property);
            //get property name
            NSString *propertyNameString = [NSString stringWithUTF8String:propertyName];
            
            //
            Class class = [NSNull class];
            id value;
            
            //get the property attribuates list
            unsigned int attribuatedCount = 0;
            objc_property_attribute_t *attribuates = property_copyAttributeList(property, &attribuatedCount);
            for (int j = 0; j < attribuatedCount; j ++) {
                //get the attribuate
                objc_property_attribute_t attribuate = attribuates[j];
                
                //get attribuate name and value string
                NSString *attribuateNameString = [NSString stringWithUTF8String:attribuate.name];
                NSString *attribuateValueString = [NSString stringWithUTF8String:attribuate.value];
                
                //is class type
                if ([attribuateNameString isEqualToString:@"T"]) {
                    //Get class type string
                    NSString *classTypeString = [attribuateValueString substringWithRange:NSMakeRange(2, attribuateValueString.length - 3)];
                    //Save the current class
                    class = NSClassFromString(classTypeString);
                }
                // is the value attribuate
                else if ([attribuateNameString isEqualToString:@"V"]) {
                    //class is UIColor
                    if (class == [UIColor class]) {
                        //Save the color
                        value = [self performSelector: @selector(colorWithAttribuateString:)
                                           withObject: attribuateValueString];
                    }
                    //class is UIFont
                    else if (class == [UIFont class]) {
                        //Save the font
                        value = [self performSelector: @selector(fontWithAttribuateString:)
                                           withObject: attribuateValueString];
                    }
                    else {
                        //                    LOG(@"#WARNING----- This property dont supported auto set value: %@ class type: %@",propertyNameString, NSStringFromClass(class));
                    }
                    
                }
            }
            //save the value
            [self setValue:value forKey:propertyNameString];
        }
        free(propertys);
    }
}


- (UIColor *)colorWithAttribuateString:(NSString *)attribuateString {
    NSArray *strings = [attribuateString componentsSeparatedByString:@"_"];
    UIColor *color;
    if (strings.count == 3) {
        color = [self colorFromHexString:strings.lastObject alpha:1];
    }
    else {
        //        LOG(@"WARNING--------- color attribuate string isn't comply with the name regular: %@", attribuateString);
        color = [UIColor blackColor];
    }
    return color;
}


- (UIFont *)fontWithAttribuateString:(NSString *)attribuateString {
    
    NSArray *strings = [attribuateString componentsSeparatedByString:@"_"];
    NSUInteger fontSize = [strings.lastObject integerValue];
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2];
    
    if (strings.count == 3) {
        font = [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize];
    }
    else if (strings.count == 4) { //maybe is the bold font
        if ([[strings[2] lowercaseString] isEqualToString:@"bold"]) {
            font = [UIFont fontWithName:@"PingFangSC-Medium" size:fontSize];
        }
        else {
            font = [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize];
        }
        
    }
    else if (strings.count == 5){
        //IS Custome Bold
        NSString *fontFamily = strings[2];
        NSString *fontStyle = strings[3];
        NSString *fontName = [NSString stringWithFormat:@"%@-%@", fontFamily, fontStyle];
        font = [UIFont fontWithName:fontName size:fontSize];
    }
    else {
        //        LOG(@"#WARNING-----font not supported : %@", attribuateString);
    }
    
    if (!font) {
        font = [UIFont systemFontOfSize:fontSize];
    }
    
    return font;
}


- (UIColor *)colorFromHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    
    unsigned rgbValue = 0;
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner scanHexInt:&rgbValue];
    
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:alpha];
}


@end
