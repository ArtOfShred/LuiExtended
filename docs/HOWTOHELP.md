# LuiExtended Testing Assistance

Beta Builds will be available for testing periodically in the [GitHub Releases Section][1]. I'll usually mention in the esoui comments a test build is available.

You can submit any issues or feature requests in the [Github Issues Section][2], [ESOUI Comments][3], or reach out to me via email at [artofshred@artofshred.net][4].

## What I need feedback on

------

### Localization

- You can find more information about translating LUI to other languages in the [README.md][5] in the i18n folder.

### General

- Report if you don't like the icon style or find the quality of a custom icon for an NPC spell lacking.

### Combat Info - Bar Highlight Tracking

- Report if you see any ability fade or improperly tracked on the bar highlight component. Conditions or ways to replicate it would be great but that's not always obvious. This allows me to fix any issues with tracking that ability.
- Report if the tracking for an ability seems confusing (in some cases one ability has 3 or 4 effects that occur and it can be difficult to determine whats best to track/ignore.

### Combat Info - Active Combat Alerts

- Report if an ability spams alerts or is incorrectly timed. For example if you see a mob cast an ability and you get multiple alerts for that ability.
- Report if an ability isn't tracked properly.

### Chat Announcements

- Report if any odd behavior is observed with Chat Announcements messages printed: an incorrect item listed, improper syntax for a message, etc.
- Report if a setting is not properly applying when toggled. There are a lot of conditionals in Chat Announcements and sometimes its difficult to ensure all options work together seamlessly.

[1]: https://github.com/ArtOfShred/LuiExtended/releases
[2]: https://github.com/ArtOfShred/LuiExtended/issues
[3]: https://www.esoui.com/downloads/info818-LuiExtended.html#comments
[4]: mailto:artofshred@artofshred.net
[5]: https://github.com/ArtOfShred/LuiExtended/blob/master/i18n/README.md
