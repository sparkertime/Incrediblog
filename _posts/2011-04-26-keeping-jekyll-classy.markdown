---
layout: post
title: Keeping Jekyll Classy
the point: Out-of-the-box Jekyll falls short of building a first-class blog engine. With a little work you can bend it to your will.
---

{% image classy.jpg %}
  title: "classy dude" by jonthor6
  link: http://www.flickr.com/photos/jonthor6/5548240797/
{% endimage %}

For some time now I've been hearing fellow dweebs sing the praises of [Jekyll](http://github.com/mojombo/jekyll), a static HTML generator built in Ruby. There's clearly lots to love in Jekyll for the programmer-blogger. Creating your own HTML layouts is simple as Jekyll mostly stays out of your way (compare to customizing a Wordpress layout, for instance). It's well-suited towards putting your entire blog, posts and all, into source control. The output is just static HTML, so you can deploy to just about any web server known to man.

Out-of-the-box Jekyll comes without many of the frills that make for a compelling blog and a pleasant reading experience, however. A quick glance through some of [the sites powered by Jekyll](http://github.com/mojombo/jekyll/wiki/Sites) prove that it's very easy to write a blog with Jekyll, but it's harder to read one.

You'd be mistaken to walk away from Jekyll though. Jekyll is an ultra-lightweight framework that is malleable by design. With just a little bit of elbow grease (or by just [looking at someone else's work](http://github.com/citizenparker/incrediblog)), you can mould it into precisely what suits your needs and still have done less work than it takes to make your own Wordpress theme. I'll show you a few of the things I've done and hopefully give you the confidence to start building your own Jekyll hacks.

I'm going to dive into each of the following "neat" things I did and show the accompanying source. All of this comes from my publicly available [Github repo 'Incrediblog'](http://github.com/citizenparker/incrediblog) that contains the full source (with posts) to this site.

* [RSS](#rss)
* [Pagination](#pagination)
* [Image Posting](#posting)
* [Image Watermarking](#watermarking)
* [Contact Page](#contact)

Let's go!

<a id='rss'></a>

## RSS

> To use this, just place [rss.xml](http://github.com/citizenparker/incrediblog/raw/master/rss.xml) in the root directory of your Jekyll installation and modify it appropriately for your own page.

Jekyll doesn't have any RSS support out of the box for generating a feed, so this was the first thing I decided to create. Thankfully you have the tools to build what you need. Jekyll will process and convert any file that doesn't begin with an underscore. The assumption is that most of these files will be HTML or converted into HTML. However, there's nothing stopping you from making your own "rss.xml" file that Jekyll will process and make dynamic.

Once you realize that, building the RSS file is straightforward. I started looking at the RSS specifications and writing my own, but that's much more painful than it needs to be. I recommend looking at the [coyled.com rss.xml](http://github.com/coyled/coyled.com/blob/master/rss.xml) and starting from there. You can also take a look at [my rss.xml](http://github.com/citizenparker/incrediblog/master/rss.xml) which is based on his work.

<a id='pagination'></a>

## Pagination

A common pattern with Jekyll blogs is that the home page consists only of links to other articles and posts on the site. That's very un-blog-like and not the greatest reading experience. I want the latest and greatest articles to be shown in full, but I only want to show a few at once.

I need pagination!

Jekyll provides the components you'll need for this feature - you just need to assemble them. Just add something like {% inline_syntax paginate: 5 %} to your _config.yml to enable pagination. Once this is done, you'll see that Jekyll will generate an {% inline_syntax index.html %} as well as a {% inline_syntax /pageX/index.html %} for each page of your index.

Next, you just need to combine the [Jekyll Template Data](https://github.com/mojombo/jekyll/wiki/Template-Data) with some [Liquid syntax](http://info.getcashboard.com/topics/liquid_basics) to build out the "Next Page / Previous Page" links. Here's an example from my index.html:

{% syntax html https://github.com/citizenparker/incrediblog/raw/master/index.htm %}
<section id="paging">
  {{ "{%" }} if paginator.previous_page {{ "%" }}}
    {{ "{%" }} if paginator.previous_page == 1 {{ "%" }}}
      <a href="/">&lArr; Previous Page</a>
    {{ "{%" }} else {{ "%" }}}
      <a href="/page{{ paginator.previous_page }}">&lArr; Previous Page</a>
    {{ "{%" }} endif {{ "%" }}}
  {{ "{%" }} endif {{ "%" }}}

  Page {{ "{{" }} paginator.page }} of {{ "{{" }} paginator.total_pages }}

  {{ "{%" }} if paginator.next_page {{ "%" }}}
    <a href="/page{{ paginator.next_page }}">Next Page &rArr;</a>
  {{ "{%" }} endif {{ "%" }}}
</section>
{% endsyntax %}

The only tricky part is that you have to check to see if you're linking back to the first page, as it will always be {% inline_syntax index.html %} and not {% inline_syntax /pageX/index.html %}

<a id='posting'></a>

## Image Posting

> To use this, just place [image_block.rb](http://github.com/citizenparker/incrediblog/raw/master/_plugins/image_block.rb) in your {% inline_syntax /_plugins %} directory.

One of the reasons I'm sweet on Jekyll is that it lets me write my posts in Textile or Markdown, but they both have a fairly human-unfriendly syntax for embedding images, let alone images that link to URLs or have sensible "title" and "alt" attributes.

I decided to make my own image tag for posts then. Ultimately I wanted a syntax like this:

{% syntax text %}
 ... blah blah blah yakety smackety ...
{{ "{%" }} image my_cool_image.jpg {{ "%" }}}
  title: This is just a test title.
  alt: Something descriptive
  link: http://www.google.com
{{ "{%" }} endimage {{ "%" }}}
 ... and so on ...
{% endsyntax %}

Neither Jekyll nor Liquid support this out of the box, so this requires a [Jekyll plugin](http://github.com/mojombo/jekyll/wiki/Plugins) to add this new Liquid syntax. New tags require you to extend the {% inline_syntax Liquid::Block %} class and to override the {% inline_syntax def render(context) %} method. Given that, here's the plugin I ended up writing:

{% syntax ruby http://github.com/citizenparker/incrediblog/raw/master/_plugins/image_block.rb %}
{% endsyntax %}

A few notes about this. All of my images would be in the same directory {% inline_syntax /images %} so I didn't want to specify that everywhere. I also wanted every attribute in that Liquid block to be optional. Oh, and {% inline_syntax block_contents %} is some Liquid black magic that I couldn't find a way around[^1].

<a id="watermarking"></a>

## Image Watermarking

> To use, just place that file in your {% inline_syntax /_plugins %} directory, and make sure you have ImageMagick and the MiniMagick gems installed.

If you remember one thing about me, it's this: I'm a classy dude[^2]. I want my blog to be classy too, and so that means watermarking all the images I post with my website.

Thankfully [ImageMagick](http://www.imagemagick.org/) and the [MiniMiagick gem](https://github.com/probablycorey/mini_magick) make this pretty easy. This means I need a [Jekyll Generator](https://github.com/mojombo/jekyll/wiki/Plugins) - a plugin that creates static files for the site. NOTE: because of [this bug](https://github.com/mojombo/jekyll/issues/268) in the latest version of Jekyll, you'll also need to include a hack to prevent Jekyll from removing all those generated files. You can grab mine at [http://github.com/citizenparker/incrediblog/raw/master/_plugins/generator_hack.rb](http://github.com/citizenparker/incrediblog/raw/master/_plugins/generator_hack.rb)

From there, it's a simple two-step process to start watermarking the images. First, I use [this shell script](http://github.com/citizenparker/incrediblog/raw/master/_images/support/regen_stamp.sh) to create the watermark image ("spparker.com" in this case.)

Then I created this generator plugin to stamp each file in {% inline_syntax _images %} with that watermark and dump the result in {% inline_syntax /images %}:

{% syntax ruby http://github.com/citizenparker/incrediblog/raw/master/_plugins/image_generator.rb %}
{% endsyntax %}

<a id='contact'></a>

## Contact Me

Obviously, my blog is poised to set the world aflame. All of that enthusiasm and passion will go to waste though if people can't reach out to me and let me know how much my work has personally moved them and their families. A "Contact" page was in order.

This is a tall order for a static HTML generator to handle. After reading [this gist](https://gist.github.com/463598) I decided to build a similar light-weight Sinatra app and some Javascript trickery to send emails that the static HTML pages will POST to.

Here's the Sinatra app in full:

{% syntax ruby http://github.com/citizenparker/incrediblog/raw/master/lib/email.rb %}
{% endsyntax %}

There's really not much to it. The contact page then just checks for the "success" or "errors" URL parameters to display an appropriate message. A little wonky, but it works and it saves me from serving any HTML content outside of Jekyll.

## Wrapping Up

I'm sure at least a few of these customizations aren't for you, or may need some tweaking before they are. I hope that you see how malleable Jekyll is, and how simple customizing it can be. Again, you are encouraged to steal from [my github repo](http://github.com/citizenparker/incrediblog), although a nod in your README or somewhere else would be awfully nice of you. 

-SP

[^1]: If you find a way around that, please [contact me](/contact). I hate the {% inline_syntax block_contents %} method.

[^2]: I am writing this in a orange stocking cap and [this t-shirt](http://www.topatoco.com/merchant.mvc?Screen=PROD&Store_Code=TO&Product_Code=BEAT-READING&Category_Code=BEAT).

[^3]: And node.js too.