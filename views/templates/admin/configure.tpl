{*
* 2007-2018 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author    PrestaShop SA <contact@prestashop.com>
*  @copyright 2007-2018 PrestaShop SA
*  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}

<div class="panel">
    <h3>{l mod='wim_gdpr' s='WebImpacto GDPR'}: {l mod='wim_gdpr' s='CONFIGURACIÓN ADICIONAL'}</h3>
    {l mod='wim_gdpr' s='Al instalar este módulo, hay que editar el template del CMS del tema en uso.'}
    {if $ps_version == "1.7"}
    <h4>PRESTASHOP 1.7</h4>
    - {l mod='wim_gdpr' s='El fichero en cuestión se encuentra en la ruta'}
    <code>themes/[nombre-del-tema]/templates/cms/page.tpl</code>
    <br/>
    - {l mod='wim_gdpr' s='Justo encima del siguiente bloque de texto....'}
    <br/>
    <code>
        {literal}
            &lt;section id="content" class="page-content page-cms page-cms-{$cms.id}">
            <br/>
            {block name='cms_content'}
            <br/>
            {$cms.content nofilter}
            <br/>
            {/block}
        {/literal}
    </code>
    <br/>
    - {l mod='wim_gdpr' s='Se debe añadir la siguiente línea'}:
    <br/>
    {literal}<code>{hook h='displayCMSHistory'}</code>{/literal}
    <br/>
    - {l mod='wim_gdpr' s='Quedando algo parecido a'}:
    <br/>
    {literal}
        <code>
            {hook h='displayCMSHistory'}
            <br/>
            &lt;section id="content" class="page-content page-cms page-cms-{$cms.id}">
            <br/>
            {block name='cms_content'}
            <br/>
            {$cms.content nofilter}
            <br/>
            {/block}
        </code>
    {/literal}
    <br/>
    {/if}
    {if $ps_version == "1.6"}
    <h4>PRESTASHOP 1.6 y 1.5</h4>
    - {l mod='wim_gdpr' s='El fichero en cuestión se encuentra en la ruta'} <code>themes/[nombre-del-tema]/cms.tpl</code>
    <br/>
    - {l mod='wim_gdpr' s='Justo encima del siguiente bloque de texto....'}
    <br/>
    <code>
        {literal}
            &lt;div class="rte{if $content_only} content_only{/if}">
            <br/>
            {$cms->content}
            <br/>
            &lt;/div>
        {/literal}
    </code>
    <br/>
    - {l mod='wim_gdpr' s='Se debe añadir la siguiente línea'}:
    <br/>
    {literal}<code>{hook h='displayCMSHistory'}</code>{/literal}
    <br/>
    - {l mod='wim_gdpr' s='Quedando algo parecido a'}:
    <br/>
    {literal}
        <code>
            {hook h='displayCMSHistory'}
            <br/>
            &lt;div class="rte{if $content_only} content_only{/if}">
            <br/>
            {$cms->content}
            <br/>
            &lt;/div>
        </code>
    {/literal}
    <br/>
    {/if}
    {l mod='wim_gdpr' s='La ejecución de este hook mostrará el histórico de cambios del CMS en cuestión.'}

</div>

<div class="panel">
    <h3>WebImpacto GDPR General Data Protection Regulation</h3>

    <form id="module_form" class="defaultForm form-horizontal"
          action="index.php?controller=AdminModules&amp;configure=wim_gdpr&amp;tab_module=others&amp;module_name=wim_gdpr&amp;token={$token}"
          method="post" enctype="multipart/form-data" novalidate>

        {foreach $gdpr_list as $shop}
            <table class="table table-striped table-nonfluid">
                <thead>
                <tr>
                    <th scope="col"><b>#</b></th>
                    <th scope="col"><b>{$shop.name}</b></th>
                    <th scope="col"><b>{l mod='wim_gdpr' s='Protegido'}</b></th>
                </tr>
                </thead>
                <tbody>
                {foreach $shop.cms as $cms}
                    <tr>
                        <td>{$cms.id}</td>
                        <td>{$cms.meta_title}</td>
                        <td><input value="{$cms.id}" parent="{$shop.id}" type="checkbox"
                                   {if $cms.checked==1}checked="checked"{/if} /></td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        {/foreach}

        <input type="hidden" name="submitWim_gdprModule" value="1">

        <div class="panel-footer">
            <button onclick="submitForm()" value="1" id="module_form_submit_btn" name="submitWim_gdprModule"
                    class="btn btn-default pull-right">
                <i class="process-icon-save"></i> {l mod='wim_gdpr' s='Guardar'}
            </button>
        </div>
    </form>
</div>
<script>
    trSelectCheckbox();
</script>