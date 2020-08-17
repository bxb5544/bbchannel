
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="author" content="Brooke Basile">
    <meta name="description" content="{block "description"}bbchannel{/block}">
    <link rel="icon" href="/favicon.ico">

    <title>{block "title"}bbchannel{/block}</title>

    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    <!-- Custom styles for this template -->
    <link href="//fonts.googleapis.com/css?family=Playfair+Display:700,900" rel="stylesheet">
    <link href="/css/blog.css?{time()}" rel="stylesheet">
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/prism/1.14.0/themes/prism.css" />
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/prism/1.14.0/themes/prism-twilight.min.css"/>
  </head>

  <body>
    <div class="container">
      <header class="blog-header py-3">
        <div class="row flex-nowrap justify-content-between align-items-center">
          <div class="col-4 pt-1">
            {*<a class="text-muted" href="#">Subscribe</a>*}
          </div>
          <div class="col-4 text-center">
            <a class="blog-header-logo text-dark" href="/">$ bbchannel</a>
          </div>
          <div class="col-4 d-flex justify-content-end align-items-center">
            {*<a class="text-muted" href="#">
              <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="mx-3"><circle cx="10.5" cy="10.5" r="7.5"></circle><line x1="21" y1="21" x2="15.8" y2="15.8"></line></svg>
            </a>
            <a class="btn btn-sm btn-outline-secondary" href="#">Sign up</a>*}
          </div>
        </div>
      </header>

    <main role="main" class="container">
      <div class="row">
        <div class="col-md-8 blog-main">
          <h6 class="pb-3 mb-4 font-italic border-bottom">
            ***
          </h6>
		  {block "content"}{/block}
        </div><!-- /.blog-main -->

        {include "/blog/sidebar.tpl"}

      </div><!-- /.row -->

    </main><!-- /.container -->

    <footer class="blog-footer">
	  <p><a href="#" onclick="window.scrollTo(0,0); return false;">Back to top</a></p>
	  <p>Page generated in {number_format(technexus\App::getLoadTime(),4)} seconds.</p>
    </footer>

    <script src="//code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script defer src="//use.fontawesome.com/releases/v5.0.9/js/all.js" integrity="sha384-8iPTk2s/jMVj81dnzb/iFR2sdA7u06vHJyyLlAd4snFpCl/SnyUjRrbdJsw1pGIl" crossorigin="anonymous"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/prism/1.13.0/prism.min.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/prism/1.13.0/components/prism-php.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/prism/1.13.0/components/prism-bash.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/prism/1.13.0/components/prism-c.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/prism/1.13.0/components/prism-sql.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/prism/1.13.0/components/prism-powershell.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/prism/1.13.0/components/prism-smarty.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/prism/1.13.0/components/prism-apacheconf.js"></script>
	<script>
	  var _paq = _paq || [];
		  /* tracker methods like "setCustomDimension" should be called before "trackPageView" */
		  _paq.push(['trackPageView']);
		  _paq.push(['enableLinkTracking']);
		  (function() {
		    var u="//m.akuj.in/";
		    _paq.push(['setTrackerUrl', u+'a.php']);
		    _paq.push(['setSiteId', '3']);
		    var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
		    g.type='text/javascript'; g.async=true; g.defer=true; g.src=u+'a.js'; s.parentNode.insertBefore(g,s);
		  })();
	</script>
  </body>
</html>
