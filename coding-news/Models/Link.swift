//
//  Link.swift
//  coding-news
//
//  Created by Erwan Leboucher on 17/05/2020.
//  Copyright © 2020 Erwan Leboucher. All rights reserved.
//

import Foundation
import SwiftUI

struct Link: Identifiable {
  let id:String
  var title: String
  var subtitle: String?
  var imageLink: String?
  var imageData: UIImage?
}
