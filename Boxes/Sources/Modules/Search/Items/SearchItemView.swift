
import SwiftUI
import RealmSwift

struct SearchItemView: View {
    let item: ItemDomainModel
    var body: some View {
        HStack(spacing: 0) {
            if let photo = item.photo, let uiImage = UIImage(data: photo) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44, height: 44)
                    .padding(.trailing, 12)
            } else {
                Image(.apple)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44, height: 44)
                    .padding(.trailing, 12)
            }
            Text(item.name)
                .font(.custom("DMSans-Bold", size: 24))
                .foregroundStyle(Color.init(red255: 35, green255: 35, blue255: 35))
            Spacer()
            if let category = item.category {
                Text(category.title)
                    .font(.custom("DMSans-Regular", size: 21))
                    .foregroundStyle(Color.init(red255: 159, green255: 0, blue255: 0))
                    .padding(.vertical, 4)
                    .padding(.horizontal, 12)
                    .background(Color.init(red255: 255, green255: 193, blue255: 193))
                    .cornerRadius(100)
            }
        }
        .padding(8)
        .background(.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
    }
}

#Preview {
    SearchItemView(item: ItemDomainModel(name: "Tomato", descriptionText: "", category: CategoryDomainModel(title: "Vegetables")))
}
