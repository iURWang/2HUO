//
//  NSString+HYSCat.m
//  iUR_Util
//
//  Created by iURCoder on 11/11/15.
//  Copyright © 2015 iUR. All rights reserved.
//

#import "NSString+HYSCat.h"
#import "NSNumber+HYSCat.h"
#import "NSData+HYSCat.h"

@interface NSString_stripHtml_XMLParsee : NSObject<NSXMLParserDelegate> {
@private
    NSMutableArray* strings;
}
- (NSString*)getCharsFound;
@end
@implementation NSString_stripHtml_XMLParsee
- (id)init {
    if((self = [super init])) {
        strings = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void)parser:(NSXMLParser*)parser foundCharacters:(NSString*)string {
    [strings addObject:string];
}
- (NSString*)getCharsFound {
    return [strings componentsJoinedByString:@""];
}
@end

@implementation NSString (HYSCat)

-(NSString *)md5{
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}
- (NSString *)MD5
{
    NSData * value;
    
    value = [NSData dataWithBytes:[self UTF8String] length:[self length]];
    value = [value MD5];
    
    if ( value )
    {
        char			tmp[16];
        unsigned char *	hex = (unsigned char *)malloc( 2048 + 1 );
        unsigned char *	bytes = (unsigned char *)[value bytes];
        unsigned long	length = [value length];
        
        hex[0] = '\0';
        
        for ( unsigned long i = 0; i < length; ++i )
        {
            sprintf( tmp, "%02X", bytes[i] );
            strcat( (char *)hex, tmp );
        }
        
        NSString * result = [NSString stringWithUTF8String:(const char *)hex];
        free( hex );
        return result;
    }
    else
    {
        return nil;
    }
}

- (BOOL)isPassword  {
    NSString *		regex = @"(^[A-Za-z0-9]{6,20}$)";
    NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}

- (BOOL)isEmail
{
    NSString *		regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

- (NSDate *)stringToDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:self];
    return date;
}

- (NSDate *)stringToDateWithFormatterType:(NSString *)type
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:type];
    NSDate *date = [dateFormatter dateFromString:self];
    return date;
}

- (BOOL)isUrl {
    NSString *regex = @"http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

- (BOOL)isTelephone
{
    
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09]|7[09])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES))
    {
        if([regextestcm evaluateWithObject:self] == YES) {
            NSLog(@"China Mobile");
        } else if([regextestct evaluateWithObject:self] == YES) {
            NSLog(@"China Telecom");
        } else if ([regextestcu evaluateWithObject:self] == YES) {
            NSLog(@"China Unicom");
        } else {
            NSLog(@"Unknow");
        }
        
        return YES;
    }
    else
    {
        return NO;
    }
}

- (NSData *)dataValue {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (id)jsonValueDecoded {
    return [[self dataValue] jsonValueDecoded];
}

- (NSString *)BASE64
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] base64EncodedString];
}

- (NSString *)unBASE64
{
    NSData *data = [NSData dataWithBase64EncodedString:self];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSString *)stringByURLEncode {
    if ([self respondsToSelector:@selector(stringByAddingPercentEncodingWithAllowedCharacters:)]) {
        return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CFStringEncoding cfEncoding = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
        NSString *encoded = (__bridge_transfer NSString *)
        CFURLCreateStringByAddingPercentEscapes(
                                                kCFAllocatorDefault,
                                                (__bridge CFStringRef)self,
                                                NULL,
                                                CFSTR("!#$&'()*+,/:;=?@[]"),
                                                cfEncoding);
        return encoded;
#pragma clang diagnostic pop
    }
}

- (NSString *)stringByURLDecode {
    if ([self respondsToSelector:@selector(stringByRemovingPercentEncoding)]) {
        return [self stringByRemovingPercentEncoding];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CFStringEncoding en = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
        NSString *decoded = [self stringByReplacingOccurrencesOfString:@"+"
                                                            withString:@" "];
        decoded = (__bridge_transfer NSString *)
        CFURLCreateStringByReplacingPercentEscapesUsingEncoding(
                                                                NULL,
                                                                (__bridge CFStringRef)decoded,
                                                                CFSTR(""),
                                                                en);
        return decoded;
#pragma clang diagnostic pop
    }
}

- (NSString *)stringByEscapingHTML {
    NSUInteger len = self.length;
    if (!len) return self;
    
    unichar *buf = malloc(sizeof(unichar) * len);
    if (!buf) return nil;
    [self getCharacters:buf range:NSMakeRange(0, len)];
    
    NSMutableString *result = [NSMutableString string];
    for (int i = 0; i < len; i++) {
        unichar c = buf[i];
        NSString *esc = nil;
        switch (c) {
            case 34: esc = @"&quot;"; break;
            case 38: esc = @"&amp;"; break;
            case 39: esc = @"&apos;"; break;
            case 60: esc = @"&lt;"; break;
            case 62: esc = @"&gt;"; break;
            default: break;
        }
        if (esc) {
            [result appendString:esc];
        } else {
            CFStringAppendCharacters((CFMutableStringRef)result, &c, 1);
        }
    }
    free(buf);
    return result;
}

- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}

- (CGFloat)widthForFont:(UIFont *)font {
    CGSize size = [self sizeForFont:font size:CGSizeMake(HUGE, HUGE) mode:NSLineBreakByWordWrapping];
    return size.width;
}

- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width {
    CGSize size = [self sizeForFont:font size:CGSizeMake(width, HUGE) mode:NSLineBreakByWordWrapping];
    return size.height;
}

- (NSString *)stringByTrim {//去掉特殊符号
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

- (char)charValue {
    return self.numberValue.charValue;
}

- (unsigned char) unsignedCharValue {
    return self.numberValue.unsignedCharValue;
}

- (short) shortValue {
    return self.numberValue.shortValue;
}

- (unsigned short) unsignedShortValue {
    return self.numberValue.unsignedShortValue;
}

- (unsigned int) unsignedIntValue {
    return self.numberValue.unsignedIntValue;
}

- (long) longValue {
    return self.numberValue.longValue;
}

- (unsigned long) unsignedLongValue {
    return self.numberValue.unsignedLongValue;
}

- (unsigned long long) unsignedLongLongValue {
    return self.numberValue.unsignedLongLongValue;
}

- (NSUInteger) unsignedIntegerValue {
    return self.numberValue.unsignedIntegerValue;
}

- (NSNumber *)numberValue {
    return [NSNumber numberWithString:self];
}

- (NSString *)utf8String
{
    if (self.length > 0) {
        return [[NSString alloc] initWithData:self.dataValue encoding:NSUTF8StringEncoding];
    }
    return @"";
}

- (NSString*)stripHtml {
    // take this string obj and wrap it in a root element to ensure only a single root element exists
    // and that any ampersands are escaped to preserve the escaped sequences
    NSString* string = [self stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
    string = [NSString stringWithFormat:@"<root>%@</root>", string];
    
    // add the string to the xml parser
    NSStringEncoding encoding = string.fastestEncoding;
    NSData* data = [string dataUsingEncoding:encoding];
    NSXMLParser* parser = [[NSXMLParser alloc] initWithData:data];
    
    // parse the content keeping track of any chars found outside tags (this will be the stripped content)
    NSString_stripHtml_XMLParsee* parsee = [[NSString_stripHtml_XMLParsee alloc] init];
    parser.delegate = parsee;
    [parser parse];
    NSString* strippedString = [parsee getCharsFound];
    
    return strippedString;
}

- (NSArray *)apiStringToArray
{
    if (!self) {
        return nil;
    }else{
        return [self componentsSeparatedByString:@"/"];
    }
}

+ (NSString *)stringWithUUID {
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return (__bridge_transfer NSString *)string;
}

#pragma mark - 计算字符串尺寸
/**
 *  计算字符串高度 （多行）
 *
 *  @param width 字符串的宽度
 *  @param font  字体大小
 *
 *  @return 字符串的尺寸
 */
- (CGSize)heightWithWidth:(CGFloat)width andFont:(CGFloat)font {
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:font]};
    CGSize  size = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)  options:NSStringDrawingUsesLineFragmentOrigin  |NSStringDrawingUsesFontLeading |NSStringDrawingTruncatesLastVisibleLine attributes:attribute context:nil].size;
    return size;
}

/**
 *  计算字符串宽度
 *
 *  @param height 字符串的高度
 *  @param font  字体大小
 *
 *  @return 字符串的尺寸
 */
- (CGSize)widthWithHeight:(CGFloat)height andFont:(CGFloat)font {
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:font]};
    CGSize  size = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height)  options:NSStringDrawingUsesLineFragmentOrigin  |NSStringDrawingUsesFontLeading |NSStringDrawingTruncatesLastVisibleLine  attributes:attribute context:nil].size;
    return size;
}

#pragma mark - 检测是否含有某个字符
/**
 *  检测是否含有某个字符
 *
 *  @param string 检测是否含有的字符
 *
 *  @return YES 含有 NO 不含有
 */
- (BOOL)containString:(NSString *)string {
    return ([self rangeOfString:string].location == NSNotFound) ? NO : YES;
}

@end
