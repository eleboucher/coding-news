//
//  SiteRow.swift
//  coding-news
//
//  Created by Erwan Leboucher on 16/05/2020.
//  Copyright © 2020 Erwan Leboucher. All rights reserved.
//

import SwiftUI

struct SiteRow: View {
  let site: String
    var body: some View {
      HStack{
        Text(site)
        Spacer()
      }.padding()
    }
}

struct SiteRow_Previews: PreviewProvider {
    static var previews: some View {
      SiteRow(site: "Lobster")
      .previewLayout(.fixed(width: 300, height: 70))
    }
}
