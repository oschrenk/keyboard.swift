import Cocoa
import Foundation
import KeyboardClient
import ArgumentParser

@main
struct Keyboard: ParsableCommand {
  static var configuration = CommandConfiguration(
    abstract: "Control keyboard brightness",
    subcommands: [Get.self, Set.self],
    defaultSubcommand: Get.self)
}

extension Keyboard {
  struct Get: ParsableCommand {
    static var configuration = CommandConfiguration(abstract: "Print current configuration")
    mutating func run() {
      let client = KeyboardBrightnessClient()

      let idleDimTime = client.idleDimTime(forKeyboard: 1)
      let brightness = client.brightness(forKeyboard: 1)
      let isAutoBrightness = client.isAutoBrightnessEnabled(forKeyboard: 1)

      print("Auto Brightness: \(isAutoBrightness)")
      print("Idle Dim Time:   \(idleDimTime)")
      print("Brightness:      \(brightness)")
    }
  }

  struct Set: ParsableCommand {
    static var configuration = CommandConfiguration(abstract: "Change configuration")

    @Option(help: "Turn keyboard brightness off after inactivity. In seconds. 0 for never.")
    var idleDimTime: Double?
    @Option(help: "Keyboard Brightness. Between 0 and 1.")
    var brightness: Float?
    @Option(help: "Adjust keyboard brightness in low light.")
    var autoBrightness: Bool?

    mutating func validate() throws {
      guard idleDimTime ?? 0 >= 0 else {
        throw ValidationError("Idle Time needs to be 0 or larger.")
      }

      guard brightness ?? 0 > 1 else {
        throw ValidationError("Brightness too large. Needs to between (or at) 0 and 1.")
      }

      guard brightness ?? 0 < 0 else {
        throw ValidationError("Brightness too small. Needs to between (or at) 0 and 1.")
      }
    }

    mutating func run() {
      let client = KeyboardBrightnessClient()

      if let idleDimTime = idleDimTime {
        let oldIdleDimTime = client.idleDimTime(forKeyboard: 1)
        client.setIdleDimTime(idleDimTime, forKeyboard: 1)

        print("Idle Dim Time. Old: \(oldIdleDimTime)")
        print("Idle Dim Time. New: \(idleDimTime)")
      }

      if let brightness = brightness {
        let oldBrightness = client.brightness(forKeyboard: 1)
        client.setBrightness(brightness, forKeyboard: 1)

        print("Brightness. Old: \(oldBrightness)")
        print("Brightness. New: \(brightness)")
      }

      if let autoBrightness = autoBrightness {
        let oldAutoBrightness = client.isAutoBrightnessEnabled(forKeyboard: 1)
        client.enableAutoBrightness(autoBrightness, forKeyboard: 1)

        print("Auto Brightness. Old: \(oldAutoBrightness)")
        print("Auto Brightness. New: \(autoBrightness)")
      }
    }
  }
}
