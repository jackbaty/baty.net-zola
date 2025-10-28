---
title: Creating self-contained HTML exports from Tinderbox
date:  2024-11-21T13:10:27-04:00
taxonomies:
  tags: ["Tinderbox"]
summary: "How to export a note with images from Tinderbox and end up with a fully self-contained HTML archive."
---

Exporting from [Tinderbox](https://eastgate.com/Tinderbox) is ridiculously flexible, and I do it all the time. When exporting to HTML, images which are embedded in the note's text are exported as separate images and linked to in the generated HTML. This works fine in most cases. Sometimes, though, I'd prefer to have a self-contained HTML file for sharing or backing up, without having to deal with the external images.

For regular websites, I use the terrific [SingleFile](https://github.com/gildas-lormeau/SingleFile) extension for Safari to render fully self-contained HTML versions. However, it's trickier to use with local HTML files.

Here's my current approach for getting self-contained HTML documents out of Tinderbox notes containing inline images. Although, I believe that this will work with any method of including images in HTML exports.

This is probably not for the faint of heart, and I might be the only person who wants this, but I couldn’t leave it alone.

Here's the short version:

1.  Export HTML normally via Tinderbox
2.  Use a local web server to serve the exported file(s)
3.  Generate a self-contained HTML file using [the SingleFile CLI tool](https://github.com/gildas-lormeau/single-file-cli)

I’m using the following (as a [Stamp](https://acrobatfaq.com/atbref10/index/Automating_Tinderbox/Coding/Action_Code/Actions/Stamps.html)) in Tinderbox:

```
# Save as HTML via SingleFile
var vURL = "http://" + $Text(/Config/WebServerHostname) + $HTMLExportPath;
var vCmd = "export PATH=/opt/homebrew/bin/:\$PATH && ";
vCmd += "single-file " + vURL;
vCmd += " ~/Desktop/" + $HTMLExportPath.split("/").at(-1) ;
$Text(/Debug)=runCommand(vCmd);
```


💡 I had to add the homebrew folder to $PATH before calling `single-file`, otherwise it would throw a “env: node: No such file or directory” error.

Requirements were non-trivial, but if you’re already a Node and/or Homebrew user on macOS it was straightforward.

-   A local web server. I use either Caddy in a terminal, or the simple [WorldWideWeb](https://iconfactory.com/worldwideweb/) app from IconFactory.
-   [Node.js](https://nodejs.org/en/), [Deno](https://deno.com/), and Chromium (installed via Homebrew).
-   The `single-file-cli` installed via npm.

After all that, I realized I could skip all the single-file-cli bits and simply open the exported HTML file in a browser and use the SingleFile extension normally. SingleFile won’t handle local `file:///path/to/file.html` paths, so the web server is still necessary.

```
var vURL = "http://" + $Text(/Config/WebServerHostname) + $HTMLExportPath;
var vCmd = "export PATH=/opt/homebrew/bin/:\$PATH && ";
vCmd += "/usr/bin/open " + vURL;
$Text(/Debug)=runCommand(vCmd);
```

There’s room for both approaches, I suppose. `¯_(ツ)_/¯`

Anyway, it was fun!