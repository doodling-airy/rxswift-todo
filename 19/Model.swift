
import RealmSwift

class TODO: Object {
    @objc dynamic var id = NSUUID().uuidString
    @objc dynamic var text: String?
}

class Model {
    private let realm = try! Realm()
    
    func allasarray() -> [TODO] {
        let todoResults = realm.objects(TODO.self)
        var arr: [TODO] = []
        for i in todoResults {
            arr.append(i)
        }
        return arr
    }
    func save(_ text: String) {
        let newtodo = TODO()
        newtodo.text = text
        try! realm.write {
            realm.add(newtodo)
        }
    }
    func remove(_ todo: TODO) -> [TODO] {
        try! realm.write {
            realm.delete(todo)
        }
        return allasarray()
    }
}
