

import SwiftUI
import RealmSwift

struct HistoryScreen: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedResults(ContainerDomainModel.self) var containers
    @ObservedResults(ItemDomainModel.self) var items
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                Rectangle()
                    .frame(height: 2)
                    .foregroundStyle(Color.init(red255: 215, green255: 215, blue255: 215))
                
                Text("Last container")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.custom("DMSans-Regular", size: 22))
                    .foregroundStyle(Color.init(red255: 81, green255: 81, blue255: 81))
                    .padding(.horizontal, 16)
                    .padding(.top, 20)
                    .padding(.bottom, 12)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 6) {
                        ForEach(Array(containers.sorted(by: { $0.id.uuidString > $1.id.uuidString }).prefix(4)), id: \.id) { container in
                            ContainerItemView(container: container)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 4)
                }
                
                Text("Last Items:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.custom("DMSans-Regular", size: 22))
                    .foregroundStyle(Color.init(red255: 81, green255: 81, blue255: 81))
                    .padding(.horizontal, 16)
                    .padding(.top, 20)
                    .padding(.bottom, 12)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 8) {
                        ForEach(Array(items.sorted(by: { $0.creationTime > $1.creationTime }).prefix(4)), id: \.uuid) { item in
                            SearchItemView(item: item)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 4)
                }
            }
            .navigationBarTitle(Text("History"), displayMode: .inline)
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
    HistoryScreen()
}
