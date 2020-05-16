//
//  SitesSelector.swift
//  coding-news
//
//  Created by Erwan Leboucher on 16/05/2020.
//  Copyright © 2020 Erwan Leboucher. All rights reserved.
//

import SwiftUI


struct SitesSelector: View {
  let availableSite: [String] = ["lobste.rs"]

    var body: some View {
      NavigationView {
        List(availableSite, id: \.self) { site in
          NavigationLink(destination: LobstersPostView()) {
            SiteRow(site: site)
          }
        }
        .navigationBarTitle(Text("Coding News"))
        .listStyle(GroupedListStyle())
      }

    }
}

struct SitesSelector_Previews: PreviewProvider {
    static var previews: some View {
        SitesSelector()
    }
}
