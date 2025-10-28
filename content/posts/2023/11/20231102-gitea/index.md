---
title: Gitea
date: 2023-11-02T09:09:17-05:00
taxonomies:
  tags: ["Gitea","Software"]
slug: 
summary: Why would anyone host their own Git repos when Github exists?
---

Why would anyone host their own Git repos when Github exists? Fair question!

For me, it's mostly because Github has become too much like a social network. It feels like LinkedIn for nerds.

I moved most of my repos to [Sourcehut](https://sourcehut.org/) last year. Sourcehut has that fun, Craigslist sort of retro simplicity that I like. On the other hand, it's just kind of weird. I have a hard time finding my way around. I don't really understand the Projects hierarchy. I love the built-in mailing lists, but otherwise it's mostly too difficult for me.

A few years ago I moved my stuff to a self-hosted [Gitea](https://about.gitea.com/) instance. Gitea is nice. It's familiarly Github-esque. It's fast, and it's a single Go binary. You know how much I love self-contained software.

Gitea and I drifted apart when I went through a "let someone else deal with hosting" phase. I'm less inclined to want to geek out with hosting still today, but between the ultra-nerdiness of Sourcehut and the increasingly showoffy nature of Github, I thought it might be time to revisit running my own repo server.

Installing Gitea was a breeze. I followed [their own instructions](https://docs.gitea.com/installation/install-from-binary) to the letter and was up and running in less than 30 minutes. Here's a quick summary (I'm basically paraphrasing the installation guide):

Download latest (Ubuntu) and make executable:

```sh
wget -O gitea https://dl.gitea.com/gitea/1.20.5/gitea-1.20.5-linux-amd64
chmod +x gitea
```

I already had a git user on the server, but if not, I would run this:

```sh
# On Ubuntu/Debian:
adduser \
   --system \
   --shell /bin/bash \
   --gecos 'Git Version Control' \
   --group \
   --disabled-password \
   --home /home/git \
   git
```

Then this:

```sh
mkdir -p /var/lib/gitea/{custom,data,log}
chown -R git:git /var/lib/gitea/
chmod -R 750 /var/lib/gitea/
mkdir /etc/gitea
chown root:git /etc/gitea
chmod 770 /etc/gitea
```
(I reset the permissions after installation)

Then I set it up as a service using [their instructions](https://docs.gitea.com/installation/linux-service) and sample service file

By default, Gitea runs on port 3000. I wanted to run it on the standard web port so I needed to configure Caddy as reverse proxy, which is as simple as adding this to my Caddyfile:

```json
git.baty.net {
        reverse_proxy localhost:3000
}
```

There are no default users configured, so I added myself as an admin via the Gitea CLI.

```sh
gitea admin user create --username  myuser \
                        --admin \
                        --password mysuperlongpassword \
                        --email jack@baty.net \
                         -c /etc/gitea/app.ini
```

That was it. By the way, every self-hosted app should use SQLite by default. It's so great and simple.

This feels good. As long as things don't get weird on me, I'll try and stick with it for a while. One odd thing is that almost all of my repos are private, so I have no real *need* for a hosted git service. But I feel better having somewhere "out there" to commit changes to, and Gitea works well for that.

