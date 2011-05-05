#import "MyXMLParser.h"


@implementation MyXMLParser

@synthesize url, resultArray, delegate, xmlParser;

- (id)initWithUrl:(NSURL *)aUrl {
    self = [super init];
    
    if (self) {
        self.url = aUrl;
        queue = [[NSOperationQueue alloc] init];
    }
    
    return self;
}

- (void)dealloc {
    [self cancel];
    [queue release];
    
    [self.url release];
    [self.xmlParser release];
    [self.resultArray release];
    
    [super dealloc];
}

- (void)_parse:(id)object {
    NSData *data = [[NSData alloc] initWithContentsOfURL:self.url];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    NSMutableArray *array = [NSMutableArray new];
    parser.delegate = self;
    
    self.xmlParser = parser;
    self.resultArray = array;

    NSInvocationOperation *operation = (NSInvocationOperation *)object;
    
//    sleep(2);

    if (!operation.isCancelled) {
        [self.xmlParser parse];
    }
    
    [data release];
    [parser release];
    [array release];
}

- (void)parse {
    NSInvocationOperation *op = [NSInvocationOperation alloc];
    op = [op initWithTarget:self selector:@selector(_parse:) object:op];
    [queue addOperation:op];
    
    [op release];
}

- (void)cancel {
    [queue cancelAllOperations];
    
    self.delegate = nil;
    self.xmlParser.delegate = nil;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    [resultArray addObject:elementName];
}

- (void)parserFinished {
    NSArray *result = [[self.resultArray copy] autorelease];
    [self.delegate parserFinished:result];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    [self performSelectorOnMainThread:@selector(parserFinished) withObject:nil waitUntilDone:NO];
}

@end
