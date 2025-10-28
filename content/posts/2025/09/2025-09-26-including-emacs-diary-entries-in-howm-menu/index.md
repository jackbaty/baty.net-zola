---
title: 'Including Emacs diary entries in Howm menu'
date: 2025-09-26 10:45:57-04:00
slug: including-emacs-diary-entries-in-howm-menu
taxonomies:
  tags: ["Emacs","Howm"]
summary: 
cover: 
  image: 
  alt: 
  caption: 
  relative: true
---

⚠️ Note that this doesn't work properly. There's a "nil" at the end.

[Howm](https://github.com/kaorahi/howm) has a handy menu for viewing tasks and notes. One thing I wanted to add was my Emacs diary entries for the current date. This took 3 things:

First, I created a function for inserting the day's entries from Emacs diary in the current buffer.

```lisp
(defun my/insert-diary-entries-for-today ()
  "Insert diary entries for today at point."
  (interactive)
  (let ((diary-list-entries-hook nil)
        (diary-display-function 'ignore))
    (let ((diary-entries (diary-list-entries (calendar-current-date) 1)))
      (if diary-entries
          (dolist (entry diary-entries)
            (insert (cadr entry) "\n"))
        (message "No diary entries for today")))))
```

(and by "I" I mean Claude, mostly)

Then I added the function to the allowed list

```lisp
;; For including Emacs diary in Howm Menu
(setq howm-menu-allow (append '(my/insert-diary-entries-for-today) howm-menu-allow))
```

Finally, I added `%here%(my/insert-diary-entries-for-today)` to Howm's menu file. And now, Howm's menu shows the day's diary entries.

![Screenshot of Howm Menu](howm-menu.jpg "Screenshot of Howm Menu")
