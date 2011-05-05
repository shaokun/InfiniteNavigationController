//
//  MyTableViewController.h
//  MyTable
//
//  Created by Shaokun Wu on 4/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyXMLParser.h"

@interface MyTableViewController : UIViewController <MyXMLParserDelegate, UINavigationControllerDelegate> {
    MyXMLParser *parser;
    IBOutlet UIButton *nextButton;
    IBOutlet UITextView *textView;
}

- (void)startParser;
- (void)cancelParser;

@end
