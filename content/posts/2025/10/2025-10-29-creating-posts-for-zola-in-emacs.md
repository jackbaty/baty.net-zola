+++
title = 'Creating posts for Zola in Emacs'
date = 2025-10-29 11:32:20-04:00
slug = "creating-posts-for-zola-in-emacs"
[taxonomies]
  tags = ["Emacs","Zola"]
+++

Creating blog posts from Emacs is my prefered method. I had a whole setup built around doing this for Hugo, but since I just switched to Zola I needed to move things around.

Here's where I ended up:

<!-- more -->

```lisp
(defun jab/zola-new-post (title &optional)
  "Create and visit a new post for the prompted TITLE."
  (interactive "sTitle: ")

  (let* ((slug (s-dashed-words title))
	 (default-directory (concat (jab/zola-content-dir)
                                    "posts/"
				    (format-time-string "%Y/%m/")))
	 (fpath (if (y-or-n-p "Make Bundle?")
		    ;; If y create directory using slug and add index.md to path
		    (progn
		      (make-directory (concat default-directory (format-time-string "%Y-%m-%d-") slug "/") 'parents)
		      (concat default-directory (format-time-string "%Y-%m-%d-") slug "/index.md"))
		  ;; Otherwise just use the slug for the filename
		  (progn
		    (concat default-directory (format-time-string "%Y-%m-%d-") slug ".md")))))
    
    (write-region (concat
                   "+++"
                   "\ntitle = '" title "'"
                   "\ndate = " (format-time-string "%Y-%m-%d %H:%M:%S%:z")
                   "\nslug = \"" slug "\""
                   "\n[taxonomies]"
                   "\n  tags = [\"misc\"]"
                   "\n+++\n\n")
                  nil (expand-file-name fpath) nil nil nil t)
    (find-file (expand-file-name fpath))))
```


This prompts for a title then asks me if I want to create a standalone file or something like blog-post-title/index.md. It creates the file with all the appropriate front matter (using TOML, yuck) and then I'm off and running.
