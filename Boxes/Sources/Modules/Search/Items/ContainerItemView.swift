

import SwiftUI
import RealmSwift

struct ContainerItemView: View {
    let container: ContainerDomainModel
    var body: some View {
        VStack(spacing: 2) {
            Text(container.room.isEmpty ? "No room" : container.room)
                .font(.custom("DMSans-Medium", size: 18))
                .lineLimit(1)
                .foregroundStyle(Color.init(red255: 171, green255: 85, blue255: 85))
            
            Text(container.title)
                .font(.custom("DMSans-Medium", size: 27))
                .lineLimit(1)
                .foregroundStyle(Color.init(red255: 35, green255: 35, blue255: 35))
            Spacer()
        }
        .padding(12)
        .frame(height: 126)
        .frame(
            minWidth: 174,
            maxWidth: .infinity
        )
        
        .background(
            Image(.mainRedBox)
                .resizable()
                
                .aspectRatio(contentMode: .fit)
                .frame(height: 126),
//                .frame(maxWidth: .infinity)
                
//                .scaledToFit()
            alignment: .bottom
        )
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
    }
}

#Preview {
    ContainerItemView(container: ContainerDomainModel(title: "Tomato", room: "Kitchen"))
}
