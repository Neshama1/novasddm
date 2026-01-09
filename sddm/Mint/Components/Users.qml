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
	id: usersPage
	objectName: "usersItm"

	property Item listView: listView
	padding: 0

	Component.onCompleted: {
		user = listView.currentItem.username.text
	}

	//BACKGROUND

	background: ShadowedRectangle {
		id: backgroundPane
		anchors.fill: parent
		corners.topRightRadius: 14
		corners.bottomRightRadius: 14
		color: config.AccentColor
	}

	// IMAGE 1

	Image {
		anchors.right: parent.right
		anchors.top: parent.top
		anchors.margins: -500
		width: 1600
		height: 1600
		opacity: 0.03
		source: Qt.resolvedUrl("../Assets/image-1.png")
	}

	// USERS PAGE

	ColumnLayout {
		anchors.fill: parent
		anchors.margins: 20

		// SPACER

		Item {
			id: paneSpacer
			Layout.preferredHeight: parent.height / 2 - parent.height * 15 / 100
			Layout.alignment: Qt.AlignTop
		}

		// LOGIN TEXT

		ColumnLayout {
			id: column

			Layout.preferredWidth: parent.width
			spacing: 25

			// LOGIN TEXT AND NEXT BUTTON

			RowLayout {

				Layout.preferredWidth: parent.width
				Layout.preferredHeight: 70

				spacing: 10

				// TEXT

				ColumnLayout {
					Layout.preferredWidth: 200
					Layout.preferredHeight: parent.height

					spacing: 0

					Label {
						Layout.preferredWidth: 200
						text: "Sign in"
						font.pixelSize: 36
						font.weight: Font.Bold
						verticalAlignment: Qt.AlignVCenter
					} 
					Label {
						Layout.preferredWidth: 200
						text: "Enter your credential to access your account"
						font.pixelSize: 10
						font.weight: Font.Light
						elide: Text.ElideRight
						wrapMode: Text.WordWrap
						verticalAlignment: Qt.AlignVCenter
					}
				}
			}

			// USERS

			ListView {
				id: listView

				Layout.preferredWidth: parent.width
				Layout.preferredHeight: 250
				spacing: 10
				orientation: ListView.Horizontal
				clip: true

				ScrollBar.horizontal: ScrollBar {
					id: scrollBar
					hoverEnabled: true
					orientation: Qt.Horizontal
					policy: ScrollBar.AlwaysOff
				}

				currentIndex: model.lastIndex

				model: userModel

				delegate: ItemDelegate {
					id: itemDelegate

					property Item username: username

					width: 200
					height: 250

					Rectangle {
						anchors.fill: parent
						color: index == listView.currentIndex ? Qt.darker(config.AccentColor, 1.05) : Qt.darker(config.AccentColor, 1.02)
						Icon {
							anchors.centerIn: parent
							width: 128
							height: 128
							source: Qt.resolvedUrl("../Assets/user-identity.svg")
						}

						Label {
							id: username
							anchors.left: parent.left
							anchors.right: parent.right
							anchors.bottom: parent.bottom
							anchors.margins: 10
							font.pixelSize: 24
							font.weight: Font.Light
							elide: Text.ElideRight
							horizontalAlignment: Text.AlignHCenter
							text: model.name
						}

						MouseArea {
							anchors.fill: parent
							onClicked: {
								listView.currentIndex = index
								user = model.name
							}
						}
					}
				}

				MouseArea {
					anchors.fill: parent
					propagateComposedEvents: true
					onWheel: (wheel) => {
						var speed = 6
						listView.flick(wheel.angleDelta.y * speed, 0)
						wheel.accepted = true
						//wheel.angleDelta.y > 0 ? scrollBar.increase() : scrollBar.decrease()
					}
				}
			}
		}

		Item {
			id: paneSpacerBottom
			Layout.fillHeight: true
		}
	}
}