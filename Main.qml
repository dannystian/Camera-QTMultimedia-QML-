import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12
import QtMultimedia

ApplicationWindow
{
    visible: true
    width: 1200
    height: 760
    title: "Camera"

    
    Rectangle
    {
        anchors.fill: parent
        color: "#000000"

        RowLayout
        {
            anchors.fill: parent
            spacing: 0

            // Column 1 (80% width)
            ColumnLayout
            {
                Layout.preferredWidth: parent.width * 0.8
                Layout.fillHeight: true
                spacing: 0  // No spacing between rows

                
                Item
                {
                    width: 1100
                    height: 500
                    MediaDevices
                    {
                        id: mediaDevices
                    }

                    
                    CaptureSession
                    {
                        id: captureSession
                        camera: Camera
                        {
                            id: camera
                            cameraDevice: mediaDevices.defaultVideoInput
                            active: true 
                        }
                        videoOutput: videoOutput
                    }

                    
                    VideoOutput
                    {
                        id: videoOutput
                        anchors.fill: parent
                        fillMode: VideoOutput.PreserveAspectFit
                    }

                   
                    Rectangle
                    {
                        anchors.fill: parent
                        color: "black"
                        visible: mediaDevices.videoInputs.length === 0 || camera.error !== Camera.NoError
                        Label
                        {
                            anchors.centerIn: parent
                            text:
                            {
                                if (mediaDevices.videoInputs.length === 0) return "No camera detected";
                                if (camera.error !== Camera.NoError) return "Camera error: " + camera.errorString;
                                return "";
                            }
                            color: "white"
                            font.pixelSize: 16
                        }
                    }
                }
            }
        }
    }
}
