

import SwiftUI
import RealmSwift

struct MainScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var navigationPath: NavigationPath
    
    @ObservedResults(ItemDomainModel.self) var items
    @ObservedResults(ContainerDomainModel.self) var containers
    @ObservedResults(CategoryDomainModel.self) var categories
    
    init(navigationPath: Binding<NavigationPath> = .constant(NavigationPath())) {
        self._navigationPath = navigationPath
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                Text("Dashboard")
                    .font(.custom("DMSans-Bold", size: 38))
                
                Spacer()
                
                Button {
                    navigationPath.append(NavigationRoute.history)
                } label: {
                    Image(.mainHistoryButton)
                        .resizable()
                        .scaledToFit()
                        
                }
                .frame(width: 40, height: 40)
                
                Button {
                    navigationPath.append(NavigationRoute.mainAllItems)
                } label: {
                    Image(.mainAllItemsButton)
                        .resizable()
                        .scaledToFit()
                }
                .frame(width: 40, height: 40)
            
            }
            
            Button {
                navigationPath.append(NavigationRoute.search)
            } label: {
                Image(.mainSearchButton)
                    .resizable()
                    .scaledToFit()
            }
            .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
            .padding(.top, 16)
            .padding(.bottom, 24)

            HStack(spacing: 12) {
                Button {
                    navigationPath.append(NavigationRoute.allItemsAdd)
                } label: {
                    Image(.mainAddItemButton)
                        .resizable()
                        .scaledToFit()
                }
                
                Button {
                    navigationPath.append(NavigationRoute.createContainer)
                } label: {
                    Image(.mainAddContainerButton)
                        .resizable()
                        .scaledToFit()
                }
                

            }
            
            Text("Report")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 24)
                .font(.custom("DMSans-Bold", size: 32))
            
            ScrollView(showsIndicators: false) {
                MainItemVIew(title: "Items total:", count: items.count)
                    .padding(.horizontal, 4)
                    .padding(.top, 4)
                MainItemVIew(title: "Containers total:", count: containers.count)
                    .padding(.horizontal, 4)
                MainItemVIew(title: "Categories total:", count: categories.count)
                    .padding(.horizontal, 4)
            }
            .padding(.top, 20)
            
        }
//        .padding(.top, 16)
        .padding(.horizontal, 16)
    }
}

#Preview {
    MainScreen()
}
