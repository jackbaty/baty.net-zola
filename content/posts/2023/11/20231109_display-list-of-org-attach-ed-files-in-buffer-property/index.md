---
title: Display list of org-attach'ed files in buffer property
date: 2023-11-09T09:29:19-05:00
taxonomies:
  tags: ["Emacs"]
slug: 
summary: I often want a list of attached files displayed <em>right in </em>the org-mode file.
---

I use [org-attach](https://orgmode.org/manual/Attachments.html) a lot. There's no way to see which files are attached without calling "org-attach-open" or whatever. Apparently something changed in Org-mode years ago that removed the function that did what I want. Found the following [on the mailing list](https://list.orgmode.org/87sg70vsvy.fsf@localhost/)...

```lisp
(defun org-attach-save-file-list-to-property (dir)
    "Save list of attachments to ORG_ATTACH_FILES property."
    (when-let* ((files (org-attach-file-list dir)))
      (org-set-property "ORG_ATTACH_FILES" (mapconcat #'identity files ", "))))
  (add-hook 'org-attach-after-change-hook #'org-attach-save-file-list-to-property)
```

Works great.

