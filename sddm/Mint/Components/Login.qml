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
	id: loginPage

	objectName: "loginItm"

	property var sessionIcon: [
		{ name: "Plasma (Wayland)", icon: "../Assets/computer.svg" },
		{ name: "Plasma (X11)", icon: "../Assets/computer.svg" },
		{ name: "Plasma Mobile", icon: "../Assets/phone.svg" }
	]

	padding: 0

	Component.onCompleted: {
		sessionIndex = sessions.currentIndex
	}

	Connections {
		target: sddm
		function onLoginFailed() {
			login.column.credentials.passwordTx.placeholderText = "Failed"
		}
	}

	Connections {
		target: inputPanel
		function onVisibleChanged() {
			visible ? login.column.credentials.passwordTx.forceActiveFocus() : undefined
		}
	}

	// BACKGROUND

	background: ShadowedRectangle {
		id: background
		anchors.fill: parent
		corners.topRightRadius: 14
		corners.bottomRightRadius: 14
		color: config.AccentColor
	}

	// LOGIN PAGE

	ColumnLayout {
		id: login

		anchors.fill: parent
		anchors.margins: 20

		property Item column: column

		// SPACER

		Item {
			id: paneSpacer
			Layout.preferredHeight: parent.height / 2 - parent.height * 20 / 100
			Layout.alignment: Qt.AlignTop
		}

		// PASSWORD COMPONENT AND SESSIONS

		ColumnLayout {
			id: column

			Layout.preferredWidth: parent.width
			spacing: 25

			property Item credentials: credentials

			// LOGIN TEXT

			ColumnLayout {
				id: credentials

				Layout.preferredWidth: parent.width
				spacing: 10

				property Item passwordTx: passwordTx

				ColumnLayout {
					Layout.preferredWidth: parent.width

					spacing: 0

					Label {
						Layout.preferredWidth: 250
						text: "Password"
						font.pixelSize: 34
						font.weight: Font.Bold
						verticalAlignment: Qt.AlignVCenter
					}

					Label {
						Layout.preferredWidth: 250
						text: "Please enter your credentials to authenticate on this device"
						font.pixelSize: 10
						font.weight: Font.Light
						elide: Text.ElideRight
						wrapMode: Text.WordWrap
						verticalAlignment: Qt.AlignVCenter
					}
				}

				// PASSWORD

				TextField {
					id: passwordTx

                	Layout.preferredWidth: 110
                	Layout.preferredHeight: 40
                	font.pixelSize: 14
                	placeholderText: "Password .."
                	leftPadding: 15
					echoMode: TextInput.Password

					onEditingFinished: Qt.inputMethod.hide()

					onAccepted: {
						password = text
						sddm.login(user, password, sessionIndex)
					}

                	background: Rectangle {
                	    anchors.fill: parent
                	    anchors.rightMargin: -5
                	    color: "transparent"
                	    border.color: "grey"
                	    border.width: 2
                	    radius: 2
                	}
            	}
			}

			// SESSIONS

			ColumnLayout {

				Layout.preferredWidth: parent.width

				spacing: 10

				ColumnLayout {

					Layout.preferredWidth: parent.width

					spacing: 0

					Label {
						Layout.preferredWidth: 250
						text: "Session"
						font.pixelSize: 22
						font.weight: Font.Bold
						verticalAlignment: Qt.AlignVCenter
					}

					Label {
						Layout.preferredWidth: 250
						text: sessions.currentItem.session.text
						font.pixelSize: 10
						font.weight: Font.Light
						elide: Text.ElideRight
						wrapMode: Text.WordWrap
						verticalAlignment: Qt.AlignVCenter
					}
				}

				ListView {
					id: sessions

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

					model: sessionModel

					delegate: ItemDelegate {
						id: itemDelegate

						property Item session: session

						width: 200
						height: 250

						Rectangle {
							anchors.fill: parent
							color: index == sessions.currentIndex ? Qt.darker(config.AccentColor, 1.05) : Qt.darker(config.AccentColor, 1.02)
							Icon {
								anchors.centerIn: parent
								width: 128
								height: 128
								source: Qt.resolvedUrl(getSessionIcon(model.name))
							}

							Label {
								id: session
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
									sessions.currentIndex = index
									sessionIndex = index
								}
							}
						}
					}

					MouseArea {
						anchors.fill: parent
						propagateComposedEvents: true
						onWheel: (wheel) => {
							var speed = 6
							sessions.flick(wheel.angleDelta.y * speed, 0)
							wheel.accepted = true
						}
					}
				}
			}

			// SPACER

			Item {
				Layout.fillHeight: true
			}
		}
	}

	// FUNCTIONS

	function getSessionIcon(sessionName) {
		var result = sessionIcon.find(sessionicon => sessionicon.name === sessionName)
		return result ? result.icon : "computer-symbolic"
	}
}
