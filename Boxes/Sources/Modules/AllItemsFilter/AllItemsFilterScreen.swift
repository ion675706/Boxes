

import SwiftUI
import RealmSwift

struct AllItemsFilterScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var containersVM = ContainersViewModel()
    @StateObject private var categoriesVM = CategoryViewModel()
    @State private var selectedContainer: ContainerDomainModel? = nil
    @State private var selectedCategory: CategoryDomainModel? = nil
    @State private var selectedRoom: String = ""
    var onApply: ((ContainerDomainModel?, CategoryDomainModel?, String) -> Void)? = nil
    
    var rooms: [String] {
        let allRooms = Array(containersVM.containers).map { $0.room } + Array(categoriesVM.categories).flatMap { _ in [String]() }
        return Array(Set(allRooms)).filter { !$0.isEmpty }
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 24) {
                Group {
                    Text("Container:")
                        .font(.custom("DMSans-Regular", size: 20))
                        .foregroundStyle(Color.init(red255: 81, green255: 81, blue255: 81))
                    Menu {
                        Button("Any") { selectedContainer = nil }
                        ForEach(containersVM.containers, id: \.id) { container in
                            Button(container.title) { selectedContainer = container }
                        }
                    } label: {
                        HStack {
                            Text(selectedContainer?.title ?? "Any")
                                .font(.custom("DMSans-Regular", size: 18))
                                .foregroundStyle(Color.init(red255: 35, green255: 35, blue255: 35))
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundStyle(Color.init(red255: 35, green255: 35, blue255: 35))
                        }
                        .padding()
                        .background(.white)
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
                    }
                }
                Group {
                    Text("Category:")
                        .font(.custom("DMSans-Regular", size: 20))
                        .foregroundStyle(Color.init(red255: 81, green255: 81, blue255: 81))
                    Menu {
                        Button("Any") { selectedCategory = nil }
                        ForEach(categoriesVM.categories, id: \.id) { category in
                            Button(category.title) { selectedCategory = category }
                        }
                    } label: {
                        HStack {
                            Text(selectedCategory?.title ?? "Any")
                                .font(.custom("DMSans-Regular", size: 18))
                                .foregroundStyle(Color.init(red255: 35, green255: 35, blue255: 35))
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundStyle(Color.init(red255: 35, green255: 35, blue255: 35))
                        }
                        .padding()
                        .background(.white)
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
                    }
                }
                Group {
                    Text("Room")
                        .font(.custom("DMSans-Regular", size: 20))
                        .foregroundStyle(Color.init(red255: 81, green255: 81, blue255: 81))
                    Menu {
                        Button("Any") { selectedRoom = "" }
                        ForEach(rooms, id: \.self) { room in
                            Button(room) { selectedRoom = room }
                        }
                    } label: {
                        HStack {
                            Text(selectedRoom.isEmpty ? "Any" : selectedRoom)
                                .font(.custom("DMSans-Regular", size: 18))
                                .foregroundStyle(Color.init(red255: 35, green255: 35, blue255: 35))
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundStyle(Color.init(red255: 35, green255: 35, blue255: 35))
                        }
                        .padding()
                        .background(.white)
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
                    }
                }
                Spacer()
            }
            .padding()
            .navigationBarTitle("Filter", displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: {
                    onApply?(selectedContainer, selectedCategory, selectedRoom)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                        .font(.custom("DMSans-Medium", size: 20))
                        .foregroundColor(Color.init(red255: 221, green255: 33, blue255: 33))
                }
            )
        }
    }
}

#Preview {
    AllItemsFilterScreen()
}

