//
//  Section.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/9/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import Foundation


struct Section {
    var genre: String!
    var movies: [String]!
    var expanded: Bool!
    
    init(genre: String, movies: [String], expanded: Bool) {
        self.genre = genre
        self.movies = movies
        self.expanded = expanded
    }
}
