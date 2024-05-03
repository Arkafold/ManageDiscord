Remove-Item .\logs\payload.json

import-Module ./ManageDiscord.psm1

$payload = Add-DiscordEmbed -title "I love peas" -description "Peas are really the best!"

Send-DiscordMessage -payload $payload -WebhookUrl "https://discord.com/api/webhooks/1235206368693063710/4GfhAeYpiFPOIkcRYP6mleJa3nin3wOnAM5A0Z4GydPh0qLFIEdLJcJ5poHMX6O3qCob"