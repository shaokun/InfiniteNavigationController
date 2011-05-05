#import <Foundation/Foundation.h>

@protocol MyXMLParserDelegate

- (void)parserFinished:(NSArray *)result;

@end

@interface MyXMLParser : NSObject <NSXMLParserDelegate> {
    NSOperationQueue *queue;
}

@property (nonatomic, retain) NSURL *url;
@property (nonatomic, assign) id<MyXMLParserDelegate> delegate;

@property (retain) NSMutableArray *resultArray;
@property (retain) NSXMLParser *xmlParser;

- (id)initWithUrl:(NSURL *)url;
- (void)parse;
- (void)cancel;

@end
