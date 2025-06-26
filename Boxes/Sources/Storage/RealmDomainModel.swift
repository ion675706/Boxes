

import Foundation
import RealmSwift

final class RealmDomainModel: Object {
    @Persisted(primaryKey: true)  var id: UUID = .init()
    @Persisted var containers: List<ContainerDomainModel>

    convenience init(
        id: UUID = .init(),
        containers: List<ContainerDomainModel>
    ) {
        self.init()
        self.id = id
        self.containers = containers
    }
}
