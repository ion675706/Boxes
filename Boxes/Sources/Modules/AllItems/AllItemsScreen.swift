
import SwiftUI
import RealmSwift

struct AllItemsScreen: View {
    @ObservedResults(ItemDomainModel.self) var items
    @StateObject private var viewModel = AllItemsViewModel()
    @State private var searchText = ""
    @State private var filterContainer: ContainerDomainModel? = nil
    @State private var filterCategory: CategoryDomainModel? = nil
    @State private var filterRoom: String = ""
    @State private var showFilterSheet = false
    @State private var showSortSheet = false
    @State private var sortBy: AllItemsSortScreen.SortBy = .category
    @State private var sortTime: AllItemsSortScreen.CreationTime = .latest
    @Binding var navigationPath: NavigationPath
    
    init(navigationPath: Binding<NavigationPath> = .constant(NavigationPath())) {
        self._navigationPath = navigationPath
    }
    
    var filteredItems: [ItemDomainModel] {
        let filtered = items.filter { item in
            let matchesSearch = searchText.isEmpty || item.name.localizedCaseInsensitiveContains(searchText)
            let matchesContainer = filterContainer == nil || item.container == filterContainer
            let matchesCategory = filterCategory == nil || item.category == filterCategory
            let matchesRoom = filterRoom.isEmpty || item.room == filterRoom
            return matchesSearch && matchesContainer && matchesCategory && matchesRoom
        }
        return sortItems(Array(filtered))
    }
    
    func sortItems(_ items: [ItemDomainModel]) -> [ItemDomainModel] {
        var sorted = items
        switch sortBy {
        case .category:
            sorted = sorted.sorted { ($0.category?.title ?? "") < ($1.category?.title ?? "") }
        case .name:
            sorted = sorted.sorted { $0.name < $1.name }
        case .container:
            sorted = sorted.sorted { ($0.container?.title ?? "") < ($1.container?.title ?? "") }
        case .room:
            sorted = sorted.sorted { $0.room < $1.room }
        }
        if sortTime == .latest {
            sorted = sorted.sorted { $0.creationTime > $1.creationTime }
        } else {
            sorted = sorted.sorted { $0.creationTime < $1.creationTime }
        }
        return sorted
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                HStack(spacing: 12) {
                    Text("All items")
                        .font(.custom("DMSans-Bold", size: 38))
                    
                    Spacer()
                    
                    Button {
                        showFilterSheet = true
                    } label: {
                        Image(.allItemsFilterButton)
                            .resizable()
                            .scaledToFit()
                            
                    }
                    .frame(width: 40, height: 40)
                    
                    Button {
                        showSortSheet = true
                    } label: {
                        Image(.allItemsSortButton)
                            .resizable()
                            .scaledToFit()
                    }
                    .frame(width: 40, height: 40)
                }
                .padding(.horizontal, 16)

                HStack {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(Color.init(red255: 85, green255: 85, blue255: 85))
                        .padding(.vertical, 16)
                        .padding(.leading, 16)
                    
                    TextField("", text: $searchText, prompt:
                        Text("Search")
                            .font(.custom("DMSans-Regular", size: 20))
                            .foregroundColor(Color.init(red255: 85, green255: 85, blue255: 85))
                    )
                    .font(.custom("DMSans-Regular", size: 20))
                    .foregroundColor(Color.init(red255: 85, green255: 85, blue255: 85))
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .padding(.horizontal, 8)
                }
                .background(.white)
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
                .padding(.horizontal, 16)
                .padding(.top, 16)
                
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(filteredItems, id: \.id) { item in
                            MainAllItemView(item: item, navigationPath: $navigationPath, viewModel: viewModel)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        }
                    }
                    .padding(.top, 28)
                    .padding(.horizontal, 16)
                }
            }
            
            Button {
                navigationPath.append(NavigationRoute.allItemsAdd)
            } label: {
                Image(.allItemsAddButton)
                    .resizable()
                    .scaledToFit()
            }
            .frame(width: 60, height: 60)
            .padding(.bottom, 16)
        }
//        .padding(.top, 16)
        .sheet(isPresented: $showFilterSheet) {
            AllItemsFilterScreen(
                onApply: { container, category, room in
                    filterContainer = container
                    filterCategory = category
                    filterRoom = room
                }
            )
        }
        .sheet(isPresented: $showSortSheet) {
            AllItemsSortScreen(
                onApply: { sort, time in
                    sortBy = sort
                    sortTime = time
                }
            )
        }
    }
}

#Preview {
    AllItemsScreen()
}
