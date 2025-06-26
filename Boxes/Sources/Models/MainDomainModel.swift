
import Foundation
import RealmSwift

struct MainDomainModel {
    var id: UUID
    var containers: List<ContainerDomainModel>
    
    init(id: UUID = .init(), containers: List<ContainerDomainModel>) {
        self.id = id
        self.containers = containers
    }
}
