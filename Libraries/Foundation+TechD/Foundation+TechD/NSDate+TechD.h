//
//  NSDate+TechD.h
//  Foundation+TechD
//
//  Created by Robin Hsu on 2015/4/16.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


#import <Foundation/Foundation.h>
#import <Availability.h>

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  reference data :
//  UTC : Universal Time Coordinated;   GMT : Greenwich mean time.
//  date formatts string code : https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/DataFormatting/Articles/dfDateFormatting10_4.html#//apple_ref/doc/uid/TP40002369-SW1 .
//  locale identifier list :  https://gist.github.com/jacobbubu/1836273. or code '[NSLocale availableLocaleIdentifiers]'.
//
//  ------------------------------------------------------------------------------------------------
//  * notice :
//  apple's original api will not assign(or copy) new properties when create a new date instance,
//  each object of create from original api, flag of GMT always is NO.
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@interface NSDate (TechD)

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create the object.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a GMT's date object.
 *  create a GMT's date object.
 *
 *  @return object|nil              the date object or nil.
 */
+ ( instancetype ) GMT;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a GMT's date object from UTC's date.
 *  create a GMT's date object from UTC's date; when that is already GMT's object, will not transform again(return self).
 *
 *  @param sourceDate               a UTC's date.
 *
 *  @return object|nil              the date object or nil.
 */
+ ( instancetype ) convertToGMT:(NSDate *)sourceDate;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a UTC's date object from time string which locale identifier & date format.
 *  create a UTC's date object from time string which locale identifier & date format.
 *
 *  @param timeString               a date string.
 *  @param identifier               a locale identifier string; when this is nil, set to default('en_US').
 *  @param dateformat               a date format string.
 *
 *  @return object|nil              the date object or nil.
 */
+ ( instancetype ) dateWithTimeString:(NSString *)timeString locale:(NSString *)identifier format:(NSString *)dateformat;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a GMT's date object from time string which locale identifier & date format.
 *  create a GMT's date object from time string which locale identifier & date format.
 *
 *  @param timeString               a date string.
 *  @param identifier               a locale identifier string; when this is nil, set to default('en_US').
 *  @param dateformat               a date format string.
 *
 *  @return object|nil              the date object or nil.
 */
+ ( instancetype ) GMTDateWithTimeString:(NSString *)timeString locale:(NSString *)identifier format:(NSString *)dateformat;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief convert the UTC's date object to GMT's date.
 *  convert the UTC's date object to GMT's date; when that is already GMT's object, will not transform again(return self).
 *
 *  @return object|nil              the date object or nil.
 */
- ( instancetype ) GMTDate;

//  ------------------------------------------------------------------------------------------------
//  already transformed to GMT, reverse it.
/**
 *  @brief revert the GMT's date object to UTC's date.
 *  revert the GMT's date object to UTC's date. when that is already UTC's object, will not revert again(return self).
 *
 *  @return object|nil              the date object or nil.
 */
- ( instancetype ) revertToUTC;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for get methods.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a date format's string which date format & locale identifier.
 *  get a date format's string which date format & locale identifier.
 *
 *  @param dateformat               a date format string.
 *  @param identifier               a locale identifier string; when this is nil, set to default('en_US').
 *
 *  @return string|nil              the date's string or nil
 */
- ( NSString * ) stringFrom:(NSString *)dateformat locale:(NSString *)identifier;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for check.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief check the date content which is GMT's date or not.
 *  check the date content which is GMT's date or not.
 *
 *  @return YES|NO                  date is GMT or not(UTC).
 */
- ( BOOL ) isGMT;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief check effective period that's between valid date and expire date.
 *  check effective period that's between valid date and expire date; when valid or expire is nil that is mean the condition is unlimited.
 *
 *  @param validDate                a valid date of effective period.
 *  @param expireDate               a expire date of effective period.
 *
 *  @return YES|NO                  the date is in effective period or not.
 */
- ( BOOL ) isEffectivePeriod:(NSDate *)validDate and:(NSDate *)expireDate;

//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------






