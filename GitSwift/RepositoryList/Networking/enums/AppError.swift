//
//  AppError.swift
//  GitSwift
//
//  Created by Paulo Inocencio on 26/04/18.
//  Copyright © 2018 Poul Apps. All rights reserved.
//

import Foundation

enum AppError: Error {
    case parsingDataError
    case badUrlError
    case notConnectionError
    case serverError
}
