# Set Verbose Mode
#--------------------------------------------------------------
# Global Variables:
#   - PEINSTALL_FILE: Location of installation from PM
#   - PEINSTALL_URL:  Download URL from PM
#   - PP_ROLE:        Puppet Role for Windows System
#   - PP_APPLICATION: Puppetl Application for Windows System
#   - PP_ENVIRONMENT: Default Puppet Environment
#   - CSR_PATH:       Location of trusted facts
#   - CSR_FILE:       File used for creating trusted facts
#   - PASSWORD:       Admin Account Password
#--------------------------------------------------------------
# Execution:
#   winrm /quickconfig
#   powershell.exe -ExecutionPolicy Bypass C:\bootstrap_windows_pa.ps1
##--------------------------------------------------------------
$PEINSTALL_FILE="c:\pe_install.ps1"
$PEINSTALL_URL="https://${puppet_master}:8140/packages/current/install.ps1"
$PP_ROLE="${pp_role}"
$PP_APPLICATION="${pp_application}"
$PP_ENVIRONMENT="${pp_environment}"
$CSR_PATH="C:\ProgramData\PuppetLabs\puppet\etc\"
$CSR_FILE="csr_attributes.yaml"
$ADMIN_PASSWORD="${password}"

#--------------------------------------------------------------
# Setup Administrator Passwords
#--------------------------------------------------------------
function install_administrator {
  Write-Host "======================= install_administrator ======================="

  $admin = [adsi]("WinNT://./administrator, user")
  $admin.psbase.invoke("SetPassword", $ADMIN_PASSWORD)

}

#--------------------------------------------------------------
# Peform pre-agent installation tasks.
#--------------------------------------------------------------
function pre_install_pa {
  Write-Host "======================= Executing pre_install_pa ======================="

  New-Item -ItemType Directory -Force -Path $CSR_PATH

  $CSRATTRIBUTES = "---`r`nextension_requests:`r`n  pp_role: $PP_ROLE`r`n  pp_environment: $PP_ENVIRONMENT`r`n  pp_application: $PP_APPLICATION`r`n"
  $CSRATTRIBUTES | out-file -Encoding ascii $CSR_PATH/$CSR_FILE
}

#--------------------------------------------------------------
# Peform post-agent installation tasks.
#--------------------------------------------------------------
function post_install_pa {
  Write-Host "======================= Executing pre_install_pa ======================="
}

#--------------------------------------------------------------
# Wait until PE console is fully operation and install PE
# agent.
#--------------------------------------------------------------
function install_pa {
  Write-Host "======================= Executing install_pa ======================="

  :loop while ($true) {  
    [Net.ServicePointManager]::ServerCertificateValidationCallback = {$true} 
    $webclient = New-Object system.net.webclient
    $webclient.DownloadFile($PEINSTALL_URL,$PEINSTALL_FILE)
    if(Test-Path $PEINSTALL_FILE){
      Write-Verbose "Starting Installation"
      invoke-expression $PEINSTALL_FILE   
      break loop 
    }
    else {
      Write-Verbose "Waiting on PuppetMaster"
	  sleep 30
    }
  }
}

#--------------------------------------------------------------
# Initiate Puppet Run.
#--------------------------------------------------------------
function run_puppet {
  Write-Host "======================= Executing install_pa ======================="
  #puppet agent -t
}

#--------------------------------------------------------------
# Main Script
#--------------------------------------------------------------
install_administrator
pre_install_pa
install_pa
post_install_pa
run_puppet