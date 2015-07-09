//
//  XMLViewController.m
//  LocalXML
//
//  Created by qianfeng on 15-2-7.
//  Copyright (c) 2015年 YGC. All rights reserved.
//

#import "XMLViewController.h"
#import "GDataXMLNode.h"
@interface XMLViewController ()

@end

@implementation XMLViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self parseXMLDirectly];
    [self parseXMLByXPath];
}

- (void)parseXMLDirectly
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"xml" ofType:@"txt"];
    NSString *strXml = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithXMLString:strXml options:0 error:nil];
    GDataXMLElement *root = [doc rootElement];
    NSLog(@"root:%@", root);
    
    NSArray *booksArray = [root elementsForName:@"books"];
    GDataXMLElement *books = booksArray[0];
    
    NSArray *bookArray = [books elementsForName:@"book"];
    for (GDataXMLElement *book in bookArray) {
        GDataXMLNode *attrId = [book attributeForName:@"id"];
        NSString *strId = attrId.stringValue;
        NSLog(@"id=%@", strId);
        
        GDataXMLNode *attrLanguage = [book attributeForName:@"language"];
        NSString *strLanguage = attrLanguage.stringValue;
        NSLog(@"language=%@", strLanguage);
        
        GDataXMLElement *name = [book elementsForName:@"name"][0];
        NSLog(@"name:%@", name.stringValue);
        NSLog(@"name.name:%@", name.name);
        NSLog(@"name.XMLString:%@", name.XMLString);
        
    }
    
}

- (void)parseXMLByXPath
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"xml" ofType:@"txt"];
    NSData *dataXml = [NSData dataWithContentsOfFile:path];
    
    GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithData:dataXml options:0 error:nil];
    
    
    NSArray *bookArray = [doc nodesForXPath:@"/root/books/book" error:nil];
   // NSArray *bookArray = [doc nodesForXPath:@"//book" error:nil];
    
    //NSLog(@"bookArray:%@", bookArray);
    for (GDataXMLElement *book in bookArray) {
        GDataXMLNode *attrId = [book attributeForName:@"id"];
        GDataXMLNode *attrLanguage = [book attributeForName:@"language"];
        NSLog(@"id=%@, language=%@", attrId.stringValue, attrLanguage.stringValue);
       // NSLog(@"book.stringValue:%@", book.stringValue);
        GDataXMLElement *name = [book elementsForName:@"name"][0];
        NSLog(@"name:%@", name);
        GDataXMLElement *auther = [book elementsForName:@"auther"][0];
        GDataXMLElement *autherName = [auther elementsForName:@"name"][0];
        NSLog(@"autherName:%@", autherName.stringValue);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
