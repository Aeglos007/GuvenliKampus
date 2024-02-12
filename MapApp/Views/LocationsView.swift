//
//
//  MapApp
//
//  Created by yusuf ergül on 23.01.2024.
//

import SwiftUI
import MapKit
import PhotosUI
import Firebase


struct LocationsView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    @State private var manager: LocationManager = LocationManager()
    let maxWidthForIpad: CGFloat = 700
    @State var photosPickerItem: PhotosPickerItem?
    @State var showCallView : Bool = true
    @State var selected : MKMapItem?
    @State var route : MKRoute?
    @State var avatarImage : UIImage?
    
    var body: some View {
        
        VStack {
                ZStack {
                mapLayer
                    .ignoresSafeArea()
                
                VStack(spacing: 0)  {
                    header
                        .padding().padding()
                        .padding()
                        .frame(maxWidth: maxWidthForIpad)
                    Spacer()
                    locationsPreviewStack
                }
                }.sheet(isPresented: $showCallView) {
                    CreateCallView(showCallView: $showCallView)
                        .presentationDetents([.height(240)])
                        .presentationBackgroundInteraction(.enabled)
                        .presentationCornerRadius(20)
                        
                    
                        
                }
            .sheet(item: $vm.sheetLocation, onDismiss: nil) { location in
                LocationDetailedView(location: location)
                    
        }
            
                            
        }
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}

extension LocationsView {
    
    private var header: some View {
        VStack {
            Button {
                vm.toggleLocationsList()
            } label: {
                Text(vm.mapLocation.name)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 45)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.mapLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle.degrees(vm.showLocationsList ? 180 : 0))
                    }
            }
            
            
            if vm.showLocationsList {
                LocationsListView()
            }
        }
        .background(.ultraThickMaterial)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.4), radius: 20, x: 0, y: 15)
    }
    
    private var mapLayer: some View {
        Map(coordinateRegion: $vm.mapRegion,
            annotationItems: vm.locations,
            annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotation()
                
                    .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
                    .shadow(color: vm.mapLocation == location ?  .accentColor.opacity(0.3) : .black.opacity(0.3), radius: 10)
                    .onTapGesture {
                        vm.showNextLocation(location: location)
                        getDirections(home: .init(latitude: 38.4200, longitude: 27.2000) , destination: location)
                    }
                
            }
            
            
        })
        .mapControls({
            MapUserLocationButton()
            MapCompass()
            MapScaleView()
            
        })
        .animation(.easeInOut, value: vm.mapLocation)

    }
    
    private var locationsPreviewStack: some View {
        ZStack {
            ForEach(vm.locations) { location in
                if vm.mapLocation == location {
                    LocationPreviewView(location: location,showCallView: $showCallView)
                        .shadow(color: Color.black.opacity(0.2),radius: 20)
                        .padding()
                        .frame(maxWidth: maxWidthForIpad)
                        .frame(maxWidth: .infinity)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
                    
            }
            
        }
    }
    
    /*private var customMap: some View {
        Map() {
            ForEach(vm.locations){location in
                Annotation(coordinate: location.coordinates){
                    LocationMapAnnotation
                        .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
                        .shadow(color: vm.mapLocation == location ?  .accentColor.opacity(0.3) : .black.opacity(0.3), radius: 10)
                        .onTapGesture {
                            vm.showNextLocation(location: location)
                            
                        }}
            }
        }
    }*/
}
extension LocationsView {
    func getDirections(home: CLLocationCoordinate2D ,destination: Location) {
    route = nil
    let request = MKDirections.Request()
      request.source = MKMapItem(placemark:.init(coordinate: home))
        request.destination = MKMapItem(placemark:.init(coordinate: destination.coordinates))
    Task {
      let directions = MKDirections(request: request)
      let response = try? await directions.calculate()
      withAnimation {
        route = response?.routes.first
      }
    }
  }
}
