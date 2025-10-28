---
title: Sending Org-journal entries to Day One
date:  2023-12-19T08:29:19-04:00
taxonomies:
  tags: ["Emacs","Journaling"]
categories: ["Tech"]
---

I mentioned that I should create a lisp function for sending my org-journal entries to Day One. Turns out I'd already done it. The only problem was that the original version assumed I was using a new org file every day. I'm now doing monthly files, so I needed to change how the text selection was made. Here's the new function.

```lisp
(defun jab/dayone-add-note ()
  "Sends current subtree as Day One entry"
  (interactive)
  (org-mark-subtree)
  (shell-command-on-region
   (point)
   (mark)
  "/usr/local/bin/dayone2 -j=Journal new"
  nil))
```

It's not perfect, since it includes any PROPERTY drawers and leading stars, but it works and was easy to make.
