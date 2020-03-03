<#
    .SYNOPSIS

    .DESCRIPTION

    .EXAMPLE

    .PARAMETER Account
		Your LogicMonitor account (e.g. company.logicmonitor.com. company is the account)

	.PARAMETER AccessId
		Generated in LogicMonitor Settings. Only available upon generation, store it securely.

	.PARAMETER AccessKey
		Generated in LogicMonitor Settings. Store is securely.
    
    .OUTPUTS

    .NOTES

    .LINK
        https://www.logicmonitor.com/support/rest-api-developers-guide/v1/dashboard-groups/add-a-dashboard-group/
#>
Function New-LMDashboardGroup{
	[CmdletBinding()]
	Param([string]
		  [Parameter(Mandatory=$true)]
		  $Account,
		  [string]
		  [Parameter(Mandatory=$false)]
		  $AccessId = $env:LMAPIAccessId,
		  [string]
		  [Parameter(Mandatory=$false)]
		  $AccessKey = $env:LMAPIAccessKey,
		  [int]
		  [Parameter(Mandatory=$true)]
          $ParentId,
		  [int]
		  [Parameter(Mandatory=$true)]
          $Name,
          [string]
		  [Parameter(Mandatory=$false)]
		  $Description)
	
	begin{
		<# request details #>
        $d = @{}
		$httpVerb = "POST"
		$resourcePath = '/setting/collectors'

        if($CollectorGroupId){
            $d.Add("collectorGroupId","$CollectorGroupId")
        }
        $d.Add("description",$Description)

        $Data = $d | ConvertTo-Json -Compress
	}
	process{
		try{
			<# Make Request #>
			$output = Invoke-LMQuery -Account "$Account" -AccessId "$AccessId" -AccessKey "$AccessKey" -Verb "$httpVerb" -Path "$resourcePath" -Data "$Data"

			Write-Output $output
		}
		catch{
			Write-Error $_.Exception.Message
		}
		finally{}
	}
	end{}
}

