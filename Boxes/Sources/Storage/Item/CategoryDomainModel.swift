import Foundation
import RealmSwift

final class CategoryDomainModel: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: UUID = .init()
    @Persisted var title: String = ""
    @Persisted var color: String = ""
    @Persisted(originProperty: "category") var items: LinkingObjects<ItemDomainModel>
    
    convenience init(id: UUID = .init(), title: String, color: String = "") {
        self.init()
        self.id = id
        self.title = title
        self.color = color
    }
} 