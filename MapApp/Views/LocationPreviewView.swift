
//  Created by yusuf ergül on 23.01.2024.


import SwiftUI

struct LocationPreviewView: View {
    
    let location: Location
    
    @EnvironmentObject private var vm: LocationsViewModel
    @Binding var showCallView : Bool
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 16){
                imageSection
                titleSection
            }
            VStack(spacing: 8) {
                learnMoreButton
                nextButton
                    
            }
        }
        
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y:50)
        )
        .cornerRadius(10)
    }
}

struct LocationPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        LocationPreviewView(location: LocationsDataService.locations.first!,showCallView: .constant(true))
            .padding()
            .environmentObject(LocationsViewModel())
    }
}

extension LocationPreviewView {
    
    private var imageSection: some View {
        ZStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
                    .onTapGesture(perform: {
                        vm.sheetLocation = location
                    })
            }
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
        
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
  
    private var learnMoreButton: some View {
        Button {
            showCallView = !showCallView
        } label: {
            Text("Çağrı Oluştur")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.borderedProminent)
    }
    private var nextButton: some View {
        Button {
            vm.nextButtonPressed()
        } label: {
            Text("Diğer Çağrı")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.bordered)
    }
}
