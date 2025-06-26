
import SwiftUI
import RealmSwift
import UIKit

struct AllItemsAddScreen: View {
    @Environment(\.presentationMode) var presentationMode

    @StateObject private var containersVM = ContainersViewModel()
    @StateObject private var categoriesVM = CategoryViewModel()
    @StateObject private var itemsVM = AllItemsViewModel()

    @State private var itemTitle: String = ""
    @State private var selectedContainer: ContainerDomainModel? = nil
    @State private var selectedCategory: CategoryDomainModel? = nil
    @State private var description: String = ""
    @State private var showContainerPicker = false
    @State private var showCategoryPicker = false
    @State private var image: Image? = nil
    @State private var imageData: Data? = nil
    @State private var showImagePicker = false
    @State private var imagePickerSource: UIImagePickerController.SourceType = .camera
    @FocusState private var isFocused: Bool

    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    // Add Photo
                    Button(action: {
                        imagePickerSource = .camera
                        showImagePicker = true
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.red.opacity(0.2))
                                .frame(height: 140)
                            if let image = image {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 140)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                            } else {
                                HStack {
                                    Text("Add photo")
                                        .foregroundColor(Color.init(red255: 159, green255: 0, blue255: 0))
                                        .font(.custom("DMSans-Medium", size: 20))
                                    Text("+")
                                        .font(.custom("DMSans-Medium", size: 32))
                                        .foregroundColor(Color.init(red255: 159, green255: 0, blue255: 0))
                                }
                            }
                        }
                        .padding(.horizontal, 42)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(sourceType: imagePickerSource) { uiImage in
                            if let data = uiImage.jpegData(compressionQuality: 0.8) {
                                imageData = data
                                image = Image(uiImage: uiImage)
                            }
                        }
                    }

                    // Item Title
                    Text("Item title:")
                        .font(.custom("DMSans-Regular", size: 20))
                        .foregroundStyle(Color.init(red255: 81, green255: 81, blue255: 81))
                    TextField("Item", text: $itemTitle)
                        .padding()
                        .font(.custom("DMSans-Regular", size: 18))
                        .foregroundStyle(Color.init(red255: 35, green255: 35, blue255: 35))
                        .background(.white)
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)

                    // Container
                    Text("Container:")
                        .font(.custom("DMSans-Regular", size: 20))
                        .foregroundStyle(Color.init(red255: 81, green255: 81, blue255: 81))
                    Menu {
                        ForEach(containersVM.containers, id: \.id) { container in
                            Button(container.title) { selectedContainer = container }
                        }
                    } label: {
                        HStack {
                            Text(selectedContainer?.title ?? "Select container")
                                .font(.custom("DMSans-Regular", size: 18))
                                .foregroundStyle(Color.init(red255: 35, green255: 35, blue255: 35))
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundStyle(Color.init(red255: 35, green255: 35, blue255: 35))
                        }
                        .padding()
                        .background(.white)
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
                    }

                    // Category
                    Text("Category:")
                        .font(.custom("DMSans-Regular", size: 20))
                        .foregroundStyle(Color.init(red255: 81, green255: 81, blue255: 81))
                    Menu {
                        ForEach(categoriesVM.categories, id: \.id) { category in
                            Button(category.title) { selectedCategory = category }
                        }
                    } label: {
                        HStack {
                            Text(selectedCategory?.title ?? "Select category")
                                .font(.custom("DMSans-Regular", size: 18))
                                .foregroundStyle(Color.init(red255: 35, green255: 35, blue255: 35))
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundStyle(Color.init(red255: 35, green255: 35, blue255: 35))
                        }
                        .padding()
                        .background(.white)
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
                    }

                    // Description
                    Text("Description:")
                        .font(.custom("DMSans-Regular", size: 20))
                        .foregroundStyle(Color.init(red255: 81, green255: 81, blue255: 81))
                    TextEditor(text: $description)
                        .focused($isFocused)
                        .frame(height: 100)
                        .padding(8)
                        .background(.white)
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)

                    // Create Item Button
                    Button(action: {
                        guard !itemTitle.isEmpty, let category = selectedCategory else { return }
                        itemsVM.addItem(
                            name: itemTitle,
                            descriptionText: description,
                            photo: imageData,
                            container: selectedContainer,
                            category: category
                        )
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Create item")
                            .foregroundColor(.white)
                            .font(.custom("DMSans-Bold", size: 18))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.init(red255: 221, green255: 32, blue255: 32))
                            .cornerRadius(100)
                    }
                    .padding(.top, 8)
                }
                .padding()
            }
            .navigationBarTitle("Add Item", displayMode: .inline)
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
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    AllItemsAddScreen()
}
