variable "vm_os_simple" {
  default = ""
}

# Definition of the standard OS with "SimpleName" = "publisher,offer,sku"
variable "standard_os" {
  default = {
    "UbuntuServer"  = "Canonical,UbuntuServer,18.04-LTS"
    "WindowsServer" = "MicrosoftWindowsServer,WindowsServer,2019-Datacenter"
    "RHEL"          = "RedHat,RHEL,8.2"
    "openSUSE-Leap" = "SUSE,openSUSE-Leap,15.1"
    "CentOS"        = "OpenLogic,CentOS,7.6"
    "Debian"        = "credativ,Debian,9"
    "CoreOS"        = "CoreOS,CoreOS,Stable"
    "SLES"          = "SUSE,SLES,12-SP2"
  }
}
