//
//  Models.swift
//  Instagram App
//
//  Created by Dilan Pramodya on 2021-03-16.
//

import Foundation

enum Gender {
    case male, female, other
}

struct User {
    let username: String
    let bio: String
    let name: (first: String, last: String)
    let birthDate: Date
    let gender: Gender
    let counts: UserCount
    let joinDate: Date
}

struct UserCount {
    let followers: Int
    let following: Int
    let posts: Int
}

public enum UserPostType {
    case photo, video
}

public struct UserPost {
    let identifire: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL //either video url or full resolution photo
    let caption: String?
    let likeCount: [PostLike]
    let comments: [PostComment]
    let createdDate: Date
    let tagUsers: [String]
}

struct PostLike {
    let username: String
    let postIdentifire: String
}

struct CommentLike {
    let username: String
    let commentIdentifire: String
}

struct PostComment {
    let identifire: String
    let username: String
    let text: String
    let createdDate: Date
    let like: [CommentLike]
}
