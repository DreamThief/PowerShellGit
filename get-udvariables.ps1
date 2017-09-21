﻿function Get-UDVariable {
  get-variable | where-object {(@(
    "FormatEnumerationLimit",
    "MaximumAliasCount",
    "MaximumDriveCount",
    "MaximumErrorCount",
    "MaximumFunctionCount",
    "MaximumVariableCount",
    "PGHome",
    "PGSE",
    "PGUICulture",
    "PGVersionTable",
    "PROFILE",
    "PSSessionOption"
    "psISE"
    "psUnsupportedConsoleApplications"
    ) -notcontains $_.name) -and `
    (([psobject].Assembly.GetType('System.Management.Automation.SpecialVariables').GetFields('NonPublic,Static') | Where-Object FieldType -eq ([string]) | ForEach-Object GetValue $null)) -notcontains $_.name
    }
}

