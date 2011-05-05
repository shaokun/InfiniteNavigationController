#import "MyXMLParser.h"


@implementation MyXMLParser

@synthesize url, resultArray, delegate, xmlParser;

- (id)initWithUrl:(NSURL *)aUrl {
    self = [super init];
    
    if (self) {
        self.url = aUrl;
        self.resultArray = [NSMutableArray array];
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

- (void)_parse {
//    if (self.operation.isCancelled) return;
    
    [self.resultArray removeAllObjects];
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:self.url];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;    
    self.xmlParser = parser;
    
    [data release];
    [parser release];

    sleep(2);

//    if (self.operation.isCancelled) return;
    [self.xmlParser parse];
}

- (void)parse {
    NSInvocationOperation *operation = [[[NSInvocationOperation alloc] initWithTarget:self selector:@selector(_parse) object:nil] autorelease];

    [queue addOperation:operation];
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
