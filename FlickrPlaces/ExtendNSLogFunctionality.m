//
//  ExtendNSLogFunctionality.m
//  FlickrPlaces
//
//  Created by Ashley Robinson on 05/09/2013.
//  Copyright (c) 2013 Ashley Robinson. All rights reserved.
//

#import "ExtendNSLogFunctionality.h"

@implementation ExtendNSLogFunctionality

void ExtendNSLog(const char *file, int lineNumber, const char *functionName, NSString *format, ...)
{
    // Type to hold information about variable arguments.
    va_list ap;
    // Initialize a variable argument list.
    va_start (ap, format);
    // NSLog only adds a newline to the end of the NSLog format if
    // one is not already there.
    // Here we are utilizing this feature of NSLog()
    if (![format hasSuffix: @"\n"])
    {
        format = [format stringByAppendingString: @"\n"];
    }
    NSString *body = [[NSString alloc] initWithFormat:format arguments:ap];
    // End using variable argument list.
    va_end (ap);
    NSString *fileName = [[NSString stringWithUTF8String:file] lastPathComponent];
    fprintf(stderr, "(%s) (%s:%d) %s",
            functionName, [fileName UTF8String],
            lineNumber, [body UTF8String]);
}

@end
