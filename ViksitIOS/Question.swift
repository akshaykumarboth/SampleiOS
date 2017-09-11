//
//  Question.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 9/11/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import Foundation

public class Question {
    public var id: Int!
    public var orderId: Int!
    public var text: String!
    public var type: Int!
    public var difficultyLevel: Int!
    public var durationInSec: Int!
    public var explanation: String!
    public var comprehensivePassageText: String!
    public var points: Int!
    public var options: [Option]!
    public var answers: [Int]!
    
    init() {
        
    }
    
}
