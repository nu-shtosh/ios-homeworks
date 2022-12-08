//
//  Extension + UIButton.swift
//  Navigation
//
//  Created by Илья Дубенский on 08.12.2022.
//

import UIKit

extension UIButton.Configuration {
    public static func outline() -> UIButton.Configuration {
        var style = UIButton.Configuration.plain()
        var background = UIButton.Configuration.plain().background
        background.cornerRadius = 20
        background.strokeWidth = 1
        background.strokeColor = UIColor.systemGray5
        style.background = background

        return style
    }
}

class OutlineButton: UIButton {
    override func updateConfiguration() {
        guard let configuration = configuration else {
            return
        }

        var updatedConfiguration = configuration

        var background = UIButton.Configuration.plain().background
        background.cornerRadius = 20
        background.strokeWidth = 1

        let strokeColor: UIColor
        let foregroundColor: UIColor
        let backgroundColor: UIColor
        let baseColor = updatedConfiguration.baseForegroundColor ?? UIColor.tintColor

        switch self.state {
        case .normal:
            strokeColor = .systemGray5
            foregroundColor = baseColor
            backgroundColor = .clear
        case [.highlighted]:
            strokeColor = .systemGray5
            foregroundColor = baseColor
            backgroundColor = baseColor.withAlphaComponent(0.3)
        case .selected:
            strokeColor = .clear
            foregroundColor = .white
            backgroundColor = baseColor

        case [.selected, .highlighted]:
            strokeColor = .clear
            foregroundColor = .white
            backgroundColor = baseColor.darker()
        case .disabled:
            strokeColor = .systemGray6
            foregroundColor = baseColor.withAlphaComponent(0.3)
            backgroundColor = .clear
        default:
            strokeColor = .systemGray5
            foregroundColor = baseColor
            backgroundColor = .clear
        }

        background.strokeColor = strokeColor
        // 1
        // background.backgroundColor = backgroundColor
        background.backgroundColorTransformer = UIConfigurationColorTransformer { color in

            return backgroundColor
        }

        // 2
        // updatedConfiguration.baseForegroundColor = foregroundColor
        updatedConfiguration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in

            var container = incoming
            container.foregroundColor = foregroundColor

            return container
        }

        updatedConfiguration.background = background

        self.configuration = updatedConfiguration
    }
}
