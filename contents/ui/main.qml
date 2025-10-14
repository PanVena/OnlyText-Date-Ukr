import QtQuick 2.12
import QtQuick.Controls 2.15
import org.kde.plasma.plasmoid
import org.kde.kirigami as Kirigami
import org.kde.plasma.core as PlasmaCore
import "js/Texts.js" as Texts

PlasmoidItem {
    id: root
    width: 450
    height: 150
    preferredRepresentation: fullRepresentation
    Plasmoid.backgroundHints: PlasmaCore.Types.ConfigurableBackground

    property color widgetColor: "white"
    property string codelang: ((Qt.locale().name)[0]+(Qt.locale().name)[1])

    FontLoader {
        id: klik
        source: "../fonts/Z003-MediumItalic.otf"
    }
    FontLoader {
        id: milestone
        source: "../fonts/Z003-MediumItalic.otf"
    }

    fullRepresentation: Column {
        id: wrapper
        width: Math.min(parent.width, parent.height * 3)
        height: width / 3
        anchors.centerIn: parent

        Text {
            id: day
            width: parent.width
            height: parent.height * 0.7
            text: Texts.getDayWeekText(codelang, (new Date()).getDay())
            font.pixelSize: height * 0.8
            color: widgetColor
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: milestone.name
            font.capitalization: Font.Capitalize
        }

        Text {
            id: dayOfMonth
            width: parent.width
            height: parent.height * 0.3
            text: Texts.TextNumbers(codelang, Qt.formatDateTime(new Date(), "d"))
            font.pixelSize: height * 0.50
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: klik.name
            color: widgetColor

        }

        Text {
            id: month
            width: parent.width
            height: parent.height * 0.3
            text: Texts.getMonthText(codelang, Qt.formatDateTime(new Date(), "M")-1).toLowerCase()
            font.pixelSize: height * 0.50
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: klik.name
            color: widgetColor
        }
        Timer {
            id: timer
            interval: 5000
            running: true
            repeat: true
            onTriggered: {
                month.text = Texts.getMonthText(codelang, Qt.formatDateTime(new Date(), "M")-1).toLowerCase()
                dayOfMonth.text = Texts.TextNumbers(codelang, Qt.formatDateTime(new Date(), "d"))
                day.text = Texts.getDayWeekText(codelang, (new Date()).getDay())
            }
        }
    }
}
