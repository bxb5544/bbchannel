<aside class="col-md-4 blog-sidebar">
  <div class="p-3 mb-3 bg-light rounded blog-sidebar-about">
    <h6 class="font-italic">about</h6>
    <span>Software engineering undergrad student, Gentoo enthusiast, GNU/Linux fanatic, aspiring embedded engineer, kernel infant</span>
    <span><br><br>I made this blog primarily to organize my learning and to help my studies, but I hope my writing can help others learn as well.</br></br></span>
    <span></br><b> PGP:</b> 42F0 82BC B44A 98AC 983A 6CAA 6E51 B861 1B2F 9E49</br></span>
    <p class="mb-0"></p>
  </div>

  <div class="p-3">
    <h6 class="font-italic">archives</h6>
    <ol class="list-unstyled mb-0">
	  {foreach from=$data.Sidebar.Months item=Month}
	  	<li><a href="/{$Month.Year}/{str_pad($Month.Month, 2, '0', 0)}/">{$Month.MonthName} {$Month.Year}</a></li>
	  {/foreach}
    </ol>
  </div>
  
  <div class="p-3">
	  <h6 class="font-italic">topics</h6>
	  {foreach from=$data.Sidebar.Tags item=Tag}
	  	<a class="badge badge-secondary" href="/topics/{$Tag->Tag->Slug}">{$Tag->Tag->Tag}</a>	
	  {/foreach}
    </ol>
  </div>

{*
  <div class="p-3">
    <h6 class="font-italic">elsewhere</h6>
    <ol class="list-unstyled">
	<li><a href="https://github.com/bxb5544">github</a></li>
	<li><a href="https://fosstodon.org/web/accounts/231793">fosstodon</a></li>
    </ol>
  </div>*}
</aside><!-- /.blog-sidebar -->
