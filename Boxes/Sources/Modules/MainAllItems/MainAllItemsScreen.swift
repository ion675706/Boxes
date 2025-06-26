

import SwiftUI
import RealmSwift

struct MainAllItemsScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedResults(ItemDomainModel.self) var items
    @StateObject private var viewModel = AllItemsViewModel()
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                Rectangle()
                    .frame(height: 2)
                    .foregroundStyle(Color.init(red255: 215, green255: 215, blue255: 215))
                
                ScrollView(showsIndicators: false) {
                    let itemsArray: [ItemDomainModel] = Array(items)
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(itemsArray, id: \.id) { item in
                            MainAllItemView(item: item, navigationPath: $navigationPath, viewModel: viewModel)
                        }
                    }
                    .padding(.top, 24)
                    .padding(.horizontal, 16)
                }
            }
            .navigationBarTitle("All Items", displayMode: .inline)
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
            .background(
                NavigationLink(
                    destination: EmptyView(),
                    isActive: .constant(false),
                    label: { EmptyView() }
                )
            )
        }
    }
}

#Preview {
    MainAllItemsScreen()
}
