//
//  DataCache.swift

import Foundation
class DataCache: NSObject {
    static let sharedInstance = DataCache()
    var cache = [String: String]()
}
