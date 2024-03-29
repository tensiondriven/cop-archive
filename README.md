# cop-archive

This project takes data from a mysql database and renders it to a series of html files in the `/docs` folder.  That folder is then pushed to Github and served by Github Pages under `community-archive.holacracy.org`.

### To make changes,
- Check out the code
Stand up the project by installing Elixir and Mysql.
- `mix deps.get`
- Restore `Dump20191119.sql` to the mysql database
- Set up your secrets (see `config/dev.exs`)

You should then be able to browse the site with `mix phx.server`.

### To render out the content,

```
mix render
```

This will update all the files in `/docs`.

### To render out the sitemap,

```
mix sitemap
```

This will write `sitemap.xml` and `sitemap1.xml` to `/docs`.

Then commit everything and push.  The sitemap will automatically be updated on Github.

### To publish,

Then commit everything and push.  The conent will automatically be updated on Github.

This static site uses Google Custom Search for the search box.  You may need to set up a new Google Custom Search if you need to change anything with it.

### Important: Publishing

Important: Because the master branch is protected on github, you must force push each time you deploy.
When you do this, Github loses the "Custom Domain" setting, which is needed for the site to be served properly.  Every time you push to master, you must reset "Custom domain" to `community-archive.holacracy.org`  on https://github.com/holacracyone/cop-archive/settings

Questions? <jonathan.yankovich@gmail.com>

### Links

- https://community-archive.holacracy.org/
- https://github.com/holacracyone/cop-archive/settings
- https://cse.google.com/cse/all
- https://github.com/ikeikeikeike/sitemap
