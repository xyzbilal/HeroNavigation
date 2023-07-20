//
//  ContentView.swift
//  HeroNavigation
//
//  Created by Bilal SIMSEK on 20.07.2023.
//

import SwiftUI

struct ContentView: View {
    @State var selectedProfile:Profile?
    @State var pushView:Bool = false
    @State var hideView:(Bool,Bool) = (false,false)
    var body: some View {
        NavigationStack{
            Home(selectedProfile: $selectedProfile, pushView: $pushView)
                .navigationTitle("Profile")
                .navigationDestination(isPresented: $pushView) {
                    DetailsView(selectedProfile: $selectedProfile,
                                pushView: $pushView,
                                hideView:$hideView
                    )
                }
        }
        .overlayPreferenceValue(MAnchorKey.self, { value in
            GeometryReader(content: { geometry in
            
                    
                    // Hiding currentl tapped view
                if let selectedProfile, let anchor = value[selectedProfile.id],!hideView.0{
                        let rect = geometry[anchor]
                        ImageView(profile: selectedProfile, size: rect.size)
                            .offset(x:rect.minX,y:rect.minY)
                            .animation(.snappy(duration: 0.35,extraBounce: 0), value: rect)
                    }
            
            })
        })
    }
}


//ImageView(profile: profile, size: size)
#Preview {
    ContentView()
}
