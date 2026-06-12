//
// This file is part of SDDM Sugar Candy.
// A theme for the Simple Display Desktop Manager.
//
// Copyright (C) 2018–2020 Marian Arlt
//
// SDDM Sugar Candy is free software: you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by the
// Free Software Foundation, either version 3 of the License, or any later version.
//
// You are required to preserve this and any additional legal notices, either
// contained in this file or in other files that you received along with
// SDDM Sugar Candy that refer to the author(s) in accordance with
// sections §4, §5 and specifically §7b of the GNU General Public License.
//
// SDDM Sugar Candy is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with SDDM Sugar Candy. If not, see <https://www.gnu.org/licenses/>
//

import QtQml
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects
import SddmComponents as SDDM
import QtQml.Models
import org.kde.kirigami
import org.kde.kirigami.primitives
import org.kde.kirigami.layouts
import org.kde.kirigami.platform
import "Components"

Page {
    id: root

	property color backColor: "black"
	property color bannerColor: "#737373"
	property int bannerWidth: 42
	property string user
	property string password
	property int sessionIndex

	width: Screen.width
    height: Screen.height
	padding: config.ScreenPadding
	focus: true

    LayoutMirroring.enabled: config.ForceRightToLeft == "true" ? true : Qt.application.layoutDirection === Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

	// BACKGROUND

	background: Rectangle {
		id: background

		anchors.fill: parent
		color: backColor

		ShadowedRectangle {
			anchors.fill: parent
			corners.topRightRadius: 14
			corners.bottomRightRadius: 14
			color: config.AccentColor
			visible: false
		}
	}

	// VIRTUAL KEYBOARD

	/*
	InputPanel {
		id: inputPanel
		anchors.bottom: parent.bottom
		anchors.horizontalCenter: parent.horizontalCenter
		width: parent.width / 2
		visible: false
		z: 1
	}
	*/

	// BANNER

	StackView {
		id: stack

		//anchors.left: parent.left
		anchors.top: parent.top
		anchors.bottom: parent.bottom

		x: -50
		opacity: 0

		width: parent.width - parent.width * (100 - bannerWidth) / 100
		height: parent.height

		Behavior on opacity {
			NumberAnimation { duration: 2000 ; easing.type: Easing.OutExpo }
		}

		Behavior on x {
			NumberAnimation { duration: 2000 ; easing.type: Easing.OutExpo }
		}

		Behavior on scale {
			NumberAnimation { duration: 2000 ; easing.type: Easing.OutExpo }
		}

		Behavior on width {
			NumberAnimation { duration: 2000 ; easing.type: Easing.OutExpo }
		}

		background: Rectangle {
			anchors.fill: parent
			color: config.AccentColor
		}

		pushEnter: Transition {
			PropertyAnimation {
				property: "opacity"
				from: 0
				to: 1
				duration: 1000
				easing.type: Easing.OutExpo
			}
		}

		pushExit: Transition {
			PropertyAnimation {
				property: "opacity"
				from: 1
				to: 0
				duration: 1000
			}
		}

		popEnter: Transition {
			PropertyAnimation {
				property: "opacity"
				from: 0
				to: 1
				duration: 1000
			}
		}

		popExit: Transition {
			PropertyAnimation {
				property: "opacity"
				from: 1
				to: 0
				duration: 1000
			}
		}

		Component.onCompleted: {
			x = 0
			opacity = 1
			stack.push("Components/Banner.qml")
		}
	}

	// PAGES

	Page {
		id: pages

		anchors.left: stack.right
		anchors.right: parent.right
		anchors.top: parent.top
		anchors.bottom: parent.bottom

		padding: 0

		background: ShadowedRectangle {
			anchors.fill: parent
			corners.topRightRadius: 12
			corners.bottomRightRadius: 12
			color: config.AccentColor
		}

		Component.onCompleted: {
			stackView.push("Components/Users.qml")
		}

		StackView {
			id: stackView
			anchors.fill: parent
			clip: true

			pushEnter: Transition {
				PropertyAnimation {
					property: "opacity"
					from: 0
					to: 1
					duration: 2000
					easing.type: Easing.OutExpo
				}
				PropertyAnimation {
					property: "x"
					from: -20
					to: 0
					duration: 2000
					easing.type: Easing.OutExpo
				}
			}

			pushExit: Transition {
				PropertyAnimation {
					property: "opacity"
					from: 1
					to: 0
					duration: 2000
					easing.type: Easing.OutExpo
				}
			}

			popEnter: Transition {
				PropertyAnimation {
					property: "opacity"
					from: 0
					to: 1
					duration: 2000
					easing.type: Easing.OutExpo
				}
			}

			popExit: Transition {
				PropertyAnimation {
					property: "opacity"
					from: 1
					to: 0
					duration: 2000
					easing.type: Easing.OutExpo
				}
			}
		}
	}
}
