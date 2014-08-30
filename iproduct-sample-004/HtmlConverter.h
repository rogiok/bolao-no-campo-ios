//
//  HtmlConverter.h
//  iproduct-sample-004
//
//  Created by Rogerio on 6/28/13.
//  Copyright (c) 2013 Rogerio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HtmlConverter : NSObject

- (NSString *)decodeHtmlEntities:(NSString *)string;

@end
