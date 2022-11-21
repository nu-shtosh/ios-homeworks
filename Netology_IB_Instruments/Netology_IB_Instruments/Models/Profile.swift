//
//  Profile.swift
//  Netology_IB_Instruments
//
//  Created by Илья Дубенский on 21.11.2022.
//

import Foundation

struct Profile {
    let photo: String
    let name: String
    let surname: String
    let birthDay: String
    let currentTown: String
    let bio: String

    var fullName: String {
        name + " " + surname
    }

    static func getProfile() -> Profile {
        Profile(
            photo: "xxx",
            name: "Elias",
            surname: "D",
            birthDay: "03.08.1992",
            currentTown: "Barcelona",
            bio: """
            I had been working as a flight attendant for 10 years, and due to this job I know exactly what teamwork is, I can find an attitude to any person I meet and easily deal with stressful situations.

            In 2021 I began my way in IT with Python courses; made a few projects, and passed a Bootcamp in 21 School, where I learned the basics of Bash and C in a peer-to-peer format. As a result, I realized that there is no creativity in Backend development and decided to switch to Swift. I liked it a lot and currently, I’m working on my Pet-project «Home Bar», which will be on App Store shortly.

            I’m not afraid of challenging tasks, always try to find an error and fix it by myself. I know how to use google. Also, I know how to quit VIM.

            I like yoga, my favorite asana is Shavasana, but I promise not to practice it at work.
        """
        )
    }

}
