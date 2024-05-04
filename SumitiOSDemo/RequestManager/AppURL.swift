//
//  AppURL.swift
//  SumitiOSDemo
//
//  Created by SamMac on 03/05/24.
//

import UIKit

struct Domain {
    static var baseUrl = "https://jsonplaceholder.typicode.com/posts"
}

struct APIEndpoint {
    static let limit  = "10"
}

enum HTTPHeaderField: String {
    case authentication  = "Authorization"
    case contentType     = "Content-Type"
    case acceptType      = "Accept"
    case acceptEncoding  = "Accept-Encoding"
    case acceptLangauge  = "Accept-Language"
}


