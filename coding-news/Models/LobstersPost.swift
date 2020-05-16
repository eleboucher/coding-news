//
//  LobstersPost.swift
//  coding-news
//
//  Created by Erwan Leboucher on 16/05/2020.
//  Copyright © 2020 Erwan Leboucher. All rights reserved.
//

import Foundation

// MARK: - LobstersPostElement
struct LobstersPostElement: Codable, Identifiable {
    let shortID: String
    let shortIDURL: String
    let createdAt, title: String
    let url: String
    let score, upvotes, downvotes, commentCount: Int
    let lobsterPostDescription: String
    let commentsURL: String
    let submitterUser: SubmitterUser
    let tags: [String]

    var id:String {
        return shortID
    }

    enum CodingKeys: String, CodingKey {
        case shortID = "short_id"
        case shortIDURL = "short_id_url"
        case createdAt = "created_at"
        case title, url, score, upvotes, downvotes
        case commentCount = "comment_count"
        case lobsterPostDescription = "description"
        case commentsURL = "comments_url"
        case submitterUser = "submitter_user"
        case tags
    }
}

// MARK: - SubmitterUser
struct SubmitterUser: Codable {
    let username, createdAt: String
    let isAdmin: Bool
    let about: String
    let isModerator: Bool
    let karma: Int
    let avatarURL, invitedByUser: String
    let githubUsername, twitterUsername: String?
    let keybaseSignatures: [KeybaseSignature]?

    enum CodingKeys: String, CodingKey {
        case username
        case createdAt = "created_at"
        case isAdmin = "is_admin"
        case about
        case isModerator = "is_moderator"
        case karma
        case avatarURL = "avatar_url"
        case invitedByUser = "invited_by_user"
        case githubUsername = "github_username"
        case twitterUsername = "twitter_username"
        case keybaseSignatures = "keybase_signatures"
    }
}

// MARK: - KeybaseSignature
struct KeybaseSignature: Codable {
    let kbUsername, sigHash: String

    enum CodingKeys: String, CodingKey {
        case kbUsername = "kb_username"
        case sigHash = "sig_hash"
    }
}


extension LobstersPostElement:Equatable {
    static func ==(lhs:LobstersPostElement, rhs:LobstersPostElement) -> Bool {
        lhs.shortID == rhs.shortID
    }
}
