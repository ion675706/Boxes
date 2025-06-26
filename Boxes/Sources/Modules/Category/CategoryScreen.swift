
import SwiftUI
import RealmSwift

struct CategoryScreen: View {
    @Binding var navigationPath: NavigationPath
    
    init(navigationPath: Binding<NavigationPath> = .constant(NavigationPath())) {
        self._navigationPath = navigationPath
    }
    
    @StateObject private var categoriesVM = CategoryViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                Text("Category")
                    .font(.custom("DMSans-Bold", size: 38))
                
                Spacer()
                
                Button {
                    navigationPath.append(NavigationRoute.createCategory)
                } label: {
                    Text("Add new")
                        .font(.custom("DMSans-Medium", size: 20))
                        .foregroundStyle(Color.init(red255: 221, green255: 33, blue255: 33))
                }
            
            }


            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    ForEach(categoriesVM.categories, id: \.id) { category in
                        Button(action: {
                            navigationPath.append(NavigationRoute.categoryDetails(category))
                        }) {
                            Text(category.title)
                                .frame(maxWidth: .infinity)
                                .font(.custom("DMSans-Bold", size: 27))
                                .lineLimit(1)
                                .foregroundStyle(Color.init(hex: category.color)?.darken(by: 0.5) ?? Color.init(red255: 221, green255: 33, blue255: 33))
                                .padding(.vertical, 42)
                                .background(
                                    Color.init(hex: category.color)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(.black.opacity(0.1), lineWidth: 6)
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                        .buttonStyle(PlainButtonStyle())
                        .contextMenu {
                            Button(role: .destructive) {
                                deleteCategory(category)
                            } label: {
                                Label("Delete", systemImage: "trash")
                                    .font(.custom("DMSans-Bold", size: 16))
                                    .foregroundStyle(Color.init(red255: 221, green255: 32, blue255: 32))
                            }
                        }
                        .padding(.bottom, 8)
                    }
                }
                .padding(.vertical, 24)
            }
        }
        .padding(.horizontal, 16)
    }
    
    private func deleteCategory(_ category: CategoryDomainModel) {
        guard let realm = try? Realm(), let object = realm.object(ofType: CategoryDomainModel.self, forPrimaryKey: category.id) else { return }
        try? realm.write {
            realm.delete(object)
        }
    }
}

#Preview {
    CategoryScreen()
}
