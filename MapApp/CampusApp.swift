
//
import FirebaseCore
import SwiftUI

@main
struct CampusApp: App {
    
    @StateObject private var vm: LocationsViewModel = LocationsViewModel()

    
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
