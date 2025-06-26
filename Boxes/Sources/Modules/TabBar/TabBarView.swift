

import SwiftUI

struct TabBarView: View {
    @Binding private var path: NavigationPath
    @ObservedObject private var viewModel: TabBarViewModel
//    @ObservedObject var authMain: AuthMain
    
    init(viewModel: TabBarViewModel, path: Binding<NavigationPath>) {
        self.viewModel = viewModel
//        self.authMain = authMain
        self._path = path
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack(spacing: 0) {

            
            TabView(selection: $viewModel.current) {
                MainScreen(navigationPath: $path)
                    .tag(TabBarViewModel.Tab.dashboard.rawValue)
                
                ContainersScreen(navigationPath: $path)
                    .tag(TabBarViewModel.Tab.containers.rawValue)
                
                CategoryScreen(navigationPath: $path)
                    .tag(TabBarViewModel.Tab.categories.rawValue)
                
                AllItemsScreen(navigationPath: $path)
                    .tag(TabBarViewModel.Tab.allItems.rawValue)
            }
            
            Rectangle()
                .frame(height: 2)
                .foregroundStyle(Color.init(red255: 215, green255: 215, blue255: 215))
            HStack(spacing: 4) {
                ForEach(TabBarViewModel.Tab.allCases, id: \.self) { tab in
                    TabBarButton(
                        title: tab.title,
                        image: tab.image,
                        tag: tab.rawValue,
                        selected: $viewModel.current
                    )
                    
                    if tab != TabBarViewModel.Tab.allCases.last {
                        Spacer()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 64)
            .padding(.horizontal, 10)
            .cornerRadius(20)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    TabBarView(viewModel: .init(), path: .constant(.init()))
}
