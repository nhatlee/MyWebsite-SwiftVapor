import Vapor

final class Router: RouteCollection {
    let view: ViewRenderer
    init(_ view: ViewRenderer) {
        self.view = view
    }
    
    func build(_ builder: RouteBuilder) throws {
        /// GET /
        builder.get { req in
            return try self.view.make("welcome")
        }
        
        /// GET /hello/...
        builder.resource("hello", HelloController(view))
        
        // response to requests to /info domain
        // with a description of the request
        builder.get("info") { req in
            return req.description
        }
        
        builder.get("allusers") { req in
            let listUser = try User.all()
            var message = ""
            for user in listUser {
                message += "user:\n \(user.userName) \n \(user.email)\n"
            }
            return message
        }
        
        builder.post("user", "new") { (request) -> ResponseRepresentable in
            guard let userName = request.data["username"]?.string,
                let password = request.data["password"]?.string,
                let email = request.data["email"]?.string else {
                    throw Abort.badRequest
            }
            let listUser = try User.all()
            
            let user = User(userName: userName, email: email, password: password)
            let list = listUser.filter { $0.email == user.email }
            if list.count > 0 {
                let errorMsg = "The user with email:\(user.email) has exist in database"
                print(errorMsg)
                return errorMsg
            } else {
                try user.save()
            }
            
            return "Success!\n\nUser Info:\nName: \(user.userName)\nPassword: \(user.password)\nEmail: \(user.email)\nID: \(String(describing: user.id?.wrapped))"
        }
    }
}

extension Droplet {
    func setupRoutes() throws {
        get("hello") { req in
            var json = JSON()
            try json.set("hello", "world")
            return json
        }

        get("plaintext") { req in
            return "Hello, world!"
        }

        // response to requests to /info domain
        // with a description of the request
        get("info") { req in
            return req.description
        }

        get("description") { req in return req.description }

        try resource("posts", PostController.self)
    }
}

