//
//  ExtendNSLogFunctionality.h
//  FlickrPlaces
//
//  Created by Ashley Robinson on 05/09/2013.
//  Copyright (c) 2013 Ashley Robinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExtendNSLogFunctionality : NSObject

#ifdef DEBUG
#define NSLog(args...) ExtendNSLog(__FILE__,__LINE__,__PRETTY_FUNCTION__,args);
#else
#define NSLog(x...)
#endif
void ExtendNSLog(const char *file, int lineNumber, const char *functionName, NSString *format, ...);

@end
