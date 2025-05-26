# prank.ps1
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object Windows.Forms.Form
$form.Text = "System Alert"
$form.Size = New-Object Drawing.Size(400,150)
$form.StartPosition = "CenterScreen"
$form.BackColor = 'Black'

$label = New-Object Windows.Forms.Label
$label.Text = "Deleting all user data..."
$label.ForeColor = 'Red'
$label.Font = 'SegoeUI,14,style=Bold'
$label.AutoSize = $true
$label.Location = New-Object Drawing.Point(110,20)
$form.Controls.Add($label)

$progress = New-Object Windows.Forms.ProgressBar
$progress.Minimum = 0
$progress.Maximum = 100
$progress.Value = 0
$progress.Style = 'Continuous'
$progress.Width = 300
$progress.Height = 20
$progress.Location = New-Object Drawing.Point(50,60)
$form.Controls.Add($progress)

$timer = New-Object Windows.Forms.Timer
$timer.Interval = 100

$timer.Add_Tick({
    $progress.Value += 20
    if ($progress.Value -ge 100) {
        $timer.Stop()
        [System.Windows.Forms.MessageBox]::Show("System cleanup completed. Sleeping now...","System",0)
        rundll32.exe powrprof.dll,SetSuspendState Sleep
        $form.Close()
    }
})

$timer.Start()
$form.Topmost = $true
$form.Add_Shown({ $form.Activate() })
[void]$form.ShowDialog()