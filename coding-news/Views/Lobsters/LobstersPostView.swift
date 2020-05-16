//
//  LobstersPostView.swift
//  coding-news
//
//  Created by Erwan Leboucher on 16/05/2020.
//  Copyright © 2020 Erwan Leboucher. All rights reserved.
//

import SwiftUI
import SwiftUIRefresh


struct NewsItemView: View {
  var lobstersPostElement: LobstersPostElement

  var body: some View {
    Button(action:{
      guard let url = URL(string: self.lobstersPostElement.url) else { return }
      UIApplication.shared.open(url)
    }) {
      HStack{
        if (self.lobstersPostElement.url != ""){
          Image(systemName: "link")
        } else {
          Image(systemName: "doc.plaintext")
        }
        VStack(alignment: .leading) {
          Text("\(lobstersPostElement.title)")
            .font(.headline)
          Text("\(lobstersPostElement.submitterUser.username)")
            .font(.subheadline)
        }.padding()
          Spacer()
          Image(systemName: "arrow.right")
      }.foregroundColor(Color.primary)
    }
  }
}
struct LobstersPostView: View {
  @State private var isShowing = false
  @ObservedObject var lobstersPosts = LobstersPosts()

  var body: some View {
    List(lobstersPosts.lobstersPosts) { post in
      NewsItemView(lobstersPostElement: post)
        .onAppear { self.elementOnAppear(post)}
    }.pullToRefresh(isShowing: $isShowing) {
      self.lobstersPosts.refresh()
      self.isShowing = false
    }
  }


  private func elementOnAppear(_ post:LobstersPostElement) {
    if self.lobstersPosts.shouldLoadMore(post) {
      self.lobstersPosts.getPosts()
    }
  }

}

struct LobstersPostView_Previews: PreviewProvider {
  static var previews: some View {
    LobstersPostView()
  }
}
