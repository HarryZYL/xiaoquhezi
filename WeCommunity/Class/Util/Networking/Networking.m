//
//  Networking.m
//  WeCommunity
//
//  Created by Harry on 7/31/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "Networking.h"


@implementation Networking


#pragma mark networking


+(void)retrieveData:(NSString*)url parameters:(NSDictionary*)parameters success:(void (^)(id responseObject))ablock{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        NSString  *event = [NSString stringWithFormat:@"%@",json[@"state"]];
        if ([event isEqualToString:@"0"]) {
            [Util alertNetworingError:json[@"msg"]];
        }else{
            ablock(json[@"msg"]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

+(void)retrieveData:(NSString*)url parameters:(NSDictionary*)parameters success:(void (^)(id responseObject))ablock addition:(void (^)())ablock2{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        NSString  *event = [NSString stringWithFormat:@"%@",json[@"state"]];
        if ([event isEqualToString:@"0"]) {
            [Util alertNetworingError:json[@"msg"]];
        }else{
            ablock(json[@"msg"]);
        }
        ablock2();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

+(void)retrieveData:(NSString*)url parameters:(NSDictionary*)parameters{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

+(void)upload:(NSMutableArray*)imageArr success:(void (^)(id responseObject))ablock{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableArray *imageDataArr = [NSMutableArray arrayWithCapacity:10];
    for (UIImage *image in imageArr) {
         NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
        [imageDataArr addObject:imageData];
    }
    
    NSDictionary *parameters = nil;
    [manager POST:uploadImage parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (int i = 0 ; i<imageDataArr.count; i++) {
            NSData *imageData = imageDataArr[i];
            [formData appendPartWithFileData:imageData name:@"image" fileName:[NSString stringWithFormat:@"photo%d.jpg",i] mimeType:@"image/jpeg"];
        }
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
        NSDictionary *path = responseObject[@"msg"];
        NSMutableArray *pathResultArr = [NSMutableArray arrayWithCapacity:10];
        if ([responseObject[@"stage"] boolValue]) {
            for (NSString *key in path) {
                NSString *value = path[key];
                [pathResultArr addObject:value];
            }
        }
        ablock(pathResultArr);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@ ***** %@", operation.responseString, error);
    }];
    
}

+(void)uploadOne:(UIImage*)image success:(void (^)(id responseObject))ablock{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);

    NSDictionary *parameters = nil;
    [manager POST:uploadImage parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:imageData name:@"image" fileName:@"photo.jpg" mimeType:@"image/jpeg"];

    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        ablock(responseObject[@"msg"][@"photo.jpg"]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@ ***** %@", operation.responseString, error);
    }];
    
}






@end
