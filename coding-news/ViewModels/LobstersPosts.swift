//
//  LobstersPosts.swift
//  coding-news
//
//  Created by Erwan Leboucher on 16/05/2020.
//  Copyright © 2020 Erwan Leboucher. All rights reserved.
//

import Foundation
import Combine

class LobstersPosts: ObservableObject {


  @Published var lobstersPosts: [LobstersPostElement] = []
  var cancellationToken: AnyCancellable?

  // Needed for loading data
  var currentPage = 1
  var doneLoading = false
  var currentlyLoading = false


  init() {
    getPosts()
  }

  func getPosts() {
    self.currentlyLoading = true
    print("test")
    print(self.currentPage)
    cancellationToken = LobstersAPIClient.request("", page: self.currentPage)
      .mapError({ (error) -> Error in
        print(error)
        return error
      })
      .sink(receiveCompletion: { _ in },
            receiveValue: {
              for post in $0 {
                self.lobstersPosts.append(post)
              }
              self.doneLoading = ($0.count == 0)
              self.currentPage += 1
              self.currentlyLoading = false
      })

  }

  func shouldLoadMore(_ post: LobstersPostElement) -> Bool {
    if self.doneLoading || self.currentlyLoading {
      return false
    }
    if let last = self.lobstersPosts.last {
      return last == post
    }
    return false
  }

  func refresh() {
    self.currentPage = 1
    self.lobstersPosts = []
    self.getPosts()
  }
}
