//
//  TDFoldingCardViewModel.h
//  TestDemo
//
//  Created by guoran on 2018/3/7.
//

#import <Foundation/Foundation.h>
#import "TDCommand.h"

@interface TDFoldingCardViewModel : NSObject

@property (nonatomic, strong, readonly) TDCommand<NSDictionary *, NSDictionary *> *cardCommand;

@end
