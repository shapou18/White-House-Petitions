//
//  Petition.swift
//  Project 7 - White House Petitions
//
//  Created by Shana Pougatsch on 9/9/20.
//  Copyright © 2020 Shana Pougatsch. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
