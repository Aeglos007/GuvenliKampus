//
//  LocationManager.swift
//  MapApp
//
//  Created by yusuf ergül on 23.01.2024.
//

import SwiftUI
import MapKit

struct LocationDetailedView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    let location: Location
    
    var body: some View {
        ScrollView {
            VStack {
                imageSection
                    .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
                
                VStack(alignment: .leading, spacing: 16) {
                    titleSection

                    Divider()
                    mapLayer
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
            
            
        }
        .ignoresSafeArea()
        .background(.ultraThickMaterial)
        .overlay(alignment: .topLeading) {
            backButton
        }
    }
}

struct LocationDetailedView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailedView(location: LocationsDataService.locations.first!)
            .environmentObject(LocationsViewModel())
    }
}

extension LocationDetailedView {
    
    private var imageSection: some View {
        TabView {
            ForEach(location.imageNames, id: \.self) { imageName in
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil : UIScreen.main.bounds.width)
                    .clipped()
                
            }
        }
        .frame(height: 500)
        .tabViewStyle(.page)
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(location.name)
                .font(.title)
                .fontWeight(.medium)
        }
    }

    
    private var mapLayer: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(
            center: location.coordinates,
            span: MKCoordinateSpan(latitudeDelta: 0.007,longitudeDelta: 0.007))),
            annotationItems: [location ]){ location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotation()
                    .shadow(radius: 10)
            }
        }
            .allowsHitTesting(false)
            .aspectRatio(1, contentMode: .fit)
            .cornerRadius(30)
    }
    
    private var backButton: some View {
        Button {
            vm.sheetLocation = nil
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .foregroundColor(.primary)
                .padding(16)
                .frame(width: 40, height: 40)
                .background(.thickMaterial)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
        }

    }
    
}
