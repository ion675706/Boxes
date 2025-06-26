
import SwiftUI

struct CategoryItemView: View {
    var body: some View {
        Text("Electronics")
            .frame(maxWidth: .infinity)
            .font(.custom("DMSans-Bold", size: 27))
            .lineLimit(1)
            .foregroundStyle(Color.init(red255: 221, green255: 33, blue255: 33))
            .padding(.vertical, 47)
            .background(
                Color.init(red255: 214, green255: 235, blue255: 255)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.black.opacity(0.1), lineWidth: 6)
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    CategoryItemView()
        .padding(.horizontal, 24)
}
