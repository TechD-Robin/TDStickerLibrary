//
//  NSString+TechD.m
//  Foundation+TechD
//
//  Created by Robin Hsu on 2015/3/18.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import <regex.h>
#import "NSString+TechD.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@implementation NSString (TechD)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) isNumeric
{
    NSNumberFormatter             * numberFormatter;
    
    //numberFormatter                 = [[NSNumberFormatter alloc] init];
    numberFormatter                 = [NSNumberFormatter new];
    if ( nil == numberFormatter )
    {
        return NO;
    }
    
    if ( [numberFormatter numberFromString: self] == nil )
    {
        return NO;
    }
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) compareByRegularExpression:(NSString *)regularExpression
{
//    NSParameterAssert( regularExpression );
//    
//    NSPredicate                   * predicate;
//    
//    predicate                       = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", regularExpression];
//    NSParameterAssert( predicate );
//    return [predicate evaluateWithObject: self];
    
    NSParameterAssert( regularExpression );
    
    regex_t                         regular;
    int                             result;
    int                             length;
    regmatch_t                      matches[1];

    char                            errorMsg[BUFSIZ];

    memset( &matches, 0, sizeof(matches) );
    memset( &errorMsg, 0, sizeof( errorMsg ) );
    result                          = regcomp( &regular, [regularExpression UTF8String], REG_EXTENDED );
    if ( 0 != result )
    {
        regerror( result, &regular, errorMsg, sizeof( errorMsg ) );
        regfree( &regular );
        return NO;
    }
    
    result                          = regexec( &regular, [self UTF8String], 1, matches, 0 );
    if ( REG_NOMATCH == result )
    {
        regerror( result, &regular, errorMsg, sizeof( errorMsg ) );
        regfree( &regular );
        return NO;
    }
    
    //  must all character equal for regular expression.
    if ( 0 != matches[0].rm_so )                        //  check start character.
    {
        regfree( &regular );
        return NO;
    }

    //  when string has wide char, the check method have different length base; must set to the same base.
    length                          = strlen( [self UTF8String] );
    if ( length != matches[0].rm_eo  )   //  check match length equal or not.
    {
        regfree( &regular );
        return NO;
    }
    
    regfree( &regular );
    return YES;
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------









