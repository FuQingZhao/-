//
//  TTContactsUtil.m
//  iNanjing
//
//  Created by Min Lin on 2018/4/1.
//  Copyright © 2018年 jsbc. All rights reserved.
//

#import "TTContactsUtil.h"

@interface TTContactsUtil ()
@property (strong, nonatomic) NSArray *contactsArray;
@property (strong, nonatomic) NSMutableArray *sectionnedContacts;
@property (strong, nonatomic) NSMutableDictionary *sectionsIndexes;
@end

static NSString * const DicKeyInitial = @"initial";
static NSString * const DicKeyContact = @"contacts";

@implementation TTContactsUtil

+ (instancetype)defaultContacts {
    static TTContactsUtil *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (void)importContacts:(NSArray<UMSUser *> *)contacts contactsHandler:(void (^)(NSArray<UMSUser *> *contacts))contactsHandler {
    // 数据初始化
    self.contactsArray = contacts;
    self.sectionnedContacts = [self getArrayOfSections];
    [contacts bk_each:^(id object) {
        [self addContact:object InSection:self.sectionnedContacts];
    }];
    contactsHandler(self.sectionnedContacts);
}


#pragma mark - Advanced getters

- (NSUInteger)numberOfInitials {
    return [self.sectionnedContacts count];
}

- (NSArray<NSString *> *)initials {
    NSMutableArray *sections = [NSMutableArray arrayWithCapacity:[self numberOfInitials]];
    [_sectionnedContacts bk_each:^(id object) {
        [sections addObj:[(NSDictionary *)object objectForKey:DicKeyInitial]];
    }];
    return sections;
}

- (NSString *)initialAtIndex:(NSUInteger)index {
    if (self.sectionnedContacts.count > 0) {
        return [(NSDictionary *)[self.sectionnedContacts objectAtIndex:index] objectForKey:DicKeyInitial];
    }
    return nil;
}

- (NSArray<UMSUser *> *)contactsForInitialAtIndex:(NSUInteger)index {
    if (self.sectionnedContacts.count > 0) {
        return [(NSDictionary *)[self.sectionnedContacts objectAtIndex:index] objectForKey:DicKeyContact];
    }
    return nil;
}

- (NSUInteger)numberOfContactsForInitialAtIndex:(NSUInteger)index {
    NSArray *contacts = [self contactsForInitialAtIndex:index];
    return [contacts count];
}

- (void)sortArrayAccordingToSettings {
    NSMutableArray *newSections = [self getArrayOfSections];
    for (NSMutableDictionary * section in _sectionnedContacts)
        for (UMSUser *contact in [section objectForKey:DicKeyContact])
            [self addContact:contact InSection:newSections];
    _sectionnedContacts = newSections;
}

- (NSArray *)filterWithText:(NSString *)text {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (NSMutableDictionary *section in _sectionnedContacts) {
        for (UMSUser *contact in [section objectForKey:DicKeyContact]) {
            NSRange nameRange = [[contact nickname] rangeOfString:text options:NSCaseInsensitiveSearch];
            if (nameRange.location != NSNotFound)
                [result addObject:contact];
        }
    }
    return result;
}


#pragma mark - Misc hidden methods

- (NSMutableArray *)getArrayOfSections {
    NSString *sections = [self sections];
    NSMutableArray *newSections = [[NSMutableArray alloc] initWithCapacity:[sections length]];
    for (NSInteger i = 0; i < [sections length]; ++i) {
        NSString *character = [sections substringWithRange:NSMakeRange(i, 1)];
        NSMutableDictionary *section = [[NSMutableDictionary alloc] init];
        [section setObject:character forKey:DicKeyInitial];
        [section setObject:[[NSMutableArray alloc] init] forKey:DicKeyContact];
        [newSections addObject:section];
    }
    return newSections;
}

- (void)addContact:(UMSUser *)contact InSection:(NSMutableArray *)sections {
    
    NSRange idx;
    
    if ([[contact nickname] length]) {
        NSString *sectionTitle = [self transformBy:[[[contact nickname] firstCharactor] uppercaseString]];
        idx = [[self sections] rangeOfString:sectionTitle options:NSCaseInsensitiveSearch];
    } else
        idx.location = NSNotFound;
    
    if (idx.location == NSNotFound)
        idx.location = [[self sections] length] - 1;
    
    NSMutableDictionary *dic = [sections objectAtIndex:idx.location];
    NSMutableArray *contacts = [dic objectForKey:DicKeyContact];
    [contacts addObject:contact];
}

- (NSString *)sections {
    
    if ([self initialsParse] == TTInitialsParseFixed) {
        return @"ABCDEFGHIJKLMNOPQRSTUVWXYZ#";
    }
    
    //get the category of the contact
    NSMutableArray *categories = [NSMutableArray array];
    for (UMSUser *aContact in self.contactsArray) {
        NSString *firstLetter = [[aContact.nickname firstCharactor] uppercaseString];
        [categories addObj:[self transformBy:firstLetter]];
    }
    
    return [self deduplicateAndSort:categories];
}

// 去重并排序
- (NSString *)deduplicateAndSort:(NSArray *)categories {
    
    NSSet *set = [NSSet setWithArray:categories];
    NSArray *objects = [set allObjects];
    
    objects = [objects sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        int ascii1 = [(NSString *)obj1 characterAtIndex:0];
        int ascii2 = [(NSString *)obj2 characterAtIndex:0];
        if (ascii1 < ascii2) { return NSOrderedAscending; }
        if (ascii1 > ascii2) { return NSOrderedDescending; }
        return NSOrderedSame;
    }];
    
    NSMutableString *string = [NSMutableString stringWithString:@""];
    [objects bk_each:^(id object) {
        [string appendString:(NSString *)object];
    }];
    
    return string;
}

// 把不是A~Z的字母统一转换为‘#’号
- (NSString *)transformBy:(NSString *)firstLetter {
    int ascii = [firstLetter characterAtIndex:0];
    if (ascii < 65 || ascii > 90) {
        firstLetter = @"#";
    }
    return firstLetter;
}

@end
