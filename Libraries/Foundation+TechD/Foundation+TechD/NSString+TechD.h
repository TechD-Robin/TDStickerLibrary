//
//  NSString+TechD.h
//  Foundation+TechD
//
//  Created by Robin Hsu on 2015/3/18.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


#import <Foundation/Foundation.h>
#import <Availability.h>

@interface NSString (TechD)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief check the string content, that type is numeric or not.
 *  check the string content, that type is numeric or not.
 *
 *  @return YES|NO                  type is numberic or not.
 */
- ( BOOL ) isNumeric;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief compare the string by regular expression.
 *  compare the string by regular expression.
 *
 *  @param regularExpression        the regular expression string.
 *
 *  @return YES|NO                  the string match by regular expression or not.
 */
- ( BOOL ) compareByRegularExpression:(NSString *)regularExpression;

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
