
import SwiftUI

struct ContainerCompleteScreen: View {
    @Environment(\.dismiss) private var dismiss
    @State private var didAppear = false
    var body: some View {
        Image(.completeScreen)
            .resizable()
            .ignoresSafeArea()
            .onAppear {
                guard !didAppear else { return }
                didAppear = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    dismiss()
                }
            }
            .navigationBarBackButtonHidden(true)
    }
}


