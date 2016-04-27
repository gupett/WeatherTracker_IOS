class Main {
    var name:String
    init(name:String) {
        self.name = name
    }
    var Ac = AnyClass.self
    init(ac:AnyClass) {
        Ac = ac
    }
}
var mainInstance = Main(name:"My Global Class")