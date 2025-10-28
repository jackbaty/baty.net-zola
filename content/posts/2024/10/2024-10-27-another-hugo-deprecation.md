---
title: 'Another Hugo deprecation'
date: 2024-10-27 10:01:53-04:00
slug: another-hugo-deprecation
taxonomies:
  tags: ["hugo"]
summary: 
cover: 
  image: 
  relative: true
  caption: 
---

I sure wish [Hugo](https://gohugo.io) would stop deprecating things.

This time it's `site.Social`. My theme uses that in a couple of files, and the theme's author is busy and doesn't always have time to fix things right away.

They now want `site.Params.Social` so I've temporarily fixed the problem myself by editing two files.

In `twitter_cards.html`:

```
{{ with site.Social.twitter -}}
# becomes
{{ with .Site.Params.Social.twitter -}}
```

And in `opengraph.html`:

```
{{- with site.Social.facebook_admin }}
# becomes
{{- with .Site.Params.Social.facebook_admin }}
```

At least now the error is gone and the site builds. I'll need to keep an eye on the [PaperMod repo](https://github.com/adityatelange/hugo-PaperMod) for a real fix.

UPDATE: See [Issue #1573](https://github.com/adityatelange/hugo-PaperMod/issues/1573)



