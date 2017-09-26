//
//  TestController.swift
//  MyWebsite
//
//  Created by nhatlee on 9/25/17.
//
import Vapor
import HTTP
//Test controller
//final class TController: ResourceRepresentable {
//    
//    
//    func index(req: Request) throws -> ResponseRepresentable {
//        guard let email = req.data[UserKeys.email.rawValue]?.string else {
//            throw Abort(.notFound, metadata: nil, reason: "email are require", identifier: nil, possibleCauses: nil, suggestedFixes: ["input your email"], documentationLinks: nil, stackOverflowQuestions: nil, gitHubIssues: nil)
//        }
//        let listLocal = try User.all()
//        let user = listLocal.filter{$0.email == email }.first
//        return try JSON(node: [
//            "emai": email,
//            "name": user?.userName
//            ])
//    }
//    
//
//    /*
//     Notice: Group api is for those mothods:
//     index: Multiple? = nil,
//     create: Multiple? = nil,
//     store: Multiple? = nil,
//     show: Item? = nil,
//     edit: Item? = nil,
//     update: Item? = nil,
//     replace: Item? = nil,
//     destroy: Item? = nil,
//     clear: Multiple? = nil,
//     aboutItem: Item? = nil,
//     aboutMultiple: Multiple? = nil
//     */
//    func makeResource() -> Resource<TController.Model> {
//        return Resource(
//            index: index
//        )
//    }
//}

