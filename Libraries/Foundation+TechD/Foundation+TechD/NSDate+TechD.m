//
//  NSDate+TechD.m
//  Foundation+TechD
//
//  Created by Robin Hsu on 2015/4/16.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import <objc/runtime.h>
#import "NSDate+TechD.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
NSString * _GetDefaultDateFormatWithStringLength( NSInteger length )
{
    switch ( length )
    {
        case 10:    return @"yyyy-MM-dd";
        case 19:    return @"yyyy-MM-dd HH:mm:ss";
        case 23:    return @"yyyy-MM-dd HH:mm:ss.SSS";
        default:
            break;
    }
    return nil;
}



//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class NSDate


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark declare private category (Private)
//  ------------------------------------------------------------------------------------------------
@interface NSDate (Private)

//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------

@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation private category (Private)
//  ------------------------------------------------------------------------------------------------
@implementation NSDate (Private)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark declare private category (_Techd)
//  ------------------------------------------------------------------------------------------------
@interface NSDate (_Techd)

@property ( nonatomic, assign, setter = td_setTransformedGMT: ) BOOL     td_transformedGMT;
//  ------------------------------------------------------------------------------------------------

@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation private category (_Techd)
//  ------------------------------------------------------------------------------------------------
@implementation NSDate (_Techd)

//  ------------------------------------------------------------------------------------------------
@dynamic td_transformedGMT;

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation public category (Techd)
//  ------------------------------------------------------------------------------------------------
@implementation NSDate (TechD)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) td_transformedGMT
{
    return [(NSNumber *)objc_getAssociatedObject(self, @selector(td_transformedGMT)) boolValue];
}

//  ------------------------------------------------------------------------------------------------
- ( void ) td_setTransformedGMT:(BOOL)transformedGMT
{
    objc_setAssociatedObject( self, @selector( td_transformedGMT ), @(transformedGMT), OBJC_ASSOCIATION_RETAIN_NONATOMIC );
}

//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of NSObject.
//  ------------------------------------------------------------------------------------------------
- ( NSString * ) description
{
    NSDate                        * dateUTC;
    NSString                      * stringUTC;
    NSString                      * stringGMT;
    NSTimeInterval                  intervalGMT;
    
    intervalGMT                     = [[NSTimeZone localTimeZone] secondsFromGMTForDate: self];
    intervalGMT                     *= ( ( [self td_transformedGMT] == YES ) ? 2 : 1 );
    
    dateUTC                         = [NSDate dateWithTimeInterval: -intervalGMT sinceDate: self];
    stringUTC                       = [dateUTC stringFrom: @"yyyy-MM-dd HH:mm:ss.SSS" locale: nil];
    stringGMT                       = [self stringFrom: @"yyyy-MM-dd HH:mm:ss.SSS ZZZZ" locale: nil];
    
    return [NSString stringWithFormat: @"<%@: %p, \nUTC : '%@', \nGMT : '%@'>", NSStringFromClass( [self class] ), self, stringUTC, stringGMT ];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for create the object.
//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) GMT
{
    NSTimeInterval                  intervalGMT;
    NSDate                        * newDate;
    
    intervalGMT                     = [[NSTimeZone localTimeZone] secondsFromGMT];
    newDate                         = [NSDate dateWithTimeIntervalSinceNow: intervalGMT];
    NSParameterAssert( nil != newDate );
    [newDate                        td_setTransformedGMT: YES];
    return newDate;
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) convertToGMT:(NSDate *)sourceDate
{
    NSParameterAssert( nil != sourceDate );
    if ( [sourceDate td_transformedGMT] == YES )
    {
        return sourceDate;
    }
    
    NSTimeInterval                  intervalGMT;
    NSDate                        * newDate;
    
    intervalGMT                     = [[NSTimeZone localTimeZone] secondsFromGMTForDate: sourceDate];
    newDate                         = [NSDate dateWithTimeInterval: intervalGMT sinceDate: sourceDate];
    NSParameterAssert( nil != newDate );
    [newDate                        td_setTransformedGMT: YES];
    return  newDate;
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) dateWithTimeString:(NSString *)timeString locale:(NSString *)identifier format:(NSString *)dateformat
{
    NSParameterAssert( nil != timeString );
    
    //  when parameters is nil or "", use default setting.
    if ( ( nil == identifier ) || ( [identifier length] == 0 ) )
    {
        identifier                  = @"en_US";
    }
    if ( ( nil == dateformat ) || ( [dateformat length] == 0 ) )
    {
        dateformat                  = _GetDefaultDateFormatWithStringLength( [timeString length] );
    }
    NSParameterAssert( nil != dateformat );
    
    
    NSDate                        * newDate;
    NSLocale                      * locale;
    NSDateFormatter               * formatter;
    
    formatter                       = [[NSDateFormatter alloc] init];
    locale                          = [[NSLocale alloc] initWithLocaleIdentifier: identifier];
    NSParameterAssert( nil != formatter );
    NSParameterAssert( nil != locale );
    
    [formatter                      setLocale: locale];
    [formatter                      setDateFormat: dateformat];
    
    newDate                         = [formatter dateFromString: timeString];
    //NSLog( @"%@", [formatter stringFromDate: newDate] );
    return newDate;
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) GMTDateWithTimeString:(NSString *)timeString locale:(NSString *)identifier format:(NSString *)dateformat
{
    NSDate                        * newDate;
    
    newDate                         = [[self class] dateWithTimeString: timeString locale: identifier format: dateformat];
    NSParameterAssert( nil != newDate );
    return [[self class] convertToGMT: newDate];
}

//  ------------------------------------------------------------------------------------------------
- ( instancetype ) GMTDate
{
    if ( [self td_transformedGMT] == YES )
    {
        return self;
    }
    
    NSTimeInterval                  intervalGMT;
    NSDate                        * newDate;
    
    intervalGMT                     = [[NSTimeZone localTimeZone] secondsFromGMTForDate: self];
    newDate                         = [NSDate dateWithTimeInterval: intervalGMT sinceDate: self];
    NSParameterAssert( nil != newDate );
    [newDate                        td_setTransformedGMT: YES];
    return newDate;
}

//  ------------------------------------------------------------------------------------------------
- ( instancetype ) revertToUTC
{
    if ( [self td_transformedGMT] == NO )
    {
        return self;
    }
    
    NSTimeInterval                  intervalGMT;
    NSDate                        * newDate;
    
    intervalGMT                     = [[NSTimeZone localTimeZone] secondsFromGMTForDate: self];
    newDate                         = [NSDate dateWithTimeInterval: -intervalGMT sinceDate: self];
    NSParameterAssert( nil != newDate );
    [newDate                        td_setTransformedGMT: NO];
    return newDate;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for get methods.
//  ------------------------------------------------------------------------------------------------
- ( NSString * ) stringFrom:(NSString *)dateformat locale:(NSString *)identifier
{
    NSParameterAssert( nil != dateformat );
    
    //  when identifier is nil or "", use default setting.
    if ( ( nil == identifier ) || ( [identifier length] == 0 ) )
    {
        identifier                  = @"en_US";
    }

    NSLocale                      * locale;
    NSDateFormatter               * formatter;
    
    formatter                       = [[NSDateFormatter alloc] init];
    locale                          = [[NSLocale alloc] initWithLocaleIdentifier: identifier];
    NSParameterAssert( nil != formatter );
    NSParameterAssert( nil != locale );
    
    [formatter                      setLocale: locale];
    [formatter                      setDateFormat: dateformat];
    
    //  because stringFromDate always output +GMT string, if date is transformed to GMT, output string must reverse it.
    if ( [self td_transformedGMT] == YES )
    {
        return [formatter stringFromDate: [self revertToUTC]];
    }
    return [formatter stringFromDate: self];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for check.
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) isGMT
{
    return [self td_transformedGMT];
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) isEffectivePeriod:(NSDate *)validDate and:(NSDate *)expireDate
{
    //  both is nil; is true.
    if ( ( nil == validDate ) && ( nil == expireDate ) )
    {
        return YES;
    }
    
    //  just valid date; if now date < valid date then false.
    if ( nil == expireDate )
    {
        if ( [self compare: validDate] == NSOrderedAscending )
        {
            return NO;
        }
        return YES;
    }
    
    //  just expire date; if now date > expire date then false.
    if ( nil == validDate )
    {
        if ( [self compare: expireDate] == NSOrderedDescending )
        {
            return NO;
        }
        return YES;
    }
    
    //  both isn't nil;  if valid <= now <= expire then true.
    if ( ( [self compare: validDate] == NSOrderedAscending ) || ( [self compare: expireDate] == NSOrderedDescending ) )
    {
        return NO;
    }
    return YES;
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
