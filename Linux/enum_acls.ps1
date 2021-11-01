$directory = $(get-childitem)
foreach ($item in $directory) {
	Get-Acl $item
}