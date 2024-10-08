#================================================
# Window Functions
# Minimize Command and PowerShell Windows
#================================================
$Script:showWindowAsync = Add-Type -MemberDefinition @"
[DllImport("user32.dll")]
public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);
"@ -Name "Win32ShowWindowAsync" -Namespace Win32Functions -PassThru
function Hide-CmdWindow() {
    $CMDProcess = Get-Process -Name cmd -ErrorAction Ignore
    foreach ($Item in $CMDProcess) {
        $null = $showWindowAsync::ShowWindowAsync((Get-Process -Id $Item.id).MainWindowHandle, 2)
    }
}
function Hide-PowershellWindow() {
    $null = $showWindowAsync::ShowWindowAsync((Get-Process -Id $pid).MainWindowHandle, 2)
}
function Show-PowershellWindow() {
    $null = $showWindowAsync::ShowWindowAsync((Get-Process -Id $pid).MainWindowHandle, 10)
}
Hide-CmdWindow
Hide-PowershellWindow

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Computer Profile'
$form.Size = New-Object System.Drawing.Size(500,400)
$form.StartPosition = 'CenterScreen'

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(150,300)
$okButton.Size = New-Object System.Drawing.Size(75,23)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(225,300)
$cancelButton.Size = New-Object System.Drawing.Size(75,23)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Please select a profile:'
$form.Controls.Add($label)

$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Location = New-Object System.Drawing.Point(10,40)
$listBox.Size = New-Object System.Drawing.Size(260,20)
$listBox.Height = 240
$listBox.Width  = 300
[void] $listBox.Items.Add('-------- Locatie --------')
[void] $listBox.Items.Add('ALVM'),
[void] $listBox.Items.Add('ALM')
[void] $listBox.Items.Add('BVM'),
[void] $listBox.Items.Add('DRM')
[void] $listBox.Items.Add('ALH'),
[void] $listBox.Items.Add('EMVM')
[void] $listBox.Items.Add('EDVM'),
[void] $listBox.Items.Add('LSV')
[void] $listBox.Items.Add('MAV'),
[void] $listBox.Items.Add('NKVM')
[void] $listBox.Items.Add('VPVM'),
[void] $listBox.Items.Add('EDB')
[void] $listBox.Items.Add('DRH'),
[void] $listBox.Items.Add('WAH')
[void] $listBox.Items.Add('BPVM'),
[void] $listBox.Items.Add('HVVM')
[void] $listBox.Items.Add('LWVM'),
[void] $listBox.Items.Add('LWM')
[void] $listBox.Items.Add('EDT'),
[void] $listBox.Items.Add('SNVM')
[void] $listBox.Items.Add('AGREE')
[void] $listBox.Items.Add('')
[void] $listBox.Items.Add('-------- Type --------')
[void] $listBox.Items.Add('Personal-')
[void] $listBox.Items.Add('Shared-')


$form.Controls.Add($listBox)

$form.Topmost = $true

$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $x = $listBox.SelectedItem
    $GroupTag = $x
}
Show-PowershellWindow
