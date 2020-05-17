//
//  LobstersAPIClient.swift
//  coding-news
//
//  Created by Erwan Leboucher on 17/05/2020.
//  Copyright © 2020 Erwan Leboucher. All rights reserved.
//

import Foundation
import Combine

class LobstersAPIClient {
  static let baseUrl = URL(string: "https://lobste.rs/")!
  static let apiClient = APIClient()


  static func request(_ path: String, page: Int = 1) -> AnyPublisher<[LobstersPostElement], Error> {

    guard var components = URLComponents(url: baseUrl.appendingPathComponent(path), resolvingAgainstBaseURL: true)
      else { fatalError("Couldn't create URLComponents") }
    components.queryItems = [URLQueryItem(name: "format", value: "json"), URLQueryItem(name: "page", value: String(page))]

    let request = URLRequest(url: components.url!)

    return apiClient.run(request)
      .map(\.value)
      .eraseToAnyPublisher()
  }
}
