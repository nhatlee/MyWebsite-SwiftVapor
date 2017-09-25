//
//  UserController.swift
//  MyWebsite
//
//  Created by nhatlee on 9/24/17.
//
//import App
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
    //This function has grouped: api and resource is: user
    //URL: http://localhost:8080/api/user
    func create(req: Request) throws -> ResponseRepresentable {
        let user = try User(request: req)
        if !(try Ultility.isExist(user)) {
            //Save to local database
            try user.save()
            
            users.append(user)
            var listJson: [JSON] = []
            for u in users {
                let json = try JSON(node: [
                    "name": u.userName,
                    "email": u.email,
                    "Pass" : u.password
                    ])
                listJson.append(json)
            }
            return JSON(listJson)
        } else {
            return "User with email:\(user.email) has exist in database"
        }
    }
}
