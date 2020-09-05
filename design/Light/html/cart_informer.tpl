{* Информера корзины (отдаётся аяксом) *}

{if $cart->total_products>0}
    <a href="./cart/" class="btn btn-primary">
    <i class="fa fa-shopping-cart"></i> Корзина <span class="badge badge-light">{$cart->total_products}</span>
    </a>
{else}
    <a href="./cart/" class="btn btn-primary">
        <i class="fa fa-shopping-cart"></i> Корзина <span class="badge badge-light">0</span>
    </a>
{/if}

