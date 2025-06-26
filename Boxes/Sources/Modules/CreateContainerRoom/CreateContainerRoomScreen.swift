
import SwiftUI

struct CreateContainerRoomScreen: View {
    let containerTitle: String
    @State private var title = ""
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = ContainersViewModel()
    @State private var navigateToComplete = false
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .frame(height: 2)
                .foregroundStyle(Color.init(red255: 215, green255: 215, blue255: 215))
            
            Text("Where is that container?")
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.custom("DMSans-Bold", size: 20))
                .foregroundStyle(Color.init(red255: 81, green255: 81, blue255: 81))
                .padding(.horizontal, 16)
                .padding(.top, 64)
                .padding(.bottom, 12)
            
            TextField("", text: $title, prompt:
                Text("Type a room...")
                    .font(.custom("DMSans-Bold", size: 42))
                    .foregroundColor(Color.init(red255: 170, green255: 170, blue255: 170))
            )
            .font(.custom("DMSans-Bold", size: 42))
            .multilineTextAlignment(.center)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .foregroundColor(Color.init(red255: 170, green255: 170, blue255: 170))

            Spacer()
            
        }
//        .padding(.top, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image(.createContainerBackground)
                .resizable()
                .ignoresSafeArea()
        )
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("Create container", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
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
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.addContainer(title: containerTitle, room: title)
                    navigateToComplete = true
                } label: {
                    Text("Save")
                        .font(.custom("DMSans-Medium", size: 20))
                        .foregroundStyle(Color.init(red255: 221, green255: 33, blue255: 33))
                }
            }
        }
        .background(
            NavigationLink(
                destination: ContainerCompleteScreen(),
                isActive: $navigateToComplete,
                label: { EmptyView() }
            )
        )
    }
}

#Preview {
    CreateContainerRoomScreen(containerTitle: "Example Container")
}
