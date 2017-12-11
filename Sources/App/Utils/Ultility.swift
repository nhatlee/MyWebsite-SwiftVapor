//
//  Utilities.swift
//  MyWebsite
//
//  Created by nhatlee on 9/25/17.
//

final class Ultility {
    class func isExist(_ user: User) throws -> Bool {
        let localUsers = try User.all()
        let list = localUsers.filter { $0.email == user.email }
        return list.count > 0
    }
}
