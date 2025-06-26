

import Foundation
import RealmSwift

final class ItemDomainModel: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: UUID = .init()
    @Persisted var name: String = ""
    @Persisted var descriptionText: String = ""
    @Persisted var photo: Data?
    @Persisted var creationTime: Date = Date()
    @Persisted var room: String = ""
    @Persisted var container: ContainerDomainModel?
    @Persisted var category: CategoryDomainModel?
    
    convenience init(
        id: UUID = .init(),
        name: String,
        descriptionText: String,
        photo: Data? = nil,
        creationTime: Date = Date(),
        room: String = "",
        container: ContainerDomainModel? = nil,
        category: CategoryDomainModel? = nil
    ) {
        self.init()
        self.id = id
        self.name = name
        self.descriptionText = descriptionText
        self.photo = photo
        self.creationTime = creationTime
        self.room = room
        self.container = container
        self.category = category
    }

    var uuid: UUID { id }
}
