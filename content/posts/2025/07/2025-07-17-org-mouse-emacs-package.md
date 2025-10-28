---
title: 'Org-mouse Emacs package'
date: 2025-07-17 07:42:18-04:00
slug: org-mouse-emacs-package
taxonomies:
  tags: ["emacs"]
summary: 
---

`org-mouse` is a built-in package for Org mode that lets one do some handy things using the mouse in Org files. Things like checking checkboxes and toggling subtrees.

```lisp
(use-package org-mouse
        :after org)
```

Or just `(require 'org-mouse)`

Clicking in `[ ] Do this thing` to complete it is easier than navigating to the line and hitting `C-c C-c` for each item.

There's no shame in using a mouse, even in Emacs. I sometimes prefer to sit back, grab the mouse, and click things.

