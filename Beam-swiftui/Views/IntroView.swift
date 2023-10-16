//
//  IntroView.swift
//  Beam-swiftui
//
//  Created by Advikaa Ramesh on 15/10/23.
//

import SwiftUI

struct IntroView: View {
    @State var showWalkThroughScreens: Bool = false
    @State var currentIndex: Int = 0
    @State var showHomeView : Bool = false
    var body: some View {
        ZStack{
            if showHomeView{
                Home()
                    .transition(.move(edge: .trailing))
            }else{
                ZStack{
                    IntroScreen()
                    WalkThroughScreens()
                        
                    NavBar()
                }
                .animation(.interactiveSpring(response: 1.1,dampingFraction: 0.85, blendDuration: 0.85), value: showWalkThroughScreens)
                .transition(.move(edge: .leading))

            }
        }
        .animation(.easeInOut(duration: 0.35), value: showHomeView)
    }
    
    //MARK : WalkThrough Screens
    @ViewBuilder
    func WalkThroughScreens() -> some View{
        let isLast = currentIndex == intros.count
        GeometryReader{
            let size = $0.size
            ZStack{
                ForEach(intros.indices, id: \.self){ index in
                    ScreenView(size: size, index: index)
                }
                WelcomeView(size: size, index: intros.count)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            .overlay(alignment: .bottom){
                ZStack{
                    Image(systemName: "chevron.right")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .scaleEffect(!isLast ? 1 : 0.001)
                        .opacity(!isLast ? 1 : 0)
                    HStack{
                        Text("Sign Up")
                            .font(.system(size: 20))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.white)
                        Image(systemName: "arrow.right")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        
                    }
                    .padding(.horizontal,15)
                    .scaleEffect(isLast ? 1 : 0.001)
                    .frame(height: isLast ? nil : 0)
                    .opacity(isLast ? 1 : 0)
                }
                
                .frame(width: isLast ? size.width / 1.5 : 55, height: isLast ? 50 : 55)
                .foregroundColor(.white)
                .background(Color.orange)
                .cornerRadius(isLast ? 15 : 27.5)
            
                .onTapGesture {
                    if currentIndex == intros.count{
                        showHomeView = true
                    }else{
                        currentIndex += 1
                    }
                    }
                .offset(y: isLast ? -40 : -90)
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5), value: isLast)
            }
            .overlay(alignment: .bottom, content: {
                let isLast = currentIndex == intros.count
                HStack(spacing: 5){
                    Text("Already have an account?")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                    Button("Login"){
                        
                    }
                    .font(.system(size: 16))
                    .foregroundColor(.orange)
                    
                }
                .offset(y: isLast ? -12 : 100)
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5), value: isLast)
            })
            .offset(y: showWalkThroughScreens ? 0 : size.height)
        }
    }
    @ViewBuilder
    func ScreenView(size:CGSize, index: Int) -> some View{
        let intro = intros[index]
        
        VStack(spacing: 10) {
            Text(intro.title)
                .font(.system(size: 27))
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9,dampingFraction: 0.8,blendDuration: 0.5).delay(currentIndex == index ? 0.2: 0), value : currentIndex)
                .foregroundColor(.orange)
                .fontWeight(.semibold)
            //Insert image description here
            Image(intro.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 250,alignment: .top)
                .padding(.horizontal,50)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9,dampingFraction: 0.8,blendDuration: 0.5), value : currentIndex)
        }
    }
    
    @ViewBuilder
    func WelcomeView(size:CGSize, index: Int) -> some View{
        
        VStack(spacing: 10) {
            Text("Welcome to the start of your mental health journey!")
                .font(.system(size: 32))
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9,dampingFraction: 0.8,blendDuration: 0.5).delay(currentIndex == index ? 0.1: 0), value : currentIndex)
                .foregroundColor(.orange)
                .fontWeight(.semibold)
                .padding()
                .multilineTextAlignment(.center)
                
            
            Image("welcome")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 250,alignment: .top)
                .padding(.horizontal,20)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9,dampingFraction: 0.8,blendDuration: 0.5), value : currentIndex)
        }
        .offset(y : -30)
    }
    
    @ViewBuilder
    func NavBar()-> some View{
        let isLast = currentIndex == intros.count
        
        HStack{
            Button{
                if currentIndex > 0{
                    currentIndex -= 1
                }
                else{
                    showWalkThroughScreens.toggle()
                }
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.orange)
            }
            Spacer()
            Button("Skip"){
                currentIndex = intros.count
            }
            .font(.system(size: 17))
            .foregroundColor(.orange)
            .opacity(isLast ? 0 : 1)
            .animation(.easeInOut, value : isLast)
        }
        .padding(.horizontal,15)
        .padding(.top,10)
        .frame(maxHeight: .infinity,alignment: .top)
        .offset(y: showWalkThroughScreens ? 0 :-120)
    }
    @ViewBuilder
    func IntroScreen() -> some View{
        GeometryReader{
            let size = $0.size
            VStack(spacing: 10){
                Image("Beam opening_ob")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height/2)
                Text("Beam")
                    .fontWeight(.bold)
                    .font(.system(size: 40))
                    .foregroundColor(.orange)
                    .padding(.top,10)
                

                
                Text("A Pitstop on your journey to Happiness!")
                    .font(.system(size: 27))
                    .multilineTextAlignment(.center)
                    .fontWeight(.semibold)
                    .foregroundColor(.orange)
                    
                Text("Let's Begin!")
                    .font(.system(size: 18))
                    .padding(.horizontal,40)
                    .padding(.vertical,14)
                    .foregroundColor(.white)
                    .background(Color.orange)
                    .cornerRadius(20)
                    .onTapGesture {
                        showWalkThroughScreens.toggle()
                    }
                    .padding(.top,80)
            }
            
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .offset(y: showWalkThroughScreens ? -size.height: 0)
        }
        .ignoresSafeArea()
    }
}

struct IntroView_Preview: PreviewProvider{
    static var previews: some View{
        ContentView()
    }
}
struct Home: View{
    var body: some View{
        NavigationStack{
            Text("")
                .navigationTitle("Home")
        }
    }
}
#Preview {
    IntroView()
}
