import QtQuick 2.9
import QtQuick.Dialogs 1.2
//import QtWebKit 3.0
//import QtWebView 1.0
import QtQuick.Window 2.3
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.LocalStorage 2.0 as Sql
import "main.js" as Scripts
import "openseed.js" as OpenSeed
import "text.js" as Scrubber


Item {
             //title: qsTr("Settings")
             //page: Page {
 id:thisWindow

 property bool simpleMode: false
 property string type:"profile"

// clip: true
// width:parent.width
// height:parent.height
// x:0
// y:0
 //title: qsTr("CafeSync - Settings")

 //Component.onCompleted: Scripts.load_Card();



 states: [
     State {
         name: "Active"
         PropertyChanges {
             target:thisWindow

             x:0


         }
     },
     State {
          name: "InActive"
          PropertyChanges {
              target:thisWindow

              x:width * -1


          }
     }



 ]

 transitions: [
     Transition {
         from: "InActive"
         to: "Active"
         reversible: true


         NumberAnimation {
             target: thisWindow
             property: "x"
             duration: 200
             easing.type: Easing.InOutQuad
         }
     }


 ]

 property bool sourceselect: false
 property bool saveit: false
 property int profilesection: 0

 property var yourworked:[]
 property var yourskills:[]
 property var yourschooling:[]
 property string yourabout:""


onStateChanged: if(thisWindow.state == "Active") {topBar.state = "settings"; Scripts.skillListings();Scripts.schoolListings();Scripts.workListings();Scripts.fillsites();} else {topBar.state = "standard";

                                    /*Scripts.save_card(userid,userName.text,userPhone.text,userEmail.text,userCompany.text,
                                                      userAlias.text,personalMotto.text,usermain,website1,website2,website3,website4,
                                                      stf,atf,ctf,avimg,carddesign,usercat);
                                    OpenSeed.upload_data(userid,userName.text,userPhone.text,userEmail.text,userCompany.text,
                                                         userAlias.text,personalMotto.text,stf,atf,ctf,usermain,website1,website2,website3,website4,
                                                         avimg,carddesign,usercat); */

                }
onSourceselectChanged: if(sourceselect == true) {sourceSelector.state = "Active"} else {sourceSelector.state = "InActive"}

onSaveitChanged: if(saveit == true) {

                                    savedReport.visible = true;
                                     var motd = "";

                                    if(yourabout == "") {
                                        motd = usermotto.split(";::;")[0];
                                       } else {
                                            motd = yourabout;
                                        }


                                     Scripts.save_card(userid,userName.text,userPhone.text,userEmail.text,userCompany.text,
                                                       userAlias.text,motd+";::;"+yourskills+";::;"+yourschooling+";::;"+yourworked,usermain,website1,website2,website3,website4,
                                                       stf,atf,ctf,avimg,carddesign,usercat);
                                     OpenSeed.upload_data(userid,userName.text,userPhone.text,userEmail.text,userCompany.text,
                                                          userAlias.text,motd+";::;"+yourskills+";::;"+yourschooling+";::;"+yourworked,stf,atf,ctf,usermain,website1,website2,website3,website4,
                                                          avimg,carddesign,usercat); saveit = false;

                 }


onEnabledChanged: if(enabled == true) {Scripts.fillsites();}

 Rectangle {
     color:backgroundColor
    // color: "white"
     //y:listthing.height
     width:parent.width
     height:parent.height
     //border.width: 1
 }

 Item {
     id:pages
     anchors.top: parent.top
     anchors.horizontalCenter: parent.horizontalCenter
     width: parent.width
     height: parent.height * 0.10
     clip: true

     Button {
         width:parent.width * 0.49
         height: parent.height * 0.80
         text: "Profile"
         anchors.left: parent.left
         anchors.verticalCenter: parent.verticalCenter
         contentItem: Text {
                            width:parent.width
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font:parent.font
                            text:parent.text
                            color:fontColorTitle
                        }
         background: Rectangle {
                     color:if(type == "profile") {highLightColor1} else {backgroundColor}
                     }
         onClicked: {type = "profile"

                     }
     }

     Button {
         width:parent.width * 0.49
         height: parent.height * 0.80
         text: "System"
         anchors.right: parent.right
         anchors.verticalCenter: parent.verticalCenter
         contentItem: Text {
                            width:parent.width
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font:parent.font
                            text:parent.text
                            color:fontColorTitle
                        }
         background: Rectangle {
                     color:if(type == "settings") {highLightColor1} else {backgroundColor}
                     }
         onClicked: {type = "settings";

                     }
     }
 }

Flickable {
    id:settingFlick
    visible: if(type == "settings") {true} else {false}
    clip:true
    y: pages.height
    height: parent.height - pages.height
    width: parent.width * 0.98
    anchors.horizontalCenter: parent.horizontalCenter
    contentHeight:settingsColumn.height

    onVisibleChanged: if(visible == true) {if(cM == 1) {chance.checked = true} else {chance.check = false}
                                           if(fM == 1) { frequent.checked = true;} else { frequent.checked = false}
                                           if(mM == 1) { missed.checked = true;} else { missed.checked = false}
                      }
    Column {
        id:settingsColumn
        width:parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        spacing:mainView.width * 0.04


        Item {
            width:parent.width
            height:parent.height * 0.01

       }
       Item {
           width:parent.width
           height:settitle.height
        Text {
            id:settitle
            text: qsTr("CafeSync Settings")
            anchors.left:parent.left
            font.pixelSize: parent.width * 0.07
            anchors.leftMargin: 4
            width:parent.width * 0.60
            //anchors.verticalCenter: parent.verticalCenter
            color:fontColorTitle

        }

    }

       Rectangle {
           width: parent.width * 0.98
           height:3
           anchors.horizontalCenter: parent.horizontalCenter

           color:seperatorColor1

       }

       Item {
           width:parent.width
           height:collectionColumn.height * 1.1

           Rectangle {
               id:colback
            anchors.fill:parent
            visible: false
            color:cardcolor
           }

           DropShadow {

              anchors.fill: colback
              horizontalOffset: 0
              verticalOffset: 3
              radius: 8.0
              samples: 17
              color: "#80000000"
              source: colback

            }

               Column {
                id: collectionColumn
                width:parent.width * 0.98
                anchors.centerIn: parent
                spacing: thisWindow.width * 0.006

                    Text {
                        text:qsTr("Collection:")
                        font.pixelSize: mainView.width * 0.07
                        color:fontColor
                        }
                    Rectangle {
                        width: parent.width * 0.98
                        height:3
                        anchors.horizontalCenter: parent.horizontalCenter

                        color:seperatorColor1

                    }

                     SpinBox {
                        anchors.right:parent.right
                       //anchors.bottom:parent.bottom
                        width:thisWindow.width *0.45
                        id: delSpin
                        from:1
                        to: 99
                        value: sT
                        textFromValue: function(value) {
                            return value+" Days";
                        }

                        contentItem: Label {
                                text:parent.value+" Days";
                                width:parent.width
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                color:fontColor
                                font.pixelSize: mainView.width * 0.04
                            }

                        down.indicator: Rectangle {
                                            width:parent.height /2
                                            height:parent.height /2
                                            radius: width /2
                                            anchors.left:parent.left
                                            anchors.verticalCenter: parent.verticalCenter
                                            color:activeColor

                                            Image {
                                                id:d1
                                                source:"./icons/minus.svg"
                                                anchors.centerIn: parent
                                                fillMode: Image.PreserveAspectFit
                                                width: parent.width * 0.65


                                            }

                                            ColorOverlay {
                                                source:d1
                                                color:fontColor
                                                anchors.fill:d1


                                            }

                                            }

                        up.indicator: Rectangle {
                                            width:parent.height /2
                                            height:parent.height /2
                                            radius: width /2
                                            anchors.right:parent.right
                                            anchors.verticalCenter: parent.verticalCenter
                                            color:activeColor

                                            Image {
                                                id:u1
                                                source:"./icons/add.svg"
                                                anchors.centerIn: parent
                                                fillMode: Image.PreserveAspectFit
                                                width: parent.width * 0.65
                                            }

                                            ColorOverlay {
                                                source:u1
                                                color:fontColor
                                                anchors.fill:u1


                                            }

                                            }

                        onValueChanged: {if(settingFlick.visible == true) {
                            sT = value;
                            Scripts.save_setting("tempSupress",sT);
                            }
                        }

                        Text {
                            anchors.right: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            width:(thisWindow.width * 0.95) - parent.width
                            text:qsTr("Supress deleted temporary cards for:")
                            wrapMode: Text.WordWrap
                            font.pixelSize: mainView.width * 0.04
                            verticalAlignment: Text.AlignVCenter
                            color:fontColor
                        }
                   }

                       SpinBox {
                           anchors.right:parent.right
                           width:thisWindow.width *0.45
                           //anchors.bottom:parent.bottom
                            id: keepSpin
                            from:1
                            to: 5
                            value: kT
                            textFromValue: function(value) {
                                return value+" Days";
                            }

                            contentItem: Label {
                                text:parent.value+" Days";
                                width:parent.width
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                color:fontColor
                                font.pixelSize: mainView.width * 0.04
                                }


                            down.indicator: Rectangle {
                                                width:parent.height /2
                                                height:parent.height /2
                                                radius: width /2
                                                anchors.left:parent.left
                                                anchors.verticalCenter: parent.verticalCenter
                                                color:activeColor

                                                Image {
                                                    id:d2
                                                    source:"./icons/minus.svg"
                                                    anchors.centerIn: parent
                                                    fillMode: Image.PreserveAspectFit
                                                    width: parent.width * 0.65


                                                }

                                                ColorOverlay {
                                                    source:d2
                                                    color:fontColor
                                                    anchors.fill:d2


                                                }

                                                }

                            up.indicator: Rectangle {
                                                width:parent.height /2
                                                height:parent.height /2
                                                radius: width /2
                                                anchors.right:parent.right
                                                anchors.verticalCenter: parent.verticalCenter
                                                color:activeColor

                                                Image {
                                                    id:u2
                                                    source:"./icons/add.svg"
                                                    anchors.centerIn: parent
                                                    fillMode: Image.PreserveAspectFit
                                                    width: parent.width * 0.65
                                                }

                                                ColorOverlay {
                                                    source:u2
                                                    color:fontColor
                                                    anchors.fill:u2


                                                }

                                                }




                            onValueChanged: {if(settingFlick.visible == true) {
                                kT = value;
                                Scripts.save_setting("keepTemp",kT);
                                }
                            }

                            Text {
                                anchors.right: parent.left
                                anchors.verticalCenter: parent.verticalCenter
                                width:(thisWindow.width * 0.95) - parent.width
                                text:qsTr("Keep collected cards for:")
                                font.pixelSize: mainView.width * 0.04
                                verticalAlignment: Text.AlignVCenter
                                color:fontColor
                            }
                       }





                   SpinBox {
                       anchors.right:parent.right
                       width:thisWindow.width *0.45
                       //anchors.bottom:parent.bottom
                        id: areaSpin
                        from:10
                        to: 50
                        value: sD

                        textFromValue: function(value) {
                            return value+ " Miles";
                        }

                        contentItem: Label {
                            text:parent.value+" Miles";
                            width:parent.width
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            color:fontColor
                            font.pixelSize: mainView.width * 0.04
                            }


                        down.indicator: Rectangle {
                                            width:parent.height /2
                                            height:parent.height /2
                                            radius: width /2
                                            anchors.left:parent.left
                                            anchors.verticalCenter: parent.verticalCenter
                                            color:activeColor

                                            Image {
                                                id:d3
                                                source:"./icons/minus.svg"
                                                anchors.centerIn: parent
                                                fillMode: Image.PreserveAspectFit
                                                width: parent.width * 0.65


                                            }

                                            ColorOverlay {
                                                source:d3
                                                color:fontColor
                                                anchors.fill:d3


                                            }

                                            }

                        up.indicator: Rectangle {
                                            width:parent.height /2
                                            height:parent.height /2
                                            radius: width /2
                                            anchors.right:parent.right
                                            anchors.verticalCenter: parent.verticalCenter
                                            color:activeColor

                                            Image {
                                                id:u3
                                                source:"./icons/add.svg"
                                                anchors.centerIn: parent
                                                fillMode: Image.PreserveAspectFit
                                                width: parent.width * 0.65
                                            }

                                            ColorOverlay {
                                                source:u3
                                                color:fontColor
                                                anchors.fill:u3


                                            }

                                            }


                        onValueChanged: {if(settingFlick.visible == true) {
                            sD = value;
                            Scripts.save_setting("searchDistance",sD);
                            }
                        }

                        Text {
                            anchors.right: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            width:(thisWindow.width * 0.95) - parent.width
                            text:qsTr("Area Search Range:")
                            font.pixelSize: mainView.width * 0.04
                            verticalAlignment: Text.AlignVCenter
                            color:fontColor
                        }
                   }


                }


             }


       Item {
           width:parent.width
           height:eventsColumn.height * 1.1

           Rectangle {
               id:eventsback
            anchors.fill:parent
            visible: false
            color:cardcolor
           }

           DropShadow {

              anchors.fill: eventsback
              horizontalOffset: 0
              verticalOffset: 3
              radius: 8.0
              samples: 17
              color: "#80000000"
              source: eventsback

            }

       Column {
           id:eventsColumn
           width:parent.width * 0.98
           anchors.centerIn: parent
           spacing: 10

           Text {
               text:qsTr("Events:")
               font.pixelSize: mainView.width * 0.07
               color:fontColor
           }

           Rectangle {
               width: parent.width * 0.98
               height:3
               anchors.horizontalCenter: parent.horizontalCenter

               color:seperatorColor1

           }

           Text {
               text:qsTr("Auto Created Events:")
               font.pixelSize: mainView.width * 0.05
                color:fontColor
           }

       Switch {
           id:chance
           anchors.left:parent.left
           width:thisWindow.width * 0.15
           anchors.leftMargin: thisWindow.width * 0.01
           text:qsTr("Chance Meetings")
           contentItem: Text {
               text:parent.text
               anchors.left:parent.right
               width:parent.width
               verticalAlignment: Text.AlignVCenter
               horizontalAlignment: Text.AlignLeft
               color:fontColor
               font.pixelSize: mainView.width * 0.05
           }

           checked: if(cM == 1) {true} else {false}
           onCheckedChanged: {if(settingFlick.visible == true) {if(checked === false) {cM = 0; Scripts.save_setting("CM",0);} else {cM = 1; Scripts.save_setting("CM",1);}
           } }
       }
       Switch {
           id:frequent
           width:thisWindow.width * 0.15
           anchors.left:parent.left
           anchors.leftMargin: thisWindow.width * 0.01
           text:qsTr("Fequent Meetings")
           contentItem: Text {
               text:parent.text
               anchors.left:parent.right
               width:parent.width
               verticalAlignment: Text.AlignVCenter
               horizontalAlignment: Text.AlignLeft
               color:fontColor
               font.pixelSize: mainView.width * 0.05
           }
           checked: if(fM == 1) {true} else {false}
           onCheckedChanged: {if(settingFlick.visible == true) {if(checked === false) {fM = 0; Scripts.save_setting("FM",0);} else {fM =1; Scripts.save_setting("FM",1);}
           } }
       }
       Switch {
           id:missed
           anchors.left:parent.left
           width:thisWindow.width * 0.15
           anchors.leftMargin: thisWindow.width * 0.01
            text:qsTr("Missed Meetings")
            contentItem: Text {
                text:parent.text
                anchors.left:parent.right
                width:parent.width
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                color:fontColor
                font.pixelSize: mainView.width * 0.05
            }
            checked: if(mM == 1) {true} else {false}
            onCheckedChanged: {if(settingFlick.visible == true) {if(checked === false) {mM = 0; Scripts.save_setting("MM",0);} else {mM = 1; Scripts.save_setting("MM",1);}
            } }
       }

       }

  }

       Item {
           width:parent.width
           height:lofColumn.height * 1.1

           Rectangle {
               id:lofback
            anchors.fill:parent
            visible: false
            color:cardcolor
           }

           DropShadow {

              anchors.fill: lofback
              horizontalOffset: 0
              verticalOffset: 3
              radius: 8.0
              samples: 17
              color: "#80000000"
              source: lofback

            }

           Column {
               id:lofColumn
               width:parent.width * 0.98
               anchors.centerIn: parent
               spacing: thisWindow.width * 0.006

       Text {
           text:qsTr("Look and Feel:")
           font.pixelSize: mainView.width * 0.07
           color:fontColorTitle
       }

       Rectangle {
           width: parent.width * 0.98
           height:3
           anchors.horizontalCenter: parent.horizontalCenter

           color:seperatorColor1

       }

       Text {
           text:qsTr("Theming")
           font.pixelSize: mainView.width * 0.05
           color:fontColor
       }

       ListView {
           width:parent.width
           height:mainView.height * 0.6
           orientation: ListView.Horizontal
           snapMode: ListView.SnapOneItem
           clip:true
           spacing: thisWindow.width * 0.02

           model: ListModel {
               id:themelist

               ListElement {
                   name:"default"
                   img:"./img/defaulttheme.png"
               }

               ListElement {
                   name:"Pink"
                   img:"./img/pinktheme.png"
               }

               ListElement {
                   name:"PoP"
                   img:"./img/poptheme.png"
               }
           }

           delegate: Item {
                        width:thisWindow.width
                        height:thisWindow.height * 0.6

                    Image {
                        id:themepreview
                        anchors.horizontalCenter: parent.horizontalCenter
                        //width:parent.width * 0.9
                        height:parent.height * 0.8
                        fillMode: Image.PreserveAspectFit
                        source:img
                    }

                    Text {
                        anchors.top:themepreview.bottom
                        text:name
                        anchors.horizontalCenter: themepreview.horizontalCenter
                        font.pixelSize: thisWindow.width * 0.06
                        color:fontColor
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {theme = index;Scripts.save_setting("theme",index);
                        }
                    }

           }
       }

    }

  }
}

}

 Flickable {
     id:profileFlick
     visible: if(type == "profile") {true} else {false}
     clip:true
     contentHeight:pageColumn.height
    /* anchors {
         top: parent.top
         bottom:parent.bottom
         left:parent.left
         right:parent.right
     } */
     y: pages.height
     height: parent.height - pages.height
     width: parent.width * 0.98
     anchors.horizontalCenter: parent.horizontalCenter

     Column {
         id:pageColumn

        /* anchors {
            top: parent.top
            bottom:parent.bottom
            left:parent.left
             right:parent.right
         } */
         width:parent.width
        // height:parent.height
         spacing:mainView.height * 0.01

         //clip:true

         Item {
             width:parent.width
             height:parent.height * 0.01

        }
        Item {
            width:parent.width
            height:gentitle.height
         Text {
             id:gentitle
             text: qsTr("User Profile")
             anchors.left:parent.left
             font.pixelSize: parent.width * 0.07
             anchors.leftMargin: 4
             width:parent.width * 0.60
             //anchors.verticalCenter: parent.verticalCenter
             color:fontColorTitle

         }
         /*Button {

             text:if(simpleMode == true) {qsTr("Simple")} else {qsTr("Advanced")}
             anchors.right:parent.right
             anchors.verticalCenter: parent.verticalCenter
             onClicked: if(simpleMode == true) {simpleMode = false} else { simpleMode = true}
             background:Rectangle {
                 border.color: highLightColor1
                 //border.width: 1
                // radius: height / 0.5
                      }
         } */
        }

         Rectangle {
             width: parent.width * 0.98
             height:3
             anchors.horizontalCenter: parent.horizontalCenter

             color:seperatorColor1

         }



Item {
    width:parent.width
    //height:thisWindow.height * 0.35
    height:generalarea.height * 1.1


 Rectangle {
    id:generalarea
    clip:true
   // y:cardsava.y + cardsava.height + 10
    //anchors.horizontalCenter: parent.horizontalCenter
    anchors.centerIn: parent
    width:parent.width * 0.98
    height:generalcolumn.height * 1.05
    color:cardcolor

   Column {
       id:generalcolumn
       //y:10
       width:parent.width
      // height:parent.height
       spacing:mainView.width * 0.05
      anchors.centerIn: parent


    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width* 0.98
       // height: parent.height * 0.72
       // clip:true
        spacing: mainView.width * 0.03

    Item {
           id:imagearea
     height:mainView.width * 0.30
     width:mainView.width * 0.30

     Image {
         id:cardsava
         width:parent.width
         height: parent.width
         anchors.verticalCenter: parent.verticalCenter
         anchors.horizontalCenter: parent.horizontalCenter
         //anchors.margins: 4
         visible: false
         fillMode: Image.PreserveAspectCrop
         source: if(cardindex == 0) {if(avimg.search("/9j/4A") != -1) {"data:image/jpeg;base64, "+avimg.replace(/ /g, "+")} else {avimg} }

         Image {

             anchors.fill:parent
             visible: true
             source: "./img/default_avatar.png"
             z:-1
         }

     }

     /*Image {
         id:mask
         anchors.fill:parent
         source:"/graphics/CafeSync.png"
         visible: false

     } */

     OpacityMask {
         id:opmask
          anchors.fill: cardsava
          source: cardsava
          maskSource: mask


      }
    DropShadow {
            anchors.fill: opmask
            horizontalOffset: 0
            verticalOffset: 2
            radius: 5.0
            samples: 17
            color: "#80000000"
            source: opmask
            z:1

        }

    MouseArea {
        anchors.fill: parent
        onClicked:sourceselect = true
    }
    Text {
        anchors.top:cardsava.bottom
        anchors.horizontalCenter:parent.horizontalCenter
        text: qsTr("(tap image to edit)")
        font.pixelSize: mainView.width * 0.04
        color:fontColor
    }


}
    Column {
        //y:20
        width:parent.width * 0.6
       // height:parent.height * 0.8
        spacing:mainView.width * 0.02
        anchors.verticalCenter: parent.verticalCenter

  Text {
        id: nameLabel
       //  width:companyLabel.width
       //anchors.top:onlineLabel.bottom
        anchors.left:parent.left
        //anchors.left:if(layouts.width > units.gu(mobile_vert)){ cardBacking.right} else {parent.left}
       // anchors.leftMargin: 3
        //anchors.top:if(layouts.width > units.gu(mobile_vert)){cardBacking.top} else {cardBacking.bottom}
       // anchors.topMargin:if(layouts.width > units.gu(mobile_vert)){return 0} else {units.gu(.5)}
       //anchors.top:cardBacking.bottom
       // anchors.topMargin: 25
       //anchors.topMargin: 5
        width:parent.width * 0.98
        // text: qsTr("Name:")
        text:""
         font.pixelSize:  (parent.width  - username.length * 1.5) * 0.12
        color:fontColor


       /*  MouseArea {
             anchors.fill: parent
             onClicked: userName.visible = true
         } */

      TextField {
         id: userName
         anchors.left: parent.left
        visible: true
        color:fontColor
        // anchors.leftMargin: 4
         anchors.verticalCenter: parent.verticalCenter
         //anchors.top: parent.top
         text:if(cardindex == 0) {username }
         //verticalAlignment: TextInput.AlignTop
         //  onVisibleChanged: if(visible == true) {focus = true}
           // onFocusChanged: if(focus == false) {visible = false}
         placeholderText: qsTr("User Name")
         font.pixelSize: (parent.width  - username.length * 1.5) * 0.12
        // width:if(layouts.width > units.gu(mobile_vert)){appWindow.width - parent.width - cardBacking.width - units.gu(12)} else {appWindow.width - parent.width - units.gu(1)}
         width:parent.width
         clip:true
         onTextChanged: if(cardindex == 0) {username = userName.text}
     }
 }

  Text {
      id: aliasLabel
        color:fontColor

      anchors.left:parent.left
      anchors.leftMargin: parent.width * 0.10
      //anchors.bottom:avatarBacking.bottom
     // anchors.top:companyLabel.bottom
     // anchors.topMargin: 25
      width:parent.width * 0.85
      //text: qsTr("Position:")
      text:""

      font.pixelSize: (parent.width  - useralias.length * 1.5) * 0.08


     /* MouseArea {
          anchors.fill: parent
          onClicked: userAlias.visible = true
      } */

      TextField {
         id: userAlias
            color:fontColor
          anchors.verticalCenter: parent.verticalCenter
            visible: true
           // onVisibleChanged: if(visible == true) {focus = true}
           // onFocusChanged: if(focus == false) {visible = false}
         anchors.left: parent.left
         //anchors.leftMargin: 4
        // anchors.bottom: parent.bottom
         //anchors.top: parent.top
         placeholderText: qsTr("Job Title")
         font.pixelSize: (parent.width  - useralias.length * 1.5) * 0.08
         width:parent.width
         //width:if(layouts.width > units.gu(mobile_vert)){appWindow.width - parent.width - cardBacking.width - units.gu(12)} else {appWindow.width - parent.width - units.gu(1)}
         text:if(cardindex == 0) {useralias}
         onTextChanged: if(cardindex == 0) {useralias = userAlias.text}
     }


}


  Text {
      id: companyLabel
      anchors.left:parent.left
        horizontalAlignment: Text.AlignRight
    //  anchors.leftMargin: units.gu(.3)
     // anchors.top:nameLabel.bottom
     // anchors.topMargin: 25
        width:parent.width * 0.98
      //text: qsTr("Company:")
      text:''
      font.pixelSize: (parent.width  - usercompany.length * 1.5) * 0.08
        color:fontColor


     /* MouseArea {
          anchors.fill: parent
          onClicked: userCompany.visible = true
      } */

      TextField {
         id: userCompany
         visible: true
         anchors.left: parent.left
         //anchors.leftMargin: 4
          anchors.verticalCenter: parent.verticalCenter
          color:fontColor
         //anchors.top: parent.top
         placeholderText: qsTr("Company Name")
         font.pixelSize: (parent.width  - usercompany.length * 1.5) * 0.08
         width:parent.width
         horizontalAlignment: Text.AlignLeft
        // onVisibleChanged: if(visible == true) {focus = true}
         //   onFocusChanged: if(focus == false) {visible = false}

         //width:if(layouts.width > units.gu(mobile_vert)){appWindow.width - parent.width - cardBacking.width - units.gu(12)} else {appWindow.width - parent.width - units.gu(1)}
         text:if(cardindex == 0) {usercompany}
         onTextChanged: if(cardindex == 0) {usercompany = userCompany.text}
     }
}

    }

    }

    Rectangle {
        width: parent.width * 0.98
        height:3
        anchors.horizontalCenter: parent.horizontalCenter

        //color:seperatorColor1
        color:"black"

    }

    Item {
        width: parent.width
        height:parent.height * 0.12
       // clip:true



 Text {
     id:onlineLabel
     text: qsTr("Share Card")
     font.pixelSize: mainView.width * 0.04
   //  anchors.top:parent.top
    // anchors.topMargin: 10
     anchors.right:parent.right
     anchors.rightMargin: sendCard.width * 1.2
     horizontalAlignment: Text.AlignLeft
     anchors.verticalCenter: parent.verticalCenter
        color:fontColor
     Switch {
        id:sendCard

         anchors.left: onlineLabel.right
         anchors.leftMargin: 4
         anchors.verticalCenter: parent.verticalCenter
         //objectName: "switch_checked"

         checked: if(stf == "true"){ return true } else {return false}
         onCheckedChanged: if(sendCard.checked == true) {stf = "true" } else {stf = "false"}
     }


 }

    }



   }

}

 DropShadow {

    anchors.fill: generalarea
    horizontalOffset: 0
    verticalOffset: 3
    radius: 8.0
    samples: 17
    color: "#80000000"
    source: generalarea
    z:1



}

     }

Text {
     visible: if(simpleMode == false) {true} else {false}
    text: qsTr("Contact")
    anchors.left:parent.left
    color:fontColorTitle
    anchors.leftMargin: 8
    font.pixelSize: parent.width * 0.04

}
Rectangle {
     visible: if(simpleMode == false) {true} else {false}
    width: parent.width * 0.98
    height:parent.width * 0.01
    anchors.horizontalCenter: parent.horizontalCenter

    color:seperatorColor1

}

Item {
    width:parent.width
   // height:contactLabel.y+(contactLabel.height * 2)
    height: contactcolumn.height + 20
    visible: if(simpleMode == false) {true} else {false}

 Rectangle {
    id:contactarea
    clip:true
   // y:cardsava.y + cardsava.height + 10
  //  anchors.top:generalarea.bottom
   //  anchors.topMargin:20
    width:parent.width * 0.98
    height:parent.height
    color:cardcolor
   anchors.centerIn: parent

    Column {
        id:contactcolumn
        //y:20
        width:parent.width
        //height:parent.height
        anchors.centerIn: parent
       // anchors.top:parent.top
       // anchors.topMargin: 10
        spacing: mainView.width * 0.05

        Item {
            width:parent.width
            height:mainView.width * 0.01
        }



  Text {
      id: phoneLabel
        color:fontColor

      anchors.left:parent.left
      anchors.leftMargin: parent.height * 0.04
      //anchors.top:contactLabel.bottom
    //  anchors.topMargin: 25
      text: qsTr("Phone:")
      font.pixelSize: mainView.width * 0.04

      TextField {
         id: userPhone
            color:fontColor
         anchors.left: parent.right
         anchors.leftMargin: 4
         //anchors.bottom: parent.bottom
         anchors.verticalCenter: parent.verticalCenter
         //anchors.top: parent.top

         placeholderText: qsTr("0 555-555-5555")
         font.pixelSize: mainView.width * 0.04
         width:(contactarea.width * 0.96) - phoneLabel.width
        // width:if(layouts.width > units.gu(mobile_vert)){appWindow.width - parent.width - cardBacking.width - units.gu(12)} else {appWindow.width - parent.width - units.gu(1)}
         inputMethodHints: Qt.ImhDialableCharactersOnly
         text:userphone
         onTextChanged: userphone = userPhone.text
     }
  }

  Text {
      id: emailLabel
        color:fontColor

      anchors.left:phoneLabel.left
      //anchors.leftMargin: parent.height * 0.04
     // anchors.top:phoneLabel.bottom
     // anchors.topMargin: 25
      //width:phoneLabel.width

      text: qsTr("Email:")
      font.pixelSize: mainView.width * 0.04
      TextField {
         id: userEmail
         color:fontColor
         anchors.left: parent.right
         anchors.leftMargin: 4
         anchors.verticalCenter: parent.verticalCenter
         //anchors.top: parent.top
         placeholderText: qsTr("johndoe@example.com")
         font.pixelSize: mainView.width * 0.04
         width:(contactarea.width * 0.96) -emailLabel.width

       //  width:if(layouts.width > units.gu(mobile_vert)){appWindow.width - parent.width - cardBacking.width - units.gu(12)} else {appWindow.width - parent.width - units.gu(1)}
         text:useremail
         onTextChanged: useremail = userEmail.text
     }

  }


  Rectangle {
      width: parent.width * 0.98
      height:3
      anchors.horizontalCenter: parent.horizontalCenter

      //color:seperatorColor1
      color:"black"

  }

  Text {
      id:contactLabel
      text: qsTr("Share Contact Info")
      font.pointSize: mainView.width * 0.04
      //font.bold: true
      horizontalAlignment: Text.AlignLeft
     // anchors.top:parent.top
     // anchors.topMargin: 10
      anchors.right:parent.right
      anchors.rightMargin:  sendContact.width * 1.2
        color:fontColor
      Switch {
         id:sendContact

          anchors.left: contactLabel.right
          anchors.leftMargin: 5
          anchors.verticalCenter: parent.verticalCenter
          objectName: "switch_checked"

          checked:if(ctf == "true"){ return true } else { return false}
          onCheckedChanged: if(sendContact.checked == true) {ctf = "true" } else {ctf = "false"}
      }
  }



    }


}


DropShadow {

    anchors.fill: contactarea
    horizontalOffset: 0
    verticalOffset: 3
    radius: 8.0
    samples: 17
    color: "#80000000"
    source: contactarea
    z:1



}


}

Text {
 id: profileSettingLabel
 //x: units.gu(1)
// y: 208
 anchors.left:parent.left
 anchors.leftMargin: 8
 //anchors.top:contactarea.bottom//avatarBacking.bottom
 //anchors.topMargin: 10
 text: qsTr("Info")
 style: Text.Normal
 font.pixelSize: parent.width * 0.04
 color:fontColorTitle
}

Rectangle {
    width: parent.width * 0.98
    height:3
    anchors.horizontalCenter: parent.horizontalCenter

   color:seperatorColor1
    //color:"black"

}

Item {
    width:parent.width
    height: personalMotto.height + (catbutton.height *3.5) + 20

 Rectangle {
 id: rectangle1

    color:cardcolor
 anchors.left:parent.left
 anchors.leftMargin:1
// anchors.top:profileSettingLabel.bottom
 // anchors.topMargin:1

 //height: pageColumn.height / 4

 height:parent.height
 anchors.right:parent.right
 anchors.rightMargin:1



 clip:true

 //radius: 6
 //z: -1
// border.width: 1


      Column {

          anchors.top:parent.top
          anchors.topMargin:10
          anchors.left:parent.left
          anchors.leftMargin: 10
          anchors.bottom: parent.bottom
          anchors.bottomMargin: 10
          anchors.right:parent.right
          anchors.rightMargin:10

          //clip: true
          spacing: parent.height * 0.02

          ListView {
              width:rectangle1.width
              height:thisWindow.height * 0.05
              orientation: ListView.Horizontal
              spacing: 10
              clip:true
              visible: if(simpleMode == false) {true} else {false}

              model: ListModel {
                  ListElement {
                      name: qsTr("About")
                  }
                  ListElement {
                      name: qsTr("Skills")
                  }
                  ListElement {
                      name: qsTr("School")
                  }
                  ListElement {
                      name: qsTr("Work Expr.")
                  }
              }

              delegate: Item {
                  width:rectangle1.width / 5
                  height:parent.height
                  clip:true
                  Rectangle {
                      anchors.fill: parent
                      color:if(profilesection == index) {highLightColor1} else {cardcolor}
                  }
                  Text {
                      anchors.centerIn: parent
                      text: name
                      font.pixelSize: (parent.height * 0.5)
                      color:fontColor
                  }

                  MouseArea {
                      anchors.fill:parent
                      onClicked: profilesection = index
                  }
              }



          }

          Item {
              id:profileRow
              width: parent.width
              height: thisWindow.height / 2.4
              visible: if(profilesection == 0) {true} else {false}



                  Rectangle {
                      anchors.centerIn:personalMotto
                      width:profileRow.width
                      height:personalMotto.height * 1.02
                      border.color:"gray"
                      border.width: 1
                      color:backgroundColor

                  }

              Text {
                  anchors.horizontalCenter: parent.horizontalCenter
                  anchors.top:parent.top
                  anchors.topMargin: thisWindow.height * 0.005
                  wrapMode: Text.WordWrap
                  id:personalMotto
                  width:profileRow.width * 0.98
                  height:profileRow.height * 0.98
                  text:if(yourabout == ""){usermotto.split(";::;")[0].replace(/;#x2c;/g,",").replace(/;#x2b;/g,"+")} else {yourabout.replace(/;#x2c;/g,",").replace(/;#x2b;/g,"+")}
                  clip:true
                    color:fontColor
                  Image {
                      anchors.right:parent.right
                      anchors.bottom:parent.bottom
                      source:"./icons/edit-text.svg"
                      height:parent.height * 0.06
                      width:parent.height * 0.06

                  }

                  MouseArea {
                      anchors.fill:parent
                      onClicked: {enterProfile.state = "Active";
                                        enterProfile.type = "about";
                                if(yourabout == ""){
                                    enterProfile.aboutme = usermotto.split(";::;")[0].replace(/;#x2c;/g,",").replace(/;#x2b;/g,"+");
                                } else {
                                    enterProfile.aboutme = yourabout.replace(/;#x2c;/g,",").replace(/;#x2b;/g,"+");
                                    }
                      }
                  }

                 }

             Text {
                 font.pixelSize: mainView.widtht * 0.03
                 text:qsTr("Category: ")
                 anchors.top:profileRow.bottom
                 anchors.topMargin:  mainView.width * 0.03
                 anchors.right:parent.right
                 anchors.rightMargin: catbutton.width * 1.1
                    color:fontColor
                Rectangle {
                       id:catbutton
                    width:if(cardindex == 0) {10*usercat.length + catText.width}
                    height:parent.height * 1.1

                    anchors.left:parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    //border.color:"black"
                    radius: 3
                    color:highLightColor1
                    clip:true

                 Text {
                        id:catText
                     //anchors.left:parent.right
                        anchors.centerIn: parent
                     font.pixelSize:mainView.width * 0.05
                    // anchors.verticalCenter: parent.verticalCenter
                     text:if(cardindex == 0) { if(usercat.length < 1) {qsTr("Select Category")} else {usercat}}
                     //onTextChanged: usercat = text;
                     color:fontColor
                    }

                     MouseArea {
                         anchors.fill:parent
                         onClicked: catmenu.state = "Active"
                     }
                 }

                DropShadow {

                    anchors.fill: catbutton
                    horizontalOffset: 0
                    verticalOffset: 3
                    radius: 8.0
                    samples: 17
                    color: "#80000000"
                    source: catbutton
                    z:1



                }


             }


          }



          Item {
              id:exprRow
              width: parent.width
              height: thisWindow.height / 2.15
              visible: if(profilesection == 1) {true} else {false}
              //clip:true
              onVisibleChanged: if(visible == true) {Scripts.skillListings()}

              Rectangle {
                  anchors.centerIn:exprlist
                  width:exprRow.width
                  height:exprlist.height * 1.02
                  border.color:"gray"
                  border.width: 1
                  color:backgroundColor

              }

              ListView {
                  id:exprlist
                  anchors.horizontalCenter: parent.horizontalCenter
                  //anchors.verticalCenter: parent.verticalCenter
                  width:parent.width * 0.98
                  height:parent.height * 0.90
                  clip:true
                  spacing:thisWindow.height * 0.02

                  model: skills

                  delegate: Item {

                            width:parent.width
                            //height:thisWindow.height * 0.12
                            height:editbutton.y + editbutton.height

                            Rectangle {
                                id:backing
                                color:cardcolor
                                anchors.fill: parent
                                visible: false

                                Column {

                                    width:parent.width
                                    height:parent.height
                                    spacing:thisWindow.height * 0.01

                                Text {
                                    text:name.substring(1,name.length-1).replace(/;#x2c;/g,",").replace(/;#x2b;/g,"+")
                                    color:fontColor

                                    anchors.left:parent.left
                                    anchors.leftMargin: parent.height * 0.1
                                    width:parent.width
                                    font.pixelSize: (thisWindow.height * 0.04)


                                    Text {
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.right:parent.right
                                        anchors.rightMargin: checked.height * 2
                                        text:"Certified: "
                                        font.pixelSize: parent.height * 0.5
                                        visible:if(certified == "'false'") {false} else {true}
                                        color:fontColor
                                        Image {
                                            id:checked
                                            anchors.left:parent.right
                                            anchors.verticalCenter: parent.verticalCenter
                                            source:"./icons/check.svg"
                                            height:parent.height
                                            width:parent.height
                                        }
                                    }
                                }

                                Rectangle {
                                    color:seperatorColor1
                                    width:parent.width
                                    height: 3

                                }

                                Text {
                                    anchors.left:parent.left
                                    anchors.leftMargin:thisWindow.height * 0.01
                                    width:parent.width*0.98
                                    wrapMode: Text.WordWrap
                                    text:"Discription:\n"+discription.substring(1,discription.length-1).replace(/;#x2c;/g,",").replace(/;#x2b;/g,"+")
                                    color:fontColor
                                }

                                Image {
                                    id:editbutton
                                    anchors.right:parent.right
                                    anchors.rightMargin: parent.width * 0.01
                                    source:"./icons/edit-text.svg"
                                    width:thisWindow.height * 0.02
                                    height:thisWindow.height * 0.02
                                }

                                }
                            }

                            DropShadow {

                                anchors.fill: backing
                                horizontalOffset: 0
                                verticalOffset: 3
                                radius: 8.0
                                samples: 17
                                color: "#80000000"
                                source: backing
                               // z:1



                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    enterProfile.state = "Active"
                                    enterProfile.type = "skill"
                                    enterProfile.listindex = index+1
                                }
                            }

                  }






              }

              Rectangle {
                  id:addskill
                  anchors.bottom:parent.bottom
                  anchors.right:parent.right
                  anchors.margins: parent.height * 0.01
                  color:highLightColor1
                  width:parent.height * 0.3
                  height:parent.height * 0.08
                  radius:5

                  Text {
                      anchors.centerIn: parent
                      text:qsTr("Add Skill")
                      font.pixelSize: (parent.height * 0.5)
                      color:fontColor
                  }

                  MouseArea {
                      anchors.fill:parent
                      onClicked:{
                                    enterProfile.state = "Active"
                                    enterProfile.type = "skill"
                                    enterProfile.listindex = -1
                                }
                  }
              }

              DropShadow {

                  anchors.fill: addskill
                  horizontalOffset: 0
                  verticalOffset: 3
                  radius: 8.0
                  samples: 17
                  color: "#80000000"
                  source: addskill
                 // z:1



              }



          }

          Item {
              id:schoolRow
              width: parent.width
              height: thisWindow.height / 2.15
              visible: if(profilesection == 2) {true} else {false}
              //clip:true
              onVisibleChanged: if(visible == true) {Scripts.schoolListings()}

              Rectangle {
                  anchors.centerIn:schoollist
                  width:schoolRow.width
                  height:schoollist.height* 1.02
                  border.color:"gray"
                  border.width: 1
                  color:backgroundColor

              }


              ListView {
                  id:schoollist
                  anchors.horizontalCenter: parent.horizontalCenter
                  //anchors.verticalCenter: parent.verticalCenter
                  width:parent.width * 0.98
                  height:parent.height * 0.90
                  clip:true
                  spacing:thisWindow.height * 0.02

                  model: school

                  delegate: Item {

                      width:parent.width
                      //height:thisWindow.height * 0.12
                      height:editbutton1.y + editbutton1.height

                      Rectangle {
                          id:backing1
                          color:cardcolor
                          anchors.fill: parent
                          visible: false

                          Column {

                              width:parent.width
                              height:parent.height
                              spacing:thisWindow.height * 0.01

                          Text {
                              text:name.substring(1,name.length-1).replace(/;#x2c;/g,",").replace(/;#x2b;/g,"+")
                                color:fontColor

                              anchors.left:parent.left
                              anchors.leftMargin: parent.height * 0.1
                              width:parent.width
                              font.pixelSize: (thisWindow.height * 0.04)


                              Text {
                                  anchors.verticalCenter: parent.verticalCenter
                                  anchors.right:parent.right
                                  anchors.rightMargin: checked1.height * 2
                                  text:"Graduated: "
                                  font.pixelSize: parent.height * 0.5
                                  visible: if(graduated == "'false'") {false} else {true}
                                  color:fontColor
                                  Image {
                                      id:checked1
                                      anchors.left:parent.right
                                      anchors.verticalCenter: parent.verticalCenter
                                      source:"./icons/check.svg"
                                      height:parent.height
                                      width:parent.height
                                  }
                              }
                          }

                          Rectangle {
                              color:seperatorColor1
                              width:parent.width
                              height: 3

                          }

                          Text {
                              anchors.left:parent.left
                              anchors.leftMargin:thisWindow.height * 0.01
                              width:parent.width*0.98
                              wrapMode: Text.WordWrap
                              text:"Discription:\n"+discription.substring(1,discription.length-1).replace(/;#x2c;/g,",").replace(/;#x2b;/g,"+")
                                color:fontColor
                          }

                          Image {
                              id:editbutton1
                              anchors.right:parent.right
                              anchors.rightMargin: parent.width * 0.01
                              source:"./icons/edit-text.svg"
                              width:thisWindow.height * 0.02
                              height:thisWindow.height * 0.02
                          }

                          }
                      }

                      DropShadow {

                          anchors.fill: backing1
                          horizontalOffset: 0
                          verticalOffset: 3
                          radius: 8.0
                          samples: 17
                          color: "#80000000"
                          source: backing1
                         // z:1



                      }

                      MouseArea {
                          anchors.fill: parent
                          onClicked: {
                                        enterProfile.state = "Active"
                                        enterProfile.type = "school"
                                        enterProfile.listindex = index+1
                                        }
                      }

            }






              }

              Rectangle {
                  id:addschool
                  anchors.bottom:parent.bottom
                  anchors.right:parent.right
                  anchors.margins: parent.height * 0.01
                  color:highLightColor1
                  width:parent.height * 0.3
                  height:parent.height * 0.08
                  radius:5
                 // visible: false

                  Text {
                      anchors.centerIn: parent
                      text:qsTr("Add School")
                      font.pixelSize: (parent.height * 0.5)
                      color:fontColor
                  }


                  MouseArea {
                      anchors.fill:parent
                      onClicked:{
                                 enterProfile.state = "Active"
                                 enterProfile.type = "school"
                                 enterProfile.listindex = -1
                                }
                  }
              }
              DropShadow {

                  anchors.fill: addschool
                  horizontalOffset: 0
                  verticalOffset: 3
                  radius: 8.0
                  samples: 17
                  color: "#80000000"
                  source: addschool
                 // z:1



              }


          }

          Item {
              id:workRow
              width: parent.width
              height: thisWindow.height / 2.15
              visible: if(profilesection == 3) {true} else {false}
              //clip:true
              onVisibleChanged: if(visible == true) {Scripts.workListings()}

              Rectangle {
                  anchors.centerIn:worklist
                  width:workRow.width
                  height:worklist.height * 1.02
                  border.color:"gray"
                  border.width: 1
                  color:backgroundColor

              }

              ListView {
                  id:worklist
                  anchors.horizontalCenter: parent.horizontalCenter
                 // anchors.verticalCenter: parent.verticalCenter
                  width:parent.width * 0.98
                  height:parent.height * 0.90
                  clip:true
                  spacing:thisWindow.height * 0.02

                  model: workexpr

                  delegate: Item {

                      width:parent.width
                      //height:thisWindow.height * 0.12
                      height:editbutton2.y + editbutton2.height

                      Rectangle {
                          id:backing2
                          color:cardcolor
                          anchors.fill: parent
                          visible: false

                          Column {

                              width:parent.width
                              height:parent.height
                              spacing:thisWindow.height * 0.01

                          Text {
                              text:name.substring(1,name.length-1).replace(/;#x2c;/g,",").replace(/;#x2b;/g,"+")
                                color:fontColor

                              anchors.left:parent.left
                              anchors.leftMargin: parent.height * 0.1
                              width:parent.width
                              font.pixelSize: (thisWindow.height * 0.04)


                              Text {
                                  anchors.verticalCenter: parent.verticalCenter
                                  anchors.right:parent.right
                                  anchors.rightMargin: checked2.height * 2
                                  text:"Currently Working: "
                                  font.pixelSize: parent.height * 0.5
                                  visible: if(currentlyEmployeed == "'false'") {false} else {true}
                                  color:fontColor

                                  Image {
                                      id:checked2
                                      anchors.left:parent.right
                                      anchors.verticalCenter: parent.verticalCenter
                                      source:"./icons/check.svg"
                                      height:parent.height
                                      width:parent.height
                                  }
                              }
                          }

                          Rectangle {
                              color:seperatorColor1
                              width:parent.width
                              height: 3

                          }

                          Text {
                              anchors.left:parent.left
                              anchors.leftMargin:thisWindow.height * 0.01
                              width:parent.width*0.98
                              wrapMode: Text.WordWrap
                              text:"Discription:\n"+discription.substring(1,discription.length-1).replace(/;#x2c;/g,",").replace(/;#x2b;/g,"+")
                              color:fontColor
                          }

                          Image {
                              id:editbutton2
                              anchors.right:parent.right
                              anchors.rightMargin: parent.width * 0.01
                              source:"./icons/edit-text.svg"
                              width:thisWindow.height * 0.02
                              height:thisWindow.height * 0.02
                          }

                          }
                      }

                      DropShadow {

                          anchors.fill: backing2
                          horizontalOffset: 0
                          verticalOffset: 3
                          radius: 8.0
                          samples: 17
                          color: "#80000000"
                          source: backing2
                         // z:1



                      }

                      MouseArea {
                          anchors.fill: parent
                          onClicked: {
                                      enterProfile.state = "Active"
                                      enterProfile.type = "work"
                                      enterProfile.listindex = index+1
                                    }
                      }

            }

              }

              Rectangle {
                  id:addwork
                  anchors.bottom:parent.bottom
                  anchors.right:parent.right
                  anchors.margins: parent.height * 0.01
                  color:highLightColor1
                  width:parent.height * 0.3
                  height:parent.height * 0.08
                  radius:5

                  Text {
                      anchors.centerIn: parent
                      text:qsTr("Add Work Expr.")
                      font.pixelSize: (parent.height * 0.5)
                      color:fontColor
                  }

                  MouseArea {
                      anchors.fill:parent
                      onClicked: {
                          enterProfile.state = "Active"
                          enterProfile.type = "work"
                          enterProfile.listindex = -1
                      }
                  }
              }

              DropShadow {

                  anchors.fill: addwork
                  horizontalOffset: 0
                  verticalOffset: 3
                  radius: 8.0
                  samples: 17
                  color: "#80000000"
                  source: addwork
                 // z:1



              }


          }


      }
}



 DropShadow {

    anchors.fill: rectangle1
    horizontalOffset: 0
    verticalOffset: 3
    radius: 8.0
    samples: 17
    color: "#80000000"
    source: rectangle1
    z:1



}

}

Text {
 //id: profileSettingLabel
 //x: units.gu(1)
// y: 208
 anchors.left:parent.left
 anchors.leftMargin: 8
 //anchors.top:contactarea.bottom//avatarBacking.bottom
 //anchors.topMargin: 10
 text: qsTr("Social Networks")
 style: Text.Normal
 font.pixelSize: parent.width * 0.04
 color:fontColorTitle
}

Rectangle {
    width: parent.width * 0.98
    height:3
    anchors.horizontalCenter: parent.horizontalCenter

   color:seperatorColor1
    //color:"black"

}

Item {
   //
    height:(parent.height * 0.01) + servicelist.height
    width:parent.width

Rectangle {
    id:socialNetworks
    color:cardcolor
    anchors.fill: parent
   // width:parent.width
   // height:servicelist.height
        clip:true


                    ListView {
                        id:servicelist
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width:parent.width * 0.98
                        height:contentHeight
                        //clip:true
                        boundsBehavior:Flickable.StopAtBounds
                        spacing:thisWindow.height * 0.02

                        model: socialcontracts

                        delegate: SocialOpt {
                                        id:soItem
                                width:parent.width * 0.95
                                height:thisWindow.height * 0.08

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked:{if(type === 2) {sConnect.state = "Active";
                                                                sConnect.service = "";
                                                                sConnect.type = "intergration";
                                                                sConnect.po = po;
                                                switch (po) {
                                                    case 0: sConnect.useraccount = usermain;break;
                                                    case 1: sConnect.useraccount = website1;break;
                                                    case 2: sConnect.useraccount = website2;break;
                                                    case 3: sConnect.useraccount = website3;break;
                                                    case 4: sConnect.useraccount = website4;break;
                                                        }
                                                }
                                            }
                                        }

                              /*  Rectangle {
                                    anchors.centerIn: deleteit
                                    width:deleteit.width * 1.2
                                    height:deleteit.height * 1.2
                                    radius:width / 2
                                    color:"gray"
                                } */

                                Rectangle {
                                    anchors.right:deleteit.left
                                    anchors.rightMargin: parent.height * 0.2
                                    anchors.verticalCenter: parent.verticalCenter
                                    height:parent.height * 0.95
                                    width:3
                                    color:if(parent.bgColor === cardcolor && type !== 2) {"gray"} else {"white"}
                                }

                                Item {
                                    id: deleteit
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.right: parent.right
                                    anchors.rightMargin: parent.height * 0.2
                                    width:parent.height * 0.40
                                    height:parent.height * 0.40
                                    z:3

                                Image {
                                    id:del_icon
                                    visible: false
                                    source:"./icons/close.svg"
                                     anchors.fill:parent  

                                }
                                ColorOverlay {
                                       anchors.fill: del_icon
                                       source: del_icon
                                       color: if(soItem.bgColor === cardcolor && type !== 2) {fontColor} else {"white"}
                                   }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked:{switch (po) {
                                                    case 0: usermain = "";Scripts.fillsites();break;
                                                    case 1: website1 = "";Scripts.fillsites();break;
                                                    case 2: website2 = "";Scripts.fillsites();break;
                                                    case 3: website3 = "";Scripts.fillsites();break;
                                                    case 4: website4 = "";Scripts.fillsites();break;
                                                        }
                                                }
                                        }

                                }

                        }






                    }




}

    DropShadow {

       anchors.fill: socialNetworks
       horizontalOffset: 0
       verticalOffset: 3
       radius: 8.0
       samples: 17
       color: "#80000000"
       source: socialNetworks
       z:1



   }

}


 Text {
     anchors.left:parent.left
     anchors.leftMargin: 8
    // anchors.top:rectangle1.bottom
    // anchors.topMargin:8
     text: qsTr("Misc.")
     font.pixelSize: parent.width * 0.04
     id:misc_title
     color:fontColorTitle
 }

 Rectangle {
     width: parent.width * 0.98
     height:3
     anchors.horizontalCenter: parent.horizontalCenter

    color:seperatorColor1
     //color:"black"

 }

 Item {
     width:parent.width
     height:parent.height / 12


  Rectangle {
     id:miscborder
     anchors.horizontalCenter: parent.horizontalCenter
    // anchors.top:misc_title.bottom
   //  anchors.topMargin:8
     width:parent.width * 0.99
     height: parent.height
     //radius:6
     //border.width:1
    // border.color:"black"
     color:cardcolor

 Column {
     anchors.fill:parent
     anchors.margins: 10

     Item {
         id:about
         height:parent.height / 3
         width:parent.width
         Text {
             anchors.verticalCenter: parent.verticalCenter
             text: "About"
             font.pixelSize: parent.height * 0.4
             color:fontColor
         }

         MouseArea {
             anchors.fill: parent
             //onPressed:aboutflash.state = "Active"
            // onReleased:aboutflash.state = "InActive"
             onClicked:aboutscreen.state = "Active"
         }

     }

     Item {
         id:credits
         height:parent.height / 3
         width:parent.width
         Text {
             anchors.verticalCenter: parent.verticalCenter
             text: "Credits"
             font.pixelSize: parent.height * 0.4
             color:fontColor
         }

         MouseArea {
             anchors.fill: parent
             onPressed:creditsflash.state = "Active"
             onReleased:creditsflash.state = "InActive"
         }

     }

     Item {
         id:contribute
         height:parent.height / 3
         width:parent.width
         Text {
             anchors.verticalCenter: parent.verticalCenter
             text: "Contribute"
             font.pixelSize: parent.height * 0.4
             color:fontColor
         }


         MouseArea {
             anchors.fill: parent
             onPressed:conflash.state = "Active"
             onReleased:conflash.state = "InActive"
         }

     }


 }

 }


  DropShadow {

     anchors.fill: miscborder
     horizontalOffset: 0
     verticalOffset: 3
     radius: 8.0
     samples: 17
     color: "#80000000"
     source: miscborder
     z:1



 }

 }

     }
    }


 Menus {
     id:catmenu
     //anchors.centerIn: parent
     x:0
     y:topBar.height
     width:parent.width
    // y:topBar.height
     height:parent.height
     state:"InActive"
     title:"Category Select"


 }

 SlideShow {
     id:aboutscreen
     y:0
     width: parent.width
     height: parent.height
     state:"InActive"
     maintitle:"About"
     //anchors.top: parent.top


 }

 SourceSelection {
        id:sourceSelector
        width:parent.width
        height:parent.height
        state:"InActive"

 }


 ListModel {
     id:socialcontracts

 }

 ListModel {
     id:skills



 }

 ListModel {
     id:workexpr



 }

 ListModel {
     id:school

 }

 Notification {
     id:savedReport

     anchors.centerIn: parent
     width:parent.width * 0.80
     height:parent.height * 0.20
     themessage: qsTr("Settings Saved")
     delay:3
     visible: false


 }

 ProfileEntry {
     id:enterProfile
     //y:-thisWindow.y
     y:-topBar.height
     width:mainView.width
     height:mainView.height
     state:"InActive"
     listindex: -1
     onStateChanged: if(state == "InActive") { Scripts.skillListings()
                                                Scripts.schoolListings()
                                                Scripts.workListings()
                                                topBar.visible = true
                     } else {topBar.visible = false}

 }


 }



