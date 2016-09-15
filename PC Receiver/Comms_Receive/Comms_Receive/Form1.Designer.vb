<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Form1
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Me.initButton = New System.Windows.Forms.Button()
        Me.closeButton = New System.Windows.Forms.Button()
        Me.writeButton = New System.Windows.Forms.Button()
        Me.inputTextBox = New System.Windows.Forms.RichTextBox()
        Me.outputTextBox = New System.Windows.Forms.RichTextBox()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.portComboBox = New System.Windows.Forms.ComboBox()
        Me.baudComboBox = New System.Windows.Forms.ComboBox()
        Me.SerialPort1 = New System.IO.Ports.SerialPort(Me.components)
        Me.SuspendLayout()
        '
        'initButton
        '
        Me.initButton.Location = New System.Drawing.Point(452, 55)
        Me.initButton.Name = "initButton"
        Me.initButton.Size = New System.Drawing.Size(75, 23)
        Me.initButton.TabIndex = 0
        Me.initButton.Text = "Init Port"
        Me.initButton.UseVisualStyleBackColor = True
        '
        'closeButton
        '
        Me.closeButton.Location = New System.Drawing.Point(452, 237)
        Me.closeButton.Name = "closeButton"
        Me.closeButton.Size = New System.Drawing.Size(75, 23)
        Me.closeButton.TabIndex = 1
        Me.closeButton.Text = "Close"
        Me.closeButton.UseVisualStyleBackColor = True
        '
        'writeButton
        '
        Me.writeButton.Location = New System.Drawing.Point(265, 51)
        Me.writeButton.Name = "writeButton"
        Me.writeButton.Size = New System.Drawing.Size(66, 25)
        Me.writeButton.TabIndex = 2
        Me.writeButton.Text = "Write"
        Me.writeButton.UseVisualStyleBackColor = True
        '
        'inputTextBox
        '
        Me.inputTextBox.Location = New System.Drawing.Point(12, 50)
        Me.inputTextBox.Name = "inputTextBox"
        Me.inputTextBox.Size = New System.Drawing.Size(247, 72)
        Me.inputTextBox.TabIndex = 3
        Me.inputTextBox.Text = ""
        '
        'outputTextBox
        '
        Me.outputTextBox.Location = New System.Drawing.Point(12, 181)
        Me.outputTextBox.Name = "outputTextBox"
        Me.outputTextBox.Size = New System.Drawing.Size(247, 79)
        Me.outputTextBox.TabIndex = 4
        Me.outputTextBox.Text = ""
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(12, 34)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(31, 13)
        Me.Label1.TabIndex = 5
        Me.Label1.Text = "Input"
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(12, 165)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(39, 13)
        Me.Label2.TabIndex = 6
        Me.Label2.Text = "Output"
        '
        'portComboBox
        '
        Me.portComboBox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.portComboBox.FormattingEnabled = True
        Me.portComboBox.Location = New System.Drawing.Point(349, 55)
        Me.portComboBox.Name = "portComboBox"
        Me.portComboBox.Size = New System.Drawing.Size(97, 21)
        Me.portComboBox.TabIndex = 7
        '
        'baudComboBox
        '
        Me.baudComboBox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.baudComboBox.FormattingEnabled = True
        Me.baudComboBox.Items.AddRange(New Object() {"9600", "115200"})
        Me.baudComboBox.Location = New System.Drawing.Point(349, 99)
        Me.baudComboBox.Name = "baudComboBox"
        Me.baudComboBox.Size = New System.Drawing.Size(97, 21)
        Me.baudComboBox.TabIndex = 8
        '
        'SerialPort1
        '
        '
        'Form1
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.ActiveBorder
        Me.ClientSize = New System.Drawing.Size(541, 291)
        Me.Controls.Add(Me.baudComboBox)
        Me.Controls.Add(Me.portComboBox)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.outputTextBox)
        Me.Controls.Add(Me.inputTextBox)
        Me.Controls.Add(Me.writeButton)
        Me.Controls.Add(Me.closeButton)
        Me.Controls.Add(Me.initButton)
        Me.Name = "Form1"
        Me.Text = "Form1"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub

    Friend WithEvents initButton As Button
    Friend WithEvents closeButton As Button
    Friend WithEvents writeButton As Button
    Friend WithEvents inputTextBox As RichTextBox
    Friend WithEvents outputTextBox As RichTextBox
    Friend WithEvents Label1 As Label
    Friend WithEvents Label2 As Label
    Friend WithEvents portComboBox As ComboBox
    Friend WithEvents baudComboBox As ComboBox
    Friend WithEvents SerialPort1 As IO.Ports.SerialPort
End Class
