//
//  Profile.swift
//  HeroNavigation
//
//  Created by Bilal SIMSEK on 20.07.2023.
//

import Foundation

struct Profile:Identifiable{
    var id = UUID().uuidString
    var userName:String
    var profilePicture:String
    var lastMsg:String
    var lastActive:String
}

var profiles = [
Profile(userName: "Ali", profilePicture: "ali", lastMsg: "Dolar kaç olmuş!!", lastActive: "13:20"),
Profile(userName: "Veli", profilePicture: "veli", lastMsg: "Abur cubur raporları hazır ", lastActive: "12:20"),
Profile(userName: "Ahmet", profilePicture: "ahmet", lastMsg: "Bitcoin yükselmiş", lastActive: "13:45"),
Profile(userName: "Elif", profilePicture: "elif", lastMsg: "Okuyom ben ya", lastActive: "18:41"),
Profile(userName: "Ayse", profilePicture: "ayse", lastMsg: "Ne dedin senn", lastActive: "23:20"),
Profile(userName: "Kitty", profilePicture: "kitty", lastMsg: "meovvvv", lastActive: "23:20"),
]
