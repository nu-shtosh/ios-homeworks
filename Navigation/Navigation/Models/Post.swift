//
//  Post.swift
//  Navigation
//
//  Created by Илья Дубенский on 22.11.2022.
//

struct Post {
    var author: User
    var description: String
    var image: String
    var likes: Int
    var views: Int

    static func getDefaultPosts() -> [Post] {
        let user = User.getDefaultUser()
        let posts = [
            Post(author: user, description: "многа букав", image: "a", likes: 0, views: 0),
            Post(author: user, description: "еще больше букав", image: "b", likes: 0, views: 0),
            Post(author: user, description: "мало букав", image: "c", likes: 0, views: 0),
            Post(author: user, description: "три буквы", image: "d", likes: 0, views: 0)
        ]
        return posts
    }
}
