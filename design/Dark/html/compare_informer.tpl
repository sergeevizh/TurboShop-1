{* Информера избранного (отдаётся аяксом) *}

{if $compare_products>0}
    <a href="/compare/"><i class="fa fa-chart-bar text-info"></i><span class="badge text-info card-link">{$compare_products}</span></a>
{else}
    <a href="/compare/"><i class="fa fa-chart-bar text-white"></i><span class="badge text-white card-link">0</span></a>
{/if}