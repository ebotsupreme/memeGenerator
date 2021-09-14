//
//  Meme.swift
//  Project25-27
//
//  Created by Eddie Jung on 9/10/21.
//

import Foundation

struct Meme: Codable {
    let fileName: String
    let filePath: URL
    let topText: String
    let bottomText: String
}
