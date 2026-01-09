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

Page {
	padding: 0

	background: Rectangle {
		id: backgroundBanner
		anchors.fill: parent
		anchors.rightMargin: -1
		color: config.AccentColor
	}

	ShadowedRectangle {
		anchors.fill: parent
		corners.topRightRadius: 12
		corners.bottomRightRadius: 12
		color: bannerColor
	}

	ColumnLayout {
		anchors.left: parent.left
		anchors.top: parent.top
		anchors.bottom: parent.bottom
		anchors.leftMargin: 80
		width: 400
		z: 1

		spacing: 50

		Item {
			id: spacer
			Layout.preferredWidth: parent.width
			Layout.preferredHeight: parent.height / 2 - parent.height * 10 / 100
		}

		ColumnLayout {
			Layout.preferredWidth: parent.width
			Layout.preferredHeight: 50
			spacing: 0
			Label {
				text: "Welcome Back, " + user + "!"
				font.weight: Font.Bold
				font.pixelSize: 34
				color: "white"
			}
			Label {
				text: "Please sign in using your username and password"
				font.pixelSize: 12
				color: "white"
			}
		}

		// NEXT BUTTON

		Button {
			id: button
			Layout.preferredWidth: 110
			Layout.preferredHeight: 40

			hoverEnabled: true

			onClicked: {
				stackView.currentItem.objectName == "usersItm" ? stackView.push("Login.qml") : stackView.pop()
			}

			contentItem: RowLayout {
				anchors.centerIn: parent
				width: parent.width
				height: 40
				spacing: 0
				Label {
					Layout.preferredHeight: parent.height
					Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
					text: stackView.currentItem.objectName == "usersItm" ? "Go Next" : "Go Back"
					color: "white"
					horizontalAlignment: Qt.AlignRight
					verticalAlignment: Qt.AlignVCenter
				}
				Icon {
					Layout.preferredWidth: parent.width
					Layout.preferredHeight: parent.height
					Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
					visible: false
					width: 16
					height: 16
					color: "white"
					source: Qt.resolvedUrl("../Assets/go-next.svg")
				}
			}

			background: ShadowedRectangle {
				anchors.fill: parent
				color: button.hovered ? Qt.darker(bannerColor, 1.3) : Qt.darker(bannerColor, 1.5)
				border.color: button.hovered ? Qt.darker(bannerColor, 1.6) : Qt.darker(bannerColor, 2.0)
				border.width: 2
				radius: width

				Behavior on color {
					ColorAnimation { duration: 250 }
				}
			}
		}

		Item {
			id: spacerBottom
			Layout.fillHeight: true
		}

		Item {
			Layout.preferredHeight: 20
		}
	}

	Button {
		id: keyboardButton

		parent: root

		anchors.bottom: parent.bottom
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.margins: 10

		width: 50
		height: 50
		visible: false
		hoverEnabled: true
		text: inputPanel.visible ? "Keyboard enabled" : "Keyboard disabled"

		icon.source: inputPanel.visible ? Qt.resolvedUrl("../Assets/input-keyboard-virtual-hide.svg") : Qt.resolvedUrl("../Assets/input-keyboard-virtual-show.svg")

		Theme.colorSet: Theme.Complementary

		onClicked: {
			inputPanel.visible = !inputPanel.visible
		}

		background: Rectangle {
			anchors.fill: parent
			opacity: 0.5
			color: keyboardButton.hovered ? Qt.darker(bannerColor, 1.3) : Qt.darker(bannerColor, 1.5)
			border.color: keyboardButton.hovered ? Qt.darker(bannerColor, 1.6) : Qt.darker(bannerColor, 2.0)
			border.width: 2
			radius: 8

			Behavior on color {
				ColorAnimation { duration: 250 }
			}
		}
	}
}
