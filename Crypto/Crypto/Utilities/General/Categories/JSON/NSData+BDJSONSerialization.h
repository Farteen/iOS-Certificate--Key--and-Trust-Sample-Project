//
//  BDUtilities
//
//  Created by Patrick Hogan/Manuel Zamora 2012
//


////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public Interface
////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface NSData (BDJSONSerialization)

- (NSMutableDictionary *)JSONObject:(BDError *)error;
- (NSMutableArray *)JSONArray:(BDError *)error;

@end
