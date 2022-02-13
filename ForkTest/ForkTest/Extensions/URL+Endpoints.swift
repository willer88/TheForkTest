//
//  URL+Endpoints.swift
//  ForkTest
//
//  Created by Wilmar on 10/02/22.
//

import Foundation

extension URL {
    static func restaurants() -> URL {
        return makeForEndpoint("test.json")
    }
}

private extension URL {
    static func makeForEndpoint(_ endpoint: String) -> URL {
        URL(string: "https://alanflament.github.io/TFTest/\(endpoint)")!
    }
}
