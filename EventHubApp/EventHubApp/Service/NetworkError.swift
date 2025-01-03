//
//  NetworkError.swift
//  EventHubApp
//
//  Created by Сергей Сухарев on 21.11.2024.
//

enum NetworkError: Error {
    case badResponse
    case invalidURL
    case noData
    case decodingError
}
