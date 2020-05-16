//
//  LobstersPosts.swift
//  coding-news
//
//  Created by Erwan Leboucher on 16/05/2020.
//  Copyright © 2020 Erwan Leboucher. All rights reserved.
//

import Foundation


class LobstersPosts: ObservableObject {
  private final var urlBase = "https://lobste.rs/?format=json&page="

  @Published var lobstersPosts = [LobstersPostElement]()

  // Needed for loading data
  var currentPage = 1
  var doneLoading = false
  var currentlyLoading = false


  init() {
    getPosts()
  }

  func getPosts() {
    let urlString = "\(urlBase)\(currentPage)"
    let url = URL(string: urlString)!
    var request = URLRequest(url: url)
    request.httpMethod = "GET"

    let task = URLSession.shared.dataTask(with: request, completionHandler: parseFromResponse)
    currentlyLoading = true
    task.resume()
  }

  func shouldLoadMore(_ post: LobstersPostElement) -> Bool {
    if doneLoading || currentlyLoading {
      return false
    }
    if let last = self.lobstersPosts.last {
      return last == post
    }
    return false
  }

  func refresh() {
    self.currentPage = 1
    self.getPosts()
  }

  func parseFromResponse(data: Data?, urlResponse: URLResponse?, error: Error?){
    guard error == nil else {
      print("\(error!)")
      DispatchQueue.main.async {
        self.currentlyLoading = false
      }
      return
    }

    guard let content = data else {
      print("No data")
      DispatchQueue.main.async {
        self.currentlyLoading = false
      }
      return
    }

    let decoder = JSONDecoder()
    do{
      let posts = try decoder.decode([LobstersPostElement].self, from: content)
      DispatchQueue.main.async {
        for post in posts {
          self.lobstersPosts.append(post)
        }
        self.currentPage += 1
        self.doneLoading = (posts.count == 0)
        self.currentlyLoading = false
      }
    } catch{
      print(error)
    }
  }
}
