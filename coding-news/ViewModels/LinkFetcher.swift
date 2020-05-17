//
//  Link.swift
//  coding-news
//
//  Created by Erwan Leboucher on 17/05/2020.
//  Copyright © 2020 Erwan Leboucher. All rights reserved.
//

import Foundation
import SwiftLinkPreview

class LinkFetcher: ObservableObject {
  @Published var link: Link

  init(url: String, title: String){
    self.link = Link(id: url, title: title)
    getLinkWithURL(link.id)
  }

  func getLinkWithURL(_ id: String) {
    let linkPreview = SwiftLinkPreview()
    linkPreview.preview(id, onSuccess: { (response) in
      if response.title != nil{
        self.link.title = response.title!
      }
      if let imageURL = response.image {
        self.link.imageLink = response.image
        guard let url = URL(string: imageURL) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
          DispatchQueue.main.async {
            if (data != nil){
              self.link.imageData = UIImage(data: data!)
            }
          }
        }.resume()
      }
    }) { (error) in
      print(error)
    }
  }
}
