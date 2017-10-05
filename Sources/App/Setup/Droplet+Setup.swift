@_exported import Vapor

extension Droplet {
//    public func setup() throws {
//        try setupRoutes()
//        // Do any additional droplet setup
//    }
    public func setup() throws {
        let routes = Router(view)
        try collection(routes)
    }
}
