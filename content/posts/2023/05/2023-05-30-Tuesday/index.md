---
title: "Tuesday, May 30, 2023"
summary: "Journal blog post format changes. Mimestream for email. Arq backup problems. Tweaking the PaperMod theme."
date: 2023-05-30T09:11:00-04:00
lastmod: 2023-05-30T11:01:57-04:00
slug: "2023-05-30-journal"
taxonomies:
  tags: ["email", "workflow"]
draft: false
weight: 0
showtoc: true
tocopen: true
---

## Various and Sundry {#various-and-sundry}

You may have noticed that these daily journal posts have been expanding to include what would normally be separate blog posts. This has been an organic process, and continues to evolve. Part of me prefers this one-a-day writing process. It's easy to manage and lets me combine short and long-form content as well as images, quotes, etc. This can all be in a day's journal. On the other hand, I no longer have an easily-parsable list of posts. It makes the [Archives](/archives/) less useful. At least the PaperMod theme automatically generates links to each heading.

---

I switched to Arq backup a couple weeks ago because it feels like I have more control of things using Arq. However, after a few days of successful backups, I'm no longer able to either back up to Arq's cloud, nor can I see the current backups. Support is working on it. I'm able to back up to a Backblaze B2 location, but not to Arq's cloud. See what I get for "improving" my process?

---

{{< figure src="quote.png" >}}


## Mimestream {#mimestream}

In another example of solving a problem I don't have, I'm testing the [Mimestream](https://mimestream.com/) email client for Gmail. I'm a sucker for new ways to use email, and also for [rave reviews](https://tidbits.com/2023/05/24/why-i-use-mimestream-for-gmail/), so I've made a few changes to my email setup in order to test Mimestream.

The "problem" for me is that Mimestream is currently _only_ a wrapper for the Gmail API. It doesn't do IMAP, so in order to test it, I have to use my Gmail account. Since I don't get email to that account, I am forwarding my Fastmail email to Gmail. I'm using Fastmail's SMTP service to send from Gmail so that my From: address remains jack@baty.net.

So far, I like Mimestream. It's got that clean, fast, fully macOS _feel_ that I love. I don't receive enough email to merit spending an extra $50/year on a subscription, but that doesn't mean I _won't_. I like nice things, and Mimestream is a nice thing.


## PaperMod-ing {#papermod-ing}

Every time I try a new theme, I promise myself that I won't tinker with it. That promise lasted just over one day this time. I haven't done anything drastic, but here's the list so far:

-   Changed font to Alegreya Sans. Not sure how I feel about it yet.
-   Added a "Reply by Email" button/link to the bottom of each post
-   Tweaked blockquote element CSS. It needs more, I think.
-   Forced full posts into the RSS feed. I'll never understand why Hugo doesn't come with this option built-in.
-   Added "Categories" and "Uses" menu items. Do I even need categories?


[//]: # "Exported with love from a post written in Org mode"
[//]: # "- https://github.com/kaushalmodi/ox-hugo"