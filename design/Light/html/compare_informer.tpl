{* Информера избранного (отдаётся аяксом) *}

{if $compare_products>0}
    <a href="/compare/"><i class="fa fa-chart-bar text-primary"></i><span class="badge text-primary card-link">{$compare_products}</span></a>
{else}
    <a href="/compare/"><i class="fa fa-chart-bar text-secondary"></i><span class="badge text-secondary card-link">0</span></a>
{/if}