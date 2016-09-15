Imports System
Imports System.Threading
Imports System.IO.Ports
Imports System.ComponentModel

Public Class Form1

    Dim myPort As Array                                     ' Stores port names
    Delegate Sub SetTextCallback(ByVal [text] As String)    '     

    Private Sub Form1_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        myPort = IO.Ports.SerialPort.GetPortNames()
        portComboBox.Items.AddRange(myPort)
        writeButton.Enabled = False
    End Sub

    Private Sub closeButton_Click(sender As Object, e As EventArgs) Handles closeButton.Click
        SerialPort1.Close()
        initButton.Enabled = True
        writeButton.Enabled = False
        closeButton.Enabled = False
        Me.Close()
    End Sub

    Private Sub initButton_Click(sender As Object, e As EventArgs) Handles initButton.Click
        SerialPort1.PortName = portComboBox.Text
        SerialPort1.BaudRate = baudComboBox.Text
        SerialPort1.Open()

        initButton.Enabled = False
        writeButton.Enabled = True
        closeButton.Enabled = True
    End Sub

    Private Sub writeButton_Click(sender As Object, e As EventArgs) Handles writeButton.Click
        SerialPort1.Write(inputTextBox.Text & vbCr)
    End Sub

    Private Sub SerialPort1_DataReceived(sender As Object, e As SerialDataReceivedEventArgs) Handles SerialPort1.DataReceived
        ReceivedText(SerialPort1.ReadExisting())
    End Sub

    Private Sub ReceivedText(ByVal [text] As String)
        If Me.outputTextBox.InvokeRequired Then
            Dim x As New SetTextCallback(AddressOf ReceivedText)
            Me.Invoke(x, New Object() {(text)})
        Else
            Me.outputTextBox.Text &= [text]
        End If
    End Sub
End Class
