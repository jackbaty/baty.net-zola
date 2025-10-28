---
title: 'Show a new tab when selecting New Tab in Zen Browser'
slug: show-a-new-tab-when-selecting-new-tab-in-zen-browser
date: 2025-10-25
categories: ["Software"]
taxonomies:
  tags: ["Software"]
description: "I prefer seeing a new tab, not the URL search dialog"
---


At some point, for some reason, Zen changed the New Tab behavior when opening new tabs:

> NEW TABS HAVE BEEN REMOVED, instead we are opting for opening the URL bar and then pressing enter to open a new tab (‘zen.urlbar.replace-newtab’ to false in about:config to revert)
>
> [https://zen-browser.app/release-notes/#1.7.5b Features section.](https://zen-browser.app/release-notes/#1.7.5b%20Features%20section.)

I don’t approve, so I found the setting to revert it using about:config…

    zen.urlbar.replace-newtab = false

Much better.
