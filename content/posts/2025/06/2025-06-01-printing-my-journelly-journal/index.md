---
title: 'Printing my Journelly journal'
date: 2025-05-03 09:03:43-04:00
slug: printing-my-journelly-journal
summary: An early attempt at exporting my Journelly journal to PDF
cover: 
  image: 
  alt: 
  caption: 
  relative: true
---

I have a well-established monthly routine for getting my org-journal exported to a nice PDF for printing. Converting this process to my Journelly journal needed to happen in order for me to seriously consider switching.

It needs a lot more work, but here's how I did it this time.

## Create monthly file

First, copy and paste the month's entries from my Journelly.org file to a new file, e.g. 2025-04.org.

Add my usual export front matter to the file...

    #+title: Journal - April 2025
    #+date:
    #+setupfile: ~/Documents/Notes/org/_SETUP/EXPORT
    #+setupfile: ~/Documents/Notes/org/_SETUP/jack-latex-journal-twocolumn.setup
    #+latex_class_options: [10pt,twocolumn]

The EXPORT file has a bunch of settings for handling the Org export...

    #+AUTHOR: Jack Baty
    #+OPTIONS: toc:nil num:nil <:nil ':t
    #+OPTIONS: *:t -:t ::t <:nil H:4 \n:nil ^:{} arch:headline
    #+OPTIONS: broken-links:t c:nil creator:nil
    #+OPTIONS: author:t title:t date:t
    #+OPTIONS: d:t e:t email:nil f:t inline:t num:nil
    #+OPTIONS: p:nil pri:nil prop:nil stat:nil tags:nil tasks:nil tex:t
    #+OPTIONS: timestamp:nil toc:nil todo:nil |:t
    #+SELECT_TAGS: export
    #+EXCLUDE_TAGS: noexport nolatex

The .setup file is my variation on the default Pandoc template. I haven't touched it in years, so I don't remember how all of it works. Still...


## Sort entries

Journelly creates entries in reverse-chronological order, so the order needs to be reversed. This is easily done by selecting all the entries and running `M-x org-sort` and choosing "time".

## Reformat headings and dates during exports

Another issue is that each Journelly entry begins as a top-level Org heading containing an org-formatted timestamp and location, like so...

    * [2025-04-10 Thu 05:54] @ Computer
    * [2025-04-09 Wed 06:31] @ Computer
    * [2025-04-08 Tue 12:52] @ Mom and Dad's

That wouldn't look great as headings in a PDF, so I needed to reformat the dates during export. It turned out to be trickier than expected. Org has hooks that do most anything during exports, but I struggled with it. The lisp I eventually found in [this post](https://mac.into.sh/rewrite-timestamps-in-org-export/) helped me get the exported dates to render as e.g. "Saturday, May 3, 2025"

    (with-eval-after-load 'ox
      (add-to-list 'org-export-filter-timestamp-functions
                   #'env-filter-timestamp))
    
    
    (defun env-filter-timestamp (string _backend _comm)
      "Remove [<>] around time-stamps from STRING.
      The filter receives the entire output
    timestamp as STRING and then processes it before saving."
      (if (string-match-p ":" string)
          (format-time-string "%A, %B %-e, %Y"
                              (org-time-string-to-time string))
        (format-time-string "%A, %B %-e, %Y"
                            (org-time-string-to-time string))))

I use a quick `M-x regexp-replace` to remove the location: `@.*` part of the headings.

## Export!

Then it's a matter of running the export via the export dispatch in Emacs. For me, that means `C-c C-e l o` and boom, there's a nice PDF of my month's Journelly entries. Here's a less-than-ideal sample page from April that doesn't include too much personal info:

![](20250503-journelly-pdf.png "")

The odd thing with this is that when I exported, all the images were rendered upside-down. I had to go into Photo Mechanic and run "Apply JPEG Rotation" on the images. This is probably due to adding photos on the iPhone, but I'd like to figure out how to avoid this step in the future.
This all worked fine for my first export. It's close enough, but I'll want to automate as much as possible. I have a month to figure it out 😄.
