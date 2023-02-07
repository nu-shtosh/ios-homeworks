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
}

final class Posts {

    static let shared: Posts = .init()

    var posts: [Post]  = [
        Post(author: User.getDefaultUser(),
             description: "Настя упала и разбила подбородок. Но ничего страшного, у нее есть второй!",
             image: "cat4",
             likes: 3,
             views: 3),
        Post(author: User.getDefaultUser(),
             description: "Олег попал в жуткую аварию и чудом выжил. \"Чудес не бывает\", — подумал Олег и залез обратно в горящую машину.",
             image: "cat2",
             likes: 0,
             views: 1),
        Post(author: User.getDefaultUser(),
             description: "\"Бьет - значит любит\", сказал пьяный электрик и снова полез в трансформаторную будку.",
             image: "cat1",
             likes: 14,
             views: 29),
        Post(author: User.getDefaultUser(),
             description: "Штирлиц стрелял вслепую. Слепая бегала зигзагами и кричала",
             image: "cat3",
             likes: 875,
             views: 875)
    ]
}
