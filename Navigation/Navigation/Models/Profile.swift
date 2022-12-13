//
//  Profile.swift
//  Navigation
//
//  Created by Илья Дубенский on 07.12.2022.
//

import Foundation

struct User {
    var name: String
    var surname: String
    var username: String
    var email: String
    var phone: String
    var password: String
    var status: String
    var image: String

    var fullName: String {
        name + " " + surname
    }

    static func getDefaultUser() -> User {
        User(
            name: "Foo",
            surname: "Bar",
            username: "Resu",
            email: "foobar@gmail.com",
            phone: "88005553535",
            password: "password",
            status: "*args and **kwargs...",
            image: "delias"
        )
    }
}
