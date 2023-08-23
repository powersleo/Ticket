import SwiftUI

struct SettingsView: View {
    @State private var notificationsEnabled = true
    @State private var backgroundRefresh = true
    @State private var selectedRingtone = "Chimes"
    @State private var volumeLevel = 0.5

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Notifications")) {
                    Toggle(isOn: $notificationsEnabled) {
                        Text("Enabled")
                    }

                    Toggle(isOn: $backgroundRefresh) {
                        Text("Background Refresh")
                    }
                }

                Section(header: Text("Sounds")) {
                    Picker("Ringtone", selection: $selectedRingtone) {
                        Text("Chimes").tag("Chimes")
                        Text("Signal").tag("Signal")
                        Text("Waves").tag("Waves")
                    }

                    Slider(value: $volumeLevel) {
                        Text("Volume")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
