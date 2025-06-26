import Foundation
import RealmSwift
import Combine

final class ContainersViewModel: ObservableObject {
    @ObservedResults(ContainerDomainModel.self) var containers
    
    func addContainer(title: String, room: String, items: [ItemDomainModel] = []) {
        let list = List<ItemDomainModel>()
        list.append(objectsIn: items)
        let container = ContainerDomainModel(title: title, room: room, items: list)
        $containers.append(container)
    }
    
    
    func deleteContainer(_ container: ContainerDomainModel) {
        guard let realm = container.realm else { return }
        try? realm.write {
            realm.delete(container)
        }
    }
}
