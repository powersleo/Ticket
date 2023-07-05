//
//  UserView.swift
//  City
//
//  Created by Leo Powers on 5/4/23.
//  Modified and Edited by Maliah Chin 5/12/23
//

import SwiftUI

struct UserView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack{
            
            NavigationView {
                VStack {
                    Image("Avatar")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .padding()
                    
                    Text("Username")
                        .font(.title)
                        .padding(.bottom)
                    
                    List {
                        Section(header: Text("Account")) {
                            Text("Email")
                            Text("Phone Number")
                            Text("Password")
                        }
                        
                    }
                }
                
                
                
            }.navigationTitle("User Info Page")
                        }
            
        }
    }


