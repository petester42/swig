//
//  SWm
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWLogConfiguration.h"
#import "NSString+String.h"

@interface SWLogConfiguration ()

@end

@implementation SWLogConfiguration

-(instancetype)init {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    pj::LogConfig config;
    
    self.msgLogging = config.msgLogging;
    self.level = config.level;
    self.consoleLevel = config.consoleLevel;
    self.decor = config.decor;
    self.filename = [NSString stringWithCPPString:&config.filename];
    self.fileFlags = config.fileFlags;
    
    return self;
}

-(pj::LogConfig)config {
    
    pj::LogConfig config;
    
    config.msgLogging = self.msgLogging;
    config.level = self.level;
    config.consoleLevel = self.consoleLevel;
    config.decor = self.decor;
    config.filename = *[self.filename CPPString];
    config.fileFlags = self.fileFlags;
    
    return config;
}

@end