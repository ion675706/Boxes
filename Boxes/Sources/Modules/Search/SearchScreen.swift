
import SwiftUI
import RealmSwift

struct SearchScreen: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedResults(ItemDomainModel.self) var items
    @ObservedResults(ContainerDomainModel.self) var containers
    @State private var selectedItemName: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                Rectangle()
                    .frame(height: 2)
                    .foregroundStyle(Color.init(red255: 215, green255: 215, blue255: 215))
                
                
                Menu {
                    ForEach(Array(Set(items.map { $0.name })).sorted(), id: \.self) { name in
                        Button(action: { selectedItemName = name }) {
                            Text(name)
                        }
                    }
                } label: {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(Color.init(red255: 35, green255: 35, blue255: 35))
                        Text(selectedItemName.isEmpty ? "Select item" : selectedItemName)
                            .lineLimit(1)
                            .font(.custom("DMSans-Regular", size: 20))
                            .foregroundStyle(Color.init(red255: 35, green255: 35, blue255: 35))
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundStyle(Color.init(red255: 35, green255: 35, blue255: 35))
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
                }
                .padding()
                
                Text("Container")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.custom("DMSans-Regular", size: 22))
                    .foregroundStyle(Color.init(red255: 81, green255: 81, blue255: 81))
                    .padding(.horizontal, 16)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 6) {
                        let filteredContainers = containers.filter { container in
                            container.items.contains(where: { $0.name == selectedItemName })
                        }
                        ForEach(Array(filteredContainers), id: \.id) { container in
                            ContainerItemView(container: container)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 4)
                }
                
                Text("Items:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.custom("DMSans-Regular", size: 22))
                    .foregroundStyle(Color.init(red255: 81, green255: 81, blue255: 81))
                    .padding(.horizontal, 16)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 8) {
                        let filteredItems = items.filter { $0.name == selectedItemName || selectedItemName.isEmpty }
                        ForEach(Array(filteredItems), id: \.id) { item in
                            SearchItemView(item: item)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 4)
                }
            }
            .navigationBarTitle("Search", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    HStack {
                        Image(.arrowBackButton)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        Text("Back")
                            .font(.custom("DMSans-Medium", size: 20))
                            .foregroundStyle(Color.init(red255: 35, green255: 35, blue255: 35))
                    }
                }
            )
        }
    }
}

#Preview {
    SearchScreen()
}

//Text("Search")
//    .font(.custom("DMSans-Medium", size: 24))
//    .foregroundStyle(Color.init(red255: 35, green255: 35, blue255: 35))
//    .padding(.vertical, 12)

