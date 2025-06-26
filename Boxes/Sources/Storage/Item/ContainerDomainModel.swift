
import Foundation
import RealmSwift

final class ContainerDomainModel: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: UUID = .init()
    @Persisted var title: String = ""
    @Persisted var room: String = ""
    @Persisted var items: List<ItemDomainModel>
    
    convenience init(
        id: UUID = .init(),
        title: String,
        room: String,
        items: List<ItemDomainModel> = List<ItemDomainModel>()
    ) {
        self.init()
        self.id = id
        self.title = title
        self.room = room
        self.items = items
    }
}
