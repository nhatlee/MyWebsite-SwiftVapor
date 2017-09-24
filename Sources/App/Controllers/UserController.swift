//
//  UserController.swift
//  MyWebsite
//
//  Created by nhatlee on 9/24/17.
//

import Vapor
import HTTP

final class UserController: ResourceRepresentable {
    var users: [User] = []
    
    
    func index(req: Request) throws -> ResponseRepresentable {
        let user = User(userName: "coding", email: "codewar@gmail.com", password: "1234")
        return try JSON(node: [
            "name": user.userName,
            "email": user.email
            ])
    }
    
     //This is the function the figure out what method that should be called depending on the HTTP request type. We will here start with the get.
    func makeResource() -> Resource<User> {
        return Resource(
            index: index,
            store: create
        )
    }
    //This is where the 'post' request gets redirected to
    func create(req: Request) throws -> ResponseRepresentable {
//        print(req.parameters)
//        print(req.body)
        guard let email = req.parameters["email"] as? String else {
            throw Abort(.notFound, metadata: nil, reason: "email not found", identifier: nil, possibleCauses: nil, suggestedFixes: ["input your email"], documentationLinks: nil, stackOverflowQuestions: nil, gitHubIssues: nil)
        }
        let user = User(userName: "post user", email: email, password: "123456")
        users.append(user)
        var listJson: [JSON] = []
        for u in users {
            let json = try JSON(node: [
                "name": u.userName,
                "email": u.email
                ])
            listJson.append(json)
        }
        return JSON(listJson)
    }
}
