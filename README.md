StaticDocs [![Build Status](https://travis-ci.org/Mik-die/static_docs.png)](https://travis-ci.org/Mik-die/static_docs)
==========

StaticDocs is about some static pages. These static pages can be created, stored
and edited as files. Then they can be imported into DB of your app and be shown
within app's layout. Rules of displaying are described in special manifest file,
gem's initializer of app and in route file.

This gem was extracted from [Rusrails](http://rusrails.ru), so you can use its
[source code](https://github.com/morsbox/rusrails) as demo example.

Installation
------------

StaticDocs is Rails engine, it works with Rails 3.1+.

Add in Gemfile:

```ruby
gem 'static_docs'
```

Then copy migrations `rake static_docs:install:migrations` and run them
`rake db:migrate`.

Then mount its engine at the bottom of your `config/routes.rb` (because it is
greedy and following routes will never be mapped)

```ruby
  mount StaticDocs::Engine => "/"
```

Then create initializer in `config/initializers/static_docs.rb`

```ruby
# Probably you also want this shortcut for static_docs pages:
# Page = StaticDocs::Page

StaticDocs.setup do
  source 'source'
end
```

Then create your source manifest in `source/index.yml`

```yaml
special:
  - title:    Main Page
    path:     index
    file:     index.html

pages:
  - title:    This is Just Page
    path:     page
    file:     page.html

```

Then create listed docs `source/index.html` and `source/page.html` with content
you want.

And next run `rake static_docs:import` to import files into database. You should
run this task after each change of source files.

Thats it! Follow to `/` or `/page` and you will see your pages within
application layout!

Using
-----

### Routes

This is mountable engine and it should be mounted in your routes file
(`config/routes.rb`).

Because it routes all requests within mounted path to own controller, you should
mount at bottom of routes file (especially if you mount on `'/'` path).

In your controllers and views you can use route helpers for pages (both are
equal):

```haml
= link_to page.title, [static_docs, page]
= link_to page.title, static_docs.page_path(page)
```

### Sources

You can describe several sources in initializer.

```ruby
StaticDocs.setup do
  # Root namespace have source in 'sources/root' of your Rails app
  source 'sources/root'

  # Faq namespace have source in 'sources/faq' of your Rails app. These pages
  # will be available at `/faq/page_path`
  source 'sources/faq', :namespace => :faq
end
```

### Renderers

Extension of each source defines which renderer should be used. For example, for
`page.html` will be used `html` renderer, but for `faq.md` will be used `md`
renderer. By default there are only `html` and `txt` renderers:

```ruby
:html => proc{ |body| body.html_safe },
:txt => proc{ |body| body }
```

You can define own renderers in initializer.

```ruby
StaticDocs.setup do
  source 'source'

  # Renderer is evaluated in view context. `markdown` method can be defined
  # somewhere in view helpers
  renderer :md do |body|
    markdown(body)
  end

  # You can redefine default renderer (`txt`), and also have access to page
  # instance. Page have `meta` hash, that special exists for using inside
  # renderer to pass some data outside.
  renderer :txt do |body, page|
    page.meta[:test] = 'test'
    page.meta[:test] * 3
  end

  # You can also define renderer for specific namespace
  renderer :md, :namespace => :examples do |body|
    "<pre>#{body}</pre>".html_safe
  end
end
```

### Views

If you dissatisfied default view you can create own in
`app/views/static_docs/pages/show.html.erb`.

Page is avalable as `@page` instance variable. Use `@page.rendered_body(self)`
to get rendered body.

### Import

Task for import pages to database is `rake static_docs:import`. Use
`namespace=xxx` or `namespaces=xxx,yyy` to point what namespace to import. Use
keyword `root` to point on root namespace.

### Deploy

StaticDocs has Capistrano task to import pages into your production database.
Just require the recipes:

```ruby
# config/deploy.rb
require 'static_docs/capistrano'
```

And then invoke `cap static_docs:import` (or bind this task to another ones).

TODO list
---------

- setup generator
- new doc generator
- more ways where to store docs (another repo / web / absolute path)
- skipping index page
- more verbose error handling and warnings
- custom fields for pages

Note on Patches/Pull Requests
-----------------------------

- Fork the project.
- Make your feature addition or bug fix.
- Add tests for it. This is important so I don't break it in a future version unintentionally.
- Commit, do not mess with rakefile, version, or history.
- Send me a pull request. Bonus points for topic branches.

The MIT License (MIT)
---------------------

Copyright 2013 Mikhail Dieterle (Mik-die)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
