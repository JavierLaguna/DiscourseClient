//
//  Log.swift
//  DiscourseClient
//
//  Created by Javier Laguna on 25/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

final class Log {
    static func error(_ text: Any?, file: String = #file, line: Int = #line) {
        guard let text = text else { return }
        print("ERROR: \(text) \nat \(line): \(file)")
    }
}
