## Set slack messaging

function Send-SlackMessage {
    # Add the "Incoming WebHooks" integration to get started: https://slack.com/apps/A0F7XDUAZ-incoming-webhooks
    param (
        [Parameter(Mandatory = $true, Position = 0)]$Text,
        $Url = 'https://hooks.slack.com/services/xxxxxxxxx/yyyyyyyyy/zzzzzzzzzzzzzzzzzzzzzzz', #Put your URL here so you don't have to specify it every time.
        # Parameters below are optional and will fall back to the default setting for the webhook.
        $Username, # Username to send from.
        $Channel, # Channel to post message. Can be in the format "@username" or "#channel"
        $Emoji, # Example: ":bangbang:".
        $IconUrl   # Url for an icon to use.
    )

    $body = @{ text = $Text; channel = $Channel; username = $Username; icon_emoji = $Emoji; icon_url = $IconUrl } | ConvertTo-Json
    Invoke-WebRequest -Method Post -Uri $Url -Body $body
}

## Example to use:
## Send-SlackMessage "Uh oh! Shits on fire yo!" -Emoji ":fire:" -Username "PTCBuildMaster"