//
//  User.swift
//  MyWebsite
//
//  Created by nhatlee on 9/23/17.
//

import PostgreSQLProvider

final class User: Model {
    let storage = Storage()
    
    let userName: String
    let email: String
    let password: String
    
    init(userName: String, email: String, password: String) {
        self.userName = userName
        self.email = email
        self.password = password
    }
    
    init(row: Row) throws {
        self.userName = try row.get(UserKeys.name.rawValue)
        self.email = try row.get(UserKeys.email.rawValue)
        self.password = try row.get(UserKeys.password.rawValue)
    }
}

extension User: RowRepresentable {
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(UserKeys.name.rawValue, userName)
        try row.set(UserKeys.email.rawValue, email)
        try row.set(UserKeys.password.rawValue, password)
        return row
    }
}


extension User: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self, closure: { (user) in
            user.id()
            user.string(UserKeys.name.rawValue)
            user.string(UserKeys.email.rawValue)
            user.string(UserKeys.password.rawValue)
        })
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}
