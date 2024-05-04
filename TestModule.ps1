Remove-Item .\logs\payload.json -ErrorAction SilentlyContinue

import-Module ./ManageDiscord.psm1

$payload = Add-DiscordEmbed -title "I love peas" -description "Peas are really the best!" -thumbnailUrl "https://static1.squarespace.com/static/5644323de4b07810c0b6db7b/t/5aa44874e4966bde3633b69c/1520715914043/webhook_resized.png"

Send-DiscordMessage -payload $payload -WebhookUrl "https://discord.com/api/webhooks/1235206368693063710/4GfhAeYpiFPOIkcRYP6mleJa3nin3wOnAM5A0Z4GydPh0qLFIEdLJcJ5poHMX6O3qCob"