//
//  LocationManager.swift
//  MapApp
//
//  Created by yusuf ergül on 23.01.2024.
//

import SwiftUI

struct LocationMapAnnotation: View {
    
    let accentColor = Color("AccentColor")
    var body: some View {
        VStack(spacing: 0) {
             Image(systemName: "map.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .padding(6)
                .foregroundColor(.white)
                .background(Color.accentColor)
                .cornerRadius(36)
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 10, height: 10)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -3)
                .foregroundColor(.accentColor)
                .padding(.bottom, 40)
                
             
        }
    }
}

struct LocationMapAnnotation_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            LocationMapAnnotation()
        }
    }
}
