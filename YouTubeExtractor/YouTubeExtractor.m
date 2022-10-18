#import "YouTubeExtractor.h"

@implementation YouTubeExtractor

+ (NSDictionary *)youtubePlayerRequest :(NSString *)clientName :(NSString *)clientVersion :(NSString *)videoID {
    NSLocale *locale = [NSLocale currentLocale];
	NSString *countryCode = [locale objectForKey:NSLocaleCountryCode];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.youtube.com/youtubei/v1/player?key=AIzaSyAO_FJ2SlqU8Q4STEHLGCilw_Y9_11qcW8&prettyPrint=false"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"CONSENT=YES+" forHTTPHeaderField:@"Cookie"];
    NSString *jsonBody = [NSString stringWithFormat:@"{\"context\":{\"client\":{\"hl\":\"en\",\"gl\":\"%@\",\"clientName\":\"%@\",\"clientVersion\":\"%@\",\"playbackContext\":{\"contentPlaybackContext\":{\"signatureTimestamp\":\"sts\",\"html5Preference\":\"HTML5_PREF_WANTS\"}}}},\"contentCheckOk\":true,\"racyCheckOk\":true,\"videoId\":\"%@\"}", countryCode, clientName, clientVersion, videoID];
    [request setHTTPBody:[jsonBody dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    
    __block NSData *requestData;
    __block BOOL requestFinished = NO;
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        requestData = data;
        requestFinished = YES;
    }] resume];

    while (!requestFinished) {
        [NSThread sleepForTimeInterval:0.02];
    }

    return [NSJSONSerialization JSONObjectWithData:requestData options:0 error:nil];
}

+ (NSDictionary *)sponsorBlockRequest :(NSString *)videoID {
    NSString *options = @"[%22sponsor%22,%22selfpromo%22,%22interaction%22,%22intro%22,%22outro%22,%22preview%22,%22music_offtopic%22]";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://sponsor.ajay.app/api/skipSegments?videoID=%@&categories=%@", videoID, options]]];
    
    __block NSData *requestData;
    __block BOOL requestFinished = NO;
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        requestData = data;
        requestFinished = YES;
    }] resume];

    while (!requestFinished) {
        [NSThread sleepForTimeInterval:0.02];
    }

    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:requestData options:0 error:nil];
    if ([NSJSONSerialization isValidJSONObject:jsonResponse]) {
        return jsonResponse;
    } else {
        return nil;
    }
}

@end