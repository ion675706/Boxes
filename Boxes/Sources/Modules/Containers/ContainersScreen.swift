

import SwiftUI
import RealmSwift

struct ContainersScreen: View {
    @Binding var navigationPath: NavigationPath
    @ObservedResults(ContainerDomainModel.self) var containers

    init(navigationPath: Binding<NavigationPath> = .constant(NavigationPath())) {
        self._navigationPath = navigationPath
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                Text("Containers")
                    .font(.custom("DMSans-Bold", size: 38))
                
                Spacer()
                
                Button {
                    navigationPath.append(NavigationRoute.createContainer)
                } label: {
                    Text("Add new")
                        .font(.custom("DMSans-Medium", size: 20))
                        .foregroundStyle(Color.init(red255: 221, green255: 33, blue255: 33))
                }
            }
            .padding(.horizontal, 16)

            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    ForEach(Array(containers), id: \.id) { container in
                        Button(action: {
                            navigationPath.append(NavigationRoute.containerDetails(container))
                        }) {
                            ContainerItemView(container: container)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .contextMenu {
                            Button(role: .destructive) {
                                deleteContainer(container)
                            } label: {
                                Label("Delete", systemImage: "trash")
                                    .font(.custom("DMSans-Bold", size: 16))
                                    .foregroundStyle(Color.init(red255: 221, green255: 32, blue255: 32))
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 24)
            }
        }
    }

    private func deleteContainer(_ container: ContainerDomainModel) {
        guard let realm = try? Realm(), let object = realm.object(ofType: ContainerDomainModel.self, forPrimaryKey: container.id) else { return }
        try? realm.write {
            realm.delete(object)
        }
    }
}

#Preview {
    ContainersScreen()
}
