import QtQuick 2.3
import QtQuick.Window 2.2

import "../main.js" as Scripts
import "jamendo.js" as Site

Item {
    id: popup
    property string number: "0"
    property string list: ""
    property string pagesource: ""
    property string service: ""
    property string extrathing: ""
    property string sitedata: ""
    property string pluginlogo: "../img/jamendo.png"

    clip: true

    onStateChanged: if (popup.state == "Active") {
                        Site.get_html(service)
                    }

    states: [
        State {
            name: "Active"
            PropertyChanges {
                target: popup
                visible: true
            }
        },
        State {
            name: "InActive"
            PropertyChanges {
                target: popup
                visible: false
            }
        }
    ]

    anchors.centerIn: parent

    Image {
        id: bg
        anchors.centerIn: parent
        source: pagesource
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
    }

    Rectangle {
        anchors.fill: parent
        radius: 10
        color: Qt.rgba(0.5, 0.5, 0.5, 0.3)
        border.width: 1
    }

    Rectangle {
        id: blinder
        width: parent.width
        height: parent.height
        color: "white"
        radius: 10
        border.color: "black"

        states: [
            State {
                name: "loading"
                PropertyChanges {
                    target: blinder
                    y: 0
                }
                PropertyChanges {
                    target: links
                    opacity: 0
                }
            },
            State {
                name: "loaded"

                PropertyChanges {
                    target: blinder
                    //y:parent.height * 0.90
                    opacity: 1
                    radius: 0
                }

                when: bg.status == Image.Ready
            }
        ]
        state: "loading"

        transitions: Transition {
            PropertyAnimation {
                target: blinder
                properties: "y,radius"
                duration: 500
            }
        }

        Item {
            id: links
            height: parent.height
            width: parent.width
            opacity: 0

            Image {
                id: servicelogo
                source: pluginlogo
                width: parent.width * 0.10
                height: parent.height * 0.10
                fillMode: Image.PreserveAspectFit
            }
            Text {
                anchors.left: servicelogo.right
                anchors.verticalCenter: servicelogo.verticalCenter
                font.underline: true
                font.pixelSize: servicelogo.height * 0.5
                text: service
            }

            Column {
                width: parent.width
                anchors.top: servicelogo.bottom
                anchors.left: servicelogo.right
                anchors.margins: 20
                spacing: 10

                Item {
                    width: links.width * 0.98
                    height: links.height * 0.08
                    Rectangle {
                        anchors.fill: parent
                        color: "lightgray"
                        opacity: 0.4
                    }

                    Image {
                        source: "../img/message-sent.svg"
                        width: parent.height * 0.80
                        height: parent.height * 0.80
                        anchors.verticalCenter: parent.verticalCenter

                        Text {

                            anchors.leftMargin: 10
                            anchors.left: parent.right
                            text: qsTr("Chat")
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: parent.height * 0.60
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        onPressed: wrflasher.state = "Active"
                        onClicked: Qt.openUrlExternally(page)
                        onReleased: wrflasher.state = "InActive"
                    }
                }
            }
        }
    }

    Image {
        id: logo
        anchors.centerIn: parent
        source: pluginlogo
        width: parent.width / 3
        height: parent.height / 3
        fillMode: Image.PreserveAspectFit

        states: [
            State {
                name: "Loading"
                PropertyChanges {
                    target: logo
                    opacity: 1
                }
                PropertyChanges {
                    target: links
                    opacity: 0
                }
            },
            State {
                name: "Loaded"
                when: bg.status == Image.Ready
            }
        ]
        state: "loading"

        transitions: Transition {
            PropertyAnimation {
                target: logo
                properties: "opacity"
                duration: 300
            }
        }

        Text {
            anchors.top: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Plugin Under Development")
            font.pixelSize: (popup.width * 0.10) - text.length

            Text {
                anchors.top: parent.bottom
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Tap to launch in external application")
                wrapMode: Text.WordWrap
                font.pixelSize: (popup.width * 0.09) - text.length
            }
        }
    }
}
