
import SwiftUI
import RealmSwift

struct CategoryDetailsScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel: CategoryDetailsViewModel
    
    init(category: CategoryDomainModel) {
        _viewModel = StateObject(wrappedValue: CategoryDetailsViewModel(category: category))
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                Rectangle()
                    .frame(height: 2)
                    .foregroundStyle(Color.init(red255: 215, green255: 215, blue255: 215))
                
                Text(viewModel.category.title)
                    .frame(maxWidth: .infinity)
                    .font(.custom("DMSans-Bold", size: 27))
                    .lineLimit(1)
                    .foregroundStyle(Color.init(red255: 221, green255: 33, blue255: 33))
                    .padding(.vertical, 47)
                    .background(
                        Color(hex: viewModel.category.color) ?? Color.init(red255: 214, green255: 235, blue255: 255)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.black.opacity(0.1), lineWidth: 6)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.top, 20)
                    .padding(.horizontal, 16)
                
                Text("Items in this category:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.custom("DMSans-Regular", size: 22))
                    .foregroundStyle(Color.init(red255: 81, green255: 81, blue255: 81))
                    .padding(.horizontal, 16)
                    .padding(.top, 24)
                    .padding(.bottom, 12)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 8) {
                        ForEach(viewModel.items, id: \.id) { item in
                            SearchItemView(item: item)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                }

                Spacer()
                
            }
//            .padding(.top, 16)
            .navigationBarTitle(viewModel.category.title, displayMode: .inline)
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
    CategoryDetailsScreen(category: CategoryDomainModel(title: "Kitchen"))
}
