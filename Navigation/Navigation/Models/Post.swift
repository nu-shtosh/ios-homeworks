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
            Post(author: user,
                 description: "Настя упала и разбила подбородок. Но ничего страшного, у нее есть второй!",
                 image: "cat4",
                 likes: 3,
                 views: 3),
            Post(author: user,
                 description: "Олег попал в жуткую аварию и чудом выжил. \"Чудес не бывает\", — подумал Олег и залез обратно в горящую машину.",
                 image: "cat2",
                 likes: 0,
                 views: 1),
            Post(author: user,
                 description: "\"Бьет - значит любит\", сказал пьяный электрик и снова полез в трансформаторную будку.",
                 image: "cat1",
                 likes: 14,
                 views: 29),
            Post(author: user,
                 description: "Штирлиц стрелял вслепую. Слепая бегала зигзагами и кричала",
                 image: "cat3",
                 likes: 875,
                 views: 875)
        ]
        return posts
    }
}
