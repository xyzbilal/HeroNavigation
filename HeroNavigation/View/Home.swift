//
//  Home.swift
//  HeroNavigation
//
//  Created by Bilal SIMSEK on 20.07.2023.
//

import SwiftUI

struct Home: View {
    @Binding var selectedProfile:Profile?
    @Binding var pushView:Bool
    var body: some View {
        List{
            ForEach(profiles) { profile in
                
                Button(action: {
                    selectedProfile = profile
                    pushView.toggle()
                }, label: {
                    HStack(spacing: 15){
                        Color.clear
                            .frame(width: 60,height: 60)
                        
                            .anchorPreference(key: MAnchorKey.self,value:.bounds ,transform: { anchor in
                                return [profile.id:anchor]
                            })
                        
                        
                        
                        VStack(alignment: .leading, spacing: 2, content: {
                            Text(profile.userName)
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
                            Text(profile.lastMsg)
                                .font(.callout)
                                .textScale(.secondary)
                                .foregroundStyle(.gray)
                        })
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        Text(profile.lastActive)
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                })
                
                
             
            }
            }
        .overlayPreferenceValue(MAnchorKey.self, { value in
            GeometryReader(content: { geometry in
                ForEach(profiles) { profile in
                    
                    // Hiding currentl tapped view
                    if let anchor = value[profile.id],selectedProfile?.id != profile.id {
                        let rect = geometry[anchor]
                        ImageView(profile: profile, size: rect.size)
                            .offset(x:rect.minX,y:rect.minY)
                            .allowsHitTesting(false)
                    }
                        
                        
                    }
            })
        })
    }
}


struct DetailsView:View {
    @Binding var selectedProfile:Profile?
    @Binding var pushView:Bool
    @Binding var hideView:(Bool,Bool)
    var body: some View {
        if let selectedProfile {
            VStack{
                GeometryReader(content: { geometry in
                    let size = geometry.size
                    
                    VStack{
                        
                        if !hideView.0{
                            Color.clear
                        }else{
                            ImageView(profile: selectedProfile, size: size)
                                .overlay(alignment:.top) {
                                    ZStack{
                                        Button(action: {
                                            pushView = false
                                            hideView.0 = false
                                            hideView.1 = false
                                            DispatchQueue.main.asyncAfter(deadline: .now()+0.45){
                                                self.selectedProfile = nil
                                            }
                                        }, label: {
                                            Image(systemName: "xmark")
                                                .foregroundColor(.white)
                                                .padding(10)
                                                .background(.black,in:.circle)
                                                .contentShape(.circle)
                                            
                                        })
                                        .padding(15)
                                        .padding(.top,30)
                                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight:.infinity,alignment: .topTrailing)
                                        Text(selectedProfile.userName)
                                            .font(.title.bold())
                                            .foregroundStyle(.black)
                                            .padding(15)
                                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                                                   maxHeight:.infinity,alignment: .bottomLeading)
                                        
                                    }
                                    
                                    .opacity(hideView.1 ? 1 : 0 )
                                    .animation(.snappy,  value:hideView.1)
                                    .onAppear(perform: {
                                        DispatchQueue.main.asyncAfter(deadline: .now()){
                                            hideView.1 = true
                                        }
                                    })
                                }
                        }
                    }
                 
                    
                    
                    
                        .anchorPreference(key: MAnchorKey.self,value:.bounds ,transform: { anchor in
                            return [selectedProfile.id:anchor]
                        })
                    
                })
                .frame(height: 400)
                .ignoresSafeArea()
                Spacer(minLength: 0)
            }
            .toolbar(hideView.0 ? .hidden : .visible , for: .navigationBar)
            .onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
                    hideView.0 = true
                }
            })
        }
    }
}


struct ImageView:View {
    let profile:Profile
    let size:CGSize
    var body: some View {
        Image(profile.profilePicture)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: size.width, height: size.height)
            .overlay(content: {
             
                    
               
                LinearGradient(colors: [
                    .clear,
                        .clear,
                        .clear,
                    .clear,
                    .white.opacity(0.1),
                    .white.opacity(0.5),
                    .white.opacity(0.9),
                    .white
                    
                ], startPoint: .top, endPoint: .bottom)
                .opacity(size.width > 60 ? 1 : 0)
                
            })
            .clipShape(.rect(cornerRadius: size.width == 60 ? 30 : 0))
    }
}



#Preview {
    ContentView()
}
