//
//  Items.swift
//  SaveRepo
//
//  Created by Damian Prokop on 30/03/2021.
//

import Foundation

struct Items:Codable {
    let id: Int
    let name: String
    let owner: Owner
    let html_url:String
    let stargazers_count: Int
    let language: String
}
