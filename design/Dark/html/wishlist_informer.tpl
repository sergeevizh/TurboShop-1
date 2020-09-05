{* Информера избранного (отдаётся аяксом) *}

{if $wishlist_products>0}
    <a href="/wishlist/"><i class="fa fa-heart text-danger"></i><span class="badge text-danger card-link">{$wishlist_products|count}</span></a>
{else}
    <a href="/wishlist/"><i class="fa fa-heart text-white"></i><span class="badge text-white card-link">0</span></a>
{/if}