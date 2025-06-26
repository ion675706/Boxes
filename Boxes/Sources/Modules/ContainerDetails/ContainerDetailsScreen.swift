
import SwiftUI

struct ContainerDetailsScreen: View {
    @Environment(\.presentationMode) var presentationMode
    let container: ContainerDomainModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Rectangle()
                    .frame(height: 2)
                    .foregroundStyle(Color.init(red255: 215, green255: 215, blue255: 215))
                Text("Container title:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.custom("DMSans-Regular", size: 22))
                    .foregroundStyle(Color.init(red255: 81, green255: 81, blue255: 81))
                    .padding(.horizontal, 16)
                    .padding(.top, 20)
                    .padding(.bottom, 12)
                Text(container.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.custom("DMSans-Regular", size: 22))
                    .foregroundStyle(Color.init(red255: 35, green255: 35, blue255: 35))
                    .padding(16)
                    .background(.white)
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
                    .padding(.horizontal, 16)
                Text("Container location:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.custom("DMSans-Regular", size: 22))
                    .foregroundStyle(Color.init(red255: 81, green255: 81, blue255: 81))
                    .padding(.horizontal, 16)
                    .padding(.top, 24)
                    .padding(.bottom, 12)
                Text(container.room)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.custom("DMSans-Regular", size: 22))
                    .foregroundStyle(Color.init(red255: 35, green255: 35, blue255: 35))
                    .padding(16)
                    .background(.white)
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
                    .padding(.horizontal, 16)
                Text("Items in this container:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.custom("DMSans-Regular", size: 22))
                    .foregroundStyle(Color.init(red255: 81, green255: 81, blue255: 81))
                    .padding(.horizontal, 16)
                    .padding(.top, 24)
                    .padding(.bottom, 12)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 8) {
                        ForEach(Array(container.items), id: \.uuid) { item in
                            SearchItemView(item: item)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 4)
                }
                Spacer()
            }
//            .padding(.top, 16)
            .navigationBarTitle("Container Details", displayMode: .inline)
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
    ContainerDetailsScreen(container: .init())
}
