
import SwiftUI

struct ContentView: View {
    @StateObject private var tabBarViewModel = TabBarViewModel()
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            TabBarView(viewModel: tabBarViewModel, path: $navigationPath)
                .navigationDestination(for: NavigationRoute.self) { route in
                    switch route {
                    case .search:
                        SearchScreen()
                            .navigationBarBackButtonHidden(true)
                    case .history:
                        HistoryScreen()
                            .navigationBarBackButtonHidden(true)
                    case .createContainer:
                        CreateContainerScreen()
                            .navigationBarBackButtonHidden(true)
                    case .createCategory:
                        CreateCategoryScreen()
                            .navigationBarBackButtonHidden(true)
                    case .allItemsAdd:
                        AllItemsAddScreen()
                            .navigationBarBackButtonHidden(true)
                    case .mainAllItems:
                        MainAllItemsScreen()
                            .navigationBarBackButtonHidden(true)
                    case .allItemsFilter:
                        AllItemsFilterScreen()
                            .navigationBarBackButtonHidden(true)
                    case .allItemsSort:
                        AllItemsSortScreen()
                            .navigationBarBackButtonHidden(true)
                    case .editAllItem(let item):
                        EditAllItemScreen(item: item)
                            .navigationBarBackButtonHidden(true)
                    case .categoryDetails(let category):
                        CategoryDetailsScreen(category: category)
                            .navigationBarBackButtonHidden(true)
                    case .containerDetails(let container):
                        ContainerDetailsScreen(container: container)
                            .navigationBarBackButtonHidden(true)
                    case .createContainerRoom:
                        CreateContainerRoomScreen(containerTitle: "")
                            .navigationBarBackButtonHidden(true)
                    }
                }
        }
    }
}

// MARK: - Navigation Routes
enum NavigationRoute: Hashable {
    case search
    case history
    case createContainer
    case createCategory
    case allItemsAdd
    case mainAllItems
    case allItemsFilter
    case allItemsSort
    case editAllItem(ItemDomainModel)
    case categoryDetails(CategoryDomainModel)
    case containerDetails(ContainerDomainModel)
    case createContainerRoom
}

#Preview {
    ContentView()
} 
