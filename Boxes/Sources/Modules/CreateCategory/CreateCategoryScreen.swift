
import SwiftUI

struct CreateCategoryScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var categoryTitle: String = ""
    @State private var selectedColor: Color = .red
    @StateObject private var viewModel = CategoryViewModel()
    
    let colors: [Color] = [
        Color.init(red255: 250, green255: 42, blue255: 42),
        Color.init(red255: 250, green255: 139, blue255: 42),
        Color.init(red255: 250, green255: 202, blue255: 42),
        Color.init(red255: 174, green255: 250, blue255: 42),
        Color.init(red255: 70, green255: 234, blue255: 41),
        Color.init(red255: 52, green255: 208, blue255: 240),
        Color.init(red255: 42, green255: 77, blue255: 250),
        Color.init(red255: 150, green255: 42, blue255: 250),
        Color.init(red255: 250, green255: 42, blue255: 181),
        Color.init(red255: 250, green255: 42, blue255: 94),
        Color.init(red255: 176, green255: 176, blue255: 176)
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 32) {
                VStack(alignment: .center, spacing: 12) {
                    Text("Name your category")
                        .font(.custom("DMSans-Medium", size: 18))
                        .foregroundColor(Color.init(red255: 35, green255: 35, blue255: 35))
                        .foregroundColor(.black)
                    TextField("Type a title...", text: $categoryTitle)
                        .font(.custom("DMSans-Bold", size: 42))
                        .foregroundColor(Color.init(red255: 170, green255: 170, blue255: 170))
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 16)
                        .cornerRadius(20)
                        .padding(.horizontal, 8)
                }
                .padding(.vertical, 32)
                .background(Color.init(red255: 255, green255: 214, blue255: 214))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.black.opacity(0.1), lineWidth: 6)
                )
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.top, 24)
                .padding(.horizontal, 16)
                
                VStack(spacing: 16) {
                    Text("Pick a colour")
                        .font(.custom("DMSans-Medium", size: 18))
                        .foregroundColor(Color.init(red255: 35, green255: 35, blue255: 35))
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 6), spacing: 16) {
                        ForEach(colors, id: \.self) { color in
                            ZStack {
                                Circle()
                                    .fill(color)
                                    .frame(width: 44, height: 44)
                                    .shadow(color: .black.opacity(selectedColor == color ? 0.2 : 0), radius: 4, x: 0, y: 2)
                                if selectedColor == color {
                                    Circle()
                                        .stroke(Color.white, lineWidth: 4)
                                        .frame(width: 50, height: 50)
                                        .shadow(color: .black, radius: 1, x: 0, y: 0)
                                }
                            }
                            .onTapGesture {
                                selectedColor = color
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
                Spacer()
            }
            .navigationBarTitle("Create category", displayMode: .inline)
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
                },
                trailing:
                Button {
                    let colorHex = selectedColor.toHex() ?? ""
                    viewModel.addCategory(title: categoryTitle, color: colorHex)
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Save")
                        .font(.custom("DMSans-Medium", size: 20))
                        .foregroundStyle(Color.init(red255: 221, green255: 33, blue255: 33))
                }
            )
        }
    }
}

#Preview {
    CreateCategoryScreen()
}
