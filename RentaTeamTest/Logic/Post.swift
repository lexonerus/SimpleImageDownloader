//
//  Post.swift
//  RentaTeamTest
//
//  Created by Alex Krzywicki on 02.09.2021.
//

import Foundation

struct PostUserProfileImage: Codable {
  let medium: String
}

struct PostUser: Codable {
  let profile_image: PostUserProfileImage
}

struct PostUrls: Codable {
  let thumb: String
  let regular: String
  let full: String
}

struct Post: Codable {
  let id: String
  let description: String?
  let user: PostUser
  let urls: PostUrls
}
