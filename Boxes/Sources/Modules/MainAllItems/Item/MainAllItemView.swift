
import SwiftUI
import RealmSwift

struct MainAllItemView: View {
    let item: ItemDomainModel
    @Binding var navigationPath: NavigationPath
    @ObservedObject var viewModel: AllItemsViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            if let category = item.category {
                Text(category.title)
                    .font(.custom("DMSans-Regular", size: 21))
                    .foregroundStyle(Color.init(red255: 159, green255: 0, blue255: 0))
                    .padding(.vertical, 4)
                    .padding(.horizontal, 12)
                    .background(Color.init(red255: 255, green255: 193, blue255: 193))
                    .cornerRadius(100)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(8)
            }
            if let photo = item.photo, let uiImage = UIImage(data: photo) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            } else {
                Image(.apple)
                    .resizable()
                    .scaledToFit()
            }
            
            Spacer(minLength: 0)
            Text(item.name)
                .font(.custom("DMSans-Medium", size: 27))
                .lineLimit(1)
                .foregroundStyle(Color.init(red255: 35, green255: 35, blue255: 35))
                .padding(.top, 12)
            Text(item.descriptionText)
                .font(.custom("DMSans-Medium", size: 24))
                .lineLimit(1)
                .foregroundStyle(Color.init(red255: 161, green255: 161, blue255: 161))
                .padding(.top, 4)
            HStack {
                Text("Into: ")
                    .font(.custom("DMSans-Medium", size: 24))
                    .lineLimit(1)
                    .foregroundStyle(Color.init(red255: 161, green255: 161, blue255: 161))
                if let container = item.container {
                    Text(container.title)
                        .font(.custom("DMSans-Medium", size: 24))
                        .lineLimit(1)
                        .foregroundStyle(Color.init(red255: 35, green255: 35, blue255: 35))
                } else {
                    Text("-")
                        .font(.custom("DMSans-Medium", size: 24))
                        .lineLimit(1)
                        .foregroundStyle(Color.init(red255: 35, green255: 35, blue255: 35))
                }
            }
            .padding(.top, 4)
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
        .onTapGesture {
            navigationPath.append(NavigationRoute.editAllItem(item))
        }
        .contextMenu {
            Button(role: .destructive) {
                viewModel.deleteItem(item)
            } label: {
                Label("Delete", systemImage: "trash")
                    .font(.custom("DMSans-Bold", size: 16))
                    .foregroundStyle(Color.init(red255: 221, green255: 32, blue255: 32))
            }
        }
    }
}

#Preview {
    MainAllItemView(item: ItemDomainModel(name: "Tomato", descriptionText: "Description", category: CategoryDomainModel(title: "Fruit")), navigationPath: .constant(NavigationPath()), viewModel: AllItemsViewModel())
        .padding()
}
