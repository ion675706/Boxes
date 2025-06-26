

import SwiftUI
import RealmSwift
import UIKit

struct EditAllItemScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedRealmObject var item: ItemDomainModel
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .frame(height: 2)
                .foregroundStyle(Color.init(red255: 215, green255: 215, blue255: 215))
            ScrollView {
                VStack(spacing: 24) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.red.opacity(0.2))
                            .frame(height: 140)
                        if let photo = item.photo, let uiImage = UIImage(data: photo) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 140)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        } else {
                            VStack {
                                Text("No photo")
                                    .foregroundStyle(Color.init(red255: 159, green255: 0, blue255: 0))
                                    .font(.custom("DMSans-Bold", size: 20))
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Item title:")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(Color.init(red255: 81, green255: 81, blue255: 81))
                            .font(.custom("DMSans-Regular", size: 20))
                        Text(item.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .lineLimit(1)
                            .font(.custom("DMSans-Regular", size: 18))
                            .foregroundStyle(Color.init(red255: 35, green255: 35, blue255: 35))
                            .background(.white)
                            .cornerRadius(16)
                            .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
                    }
                    .padding(.horizontal, 16)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Container:")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(Color.init(red255: 81, green255: 81, blue255: 81))
                            .font(.custom("DMSans-Regular", size: 20))
                        HStack {
                            Text(item.container?.title ?? "-")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .lineLimit(1)
                                .font(.custom("DMSans-Regular", size: 18))
                                .foregroundStyle(Color.init(red255: 35, green255: 35, blue255: 35))
                                .background(.white)
                                .cornerRadius(16)
                                .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 16)
                    
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Category:")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(Color.init(red255: 81, green255: 81, blue255: 81))
                            .font(.custom("DMSans-Regular", size: 20))
                        HStack {
                            Text(item.category?.title ?? "-")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .lineLimit(1)
                                .font(.custom("DMSans-Regular", size: 18))
                                .foregroundStyle(Color.init(red255: 35, green255: 35, blue255: 35))
                                .background(.white)
                                .cornerRadius(16)
                                .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 16)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Description:")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(Color.init(red255: 81, green255: 81, blue255: 81))
                            .font(.custom("DMSans-Regular", size: 20))
                        HStack {
                            Text(item.descriptionText.isEmpty ? "No description" : item.descriptionText)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .lineLimit(1)
                                .font(.custom("DMSans-Regular", size: 18))
                                .foregroundStyle(Color.init(red255: 35, green255: 35, blue255: 35))
                                .background(.white)
                                .cornerRadius(16)
                                .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 16)
                    Spacer()
                }
                .padding(.top, 8)
            }
        }
        .navigationBarTitle("Item Info", displayMode: .inline)
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

#Preview {
    EditAllItemScreen(item: ItemDomainModel(name: "Test", descriptionText: "", photo: nil))
}
