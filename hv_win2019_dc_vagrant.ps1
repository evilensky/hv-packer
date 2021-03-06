# Build images

$template_file="./templates/hv_win2019_g2_vagrant.json"
$var_file="./variables/variables_win2019_dc.json"
$machine="Windows Server 2019 Datacenter Gen-2 Vagrant"
$packer_log=0

if ((Test-Path -Path "$template_file") -and (Test-Path -Path "$var_file")) {
  Write-Output "Template and var file found"
  Write-Output "Building: $machine"
  try {
    $env:PACKER_LOG=$packer_log
    packer validate -var-file="$var_file" "$template_file"
  }
  catch {
    Write-Output "Packer validation failed, exiting."
    exit (-1)
  }
  try {
    $env:PACKER_LOG=$packer_log
    packer build --force -var-file="$var_file" "$template_file"
  }
  catch {
    Write-Output "Packer build failed, exiting."
    exit (-1)
  }
}
else {
  Write-Output "Template or Var file not found - exiting"
  exit (-1)
}

