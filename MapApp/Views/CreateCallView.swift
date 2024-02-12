//
//  CreateCallView.swift
//  MapApp
//
//  Created by yusuf ergül on 24.01.2024.
//

import SwiftUI
import PhotosUI
struct CreateCallView: View {
    @StateObject var model = CallViewModel()
    @State var photosPickerItem : PhotosPickerItem?
    @Binding var showCallView : Bool
    @State var avatarImage : UIImage?
    var body: some View {
        
        ZStack{Color.brown
            .ignoresSafeArea()
            VStack{
                PhotosPicker(selection: $photosPickerItem) {
                    Image(uiImage: avatarImage ?? UIImage(imageLiteralResourceName: "resim"))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        }
                .padding()
                Button {
                    model.savePhoto(image: avatarImage)
                    showCallView = !showCallView
                } label: {
                    Text("Yardım Çağrısı")
                        .font(.headline)
                        .frame(width: 70, height: 70)
                        
                }.buttonStyle(.borderedProminent)
                    .tint(.black)
            }
        }
        
        .onChange(of: photosPickerItem){
            Task{
                if let photosPickerItem,
                   let data = try? await photosPickerItem.loadTransferable(type:Data.self) {
                    if let image = UIImage(data: data){
                        avatarImage = image
                    }
                }
            }
        }

        
        
    }
}

#Preview {
    CreateCallView(showCallView: .constant(false))
}
