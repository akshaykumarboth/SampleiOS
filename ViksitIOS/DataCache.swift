//
//  DataCache.swift
//  HttpTest
//
//  Created by Istar Feroz on 18/07/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import Foundation
class DataCache: NSObject {
    static let sharedInstance = DataCache()
    var cache = [String: String]()
}
