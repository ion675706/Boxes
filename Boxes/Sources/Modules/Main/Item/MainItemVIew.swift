

import SwiftUI

struct MainItemVIew: View {
    let title: String
    let count: Int
    var body: some View {
        HStack(spacing: 0) {
            Text(title)
                .font(.custom("DMSans-Regular", size: 20))
                .foregroundStyle(Color.init(red255: 63, green255: 63, blue255: 63))
            Spacer()
            Text("\(count)")
                .font(.custom("DMSans-Bold", size: 28))
                .foregroundStyle(Color.init(red255: 159, green255: 0, blue255: 0))
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
        .background(.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
    }
}

#Preview {
    MainItemVIew(title: "Items total:", count: 190)
}
