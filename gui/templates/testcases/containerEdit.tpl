{* 
TestLink Open Source Project - http://testlink.sourceforge.net/ 
$Id: containerEdit.tpl,v 1.9 2010/05/01 19:10:47 franciscom Exp $
Purpose: smarty template - edit test specification: containers 

@internal revision
20100315 - amitkhullar - Added Cancel button
20091122 - franciscom - refactoring to use alert_message() and $labels

*}
{lang_get var="labels"
          s='warning_empty_testsuite_name,title_edit_level,btn_save,tc_keywords,cancel,warning'}
{assign var="cfg_section" value=$smarty.template|basename|replace:".tpl":""}
{config_load file="input_dimensions.conf" section=$cfg_section}

{include file="inc_head.tpl" openHead='yes' jsValidate="yes" editorType=$editorType}
{include file="inc_del_onclick.tpl"}

<script language="JavaScript" src="gui/javascript/OptionTransfer.js" type="text/javascript"></script>
<script language="JavaScript" type="text/javascript">
var {$opt_cfg->js_ot_name} = new OptionTransfer("{$opt_cfg->from->name}","{$opt_cfg->to->name}");
{$opt_cfg->js_ot_name}.saveRemovedLeftOptions("{$opt_cfg->js_ot_name}_removedLeft");
{$opt_cfg->js_ot_name}.saveRemovedRightOptions("{$opt_cfg->js_ot_name}_removedRight");
{$opt_cfg->js_ot_name}.saveAddedLeftOptions("{$opt_cfg->js_ot_name}_addedLeft");
{$opt_cfg->js_ot_name}.saveAddedRightOptions("{$opt_cfg->js_ot_name}_addedRight");
{$opt_cfg->js_ot_name}.saveNewLeftOptions("{$opt_cfg->js_ot_name}_newLeft");
{$opt_cfg->js_ot_name}.saveNewRightOptions("{$opt_cfg->js_ot_name}_newRight");
</script>

{literal}
<script type="text/javascript">
{/literal}
var alert_box_title = "{$labels.warning}";
var warning_empty_container_name = "{$labels.warning_empty_testsuite_name}";
{literal}
function validateForm(f)
{
  if (isWhitespace(f.container_name.value)) 
  {
      alert_message(alert_box_title,warning_empty_container_name);
      selectField(f, 'container_name');
      return false;
  }
  return true;
}
</script>
{/literal}

</head>

<body onLoad="{$opt_cfg->js_ot_name}.init(document.forms[0]);focusInputField('name')">
{config_load file="input_dimensions.conf" section="containerEdit"} {* Constant definitions *}
<h1 class="title">{lang_get s=$level}{$smarty.const.TITLE_SEP}{$name|escape}</h1> 

<div class="workBack">
  <h1 class="title">{$labels.title_edit_level} {lang_get s=$level}</h1> 
	<form method="post" action="lib/testcases/containerEdit.php?testsuiteID={$containerID}" 
	      name="container_edit" id="container_edit"
        onSubmit="javascript:return validateForm(this);">

		<div style="float: right;">
			<input type="submit" name="update_testsuite" value="{$labels.btn_save}" />
		<input type="button" name="go_back" value="{$labels.cancel}" onclick="javascript:history.back();"/>
		</div>
	 
	 {include file="testcases/inc_testsuite_viewer_rw.tpl"}

   {* Custom fields *}
   {if $cf neq ""}
     <p>
     <div id="cfields_design_time" class="custom_field_container">
     {$cf}
     </div>
     <p>
   {/if}
   
  <div>
   <a href={$gsmarty_href_keywordsView}>{$labels.tc_keywords}</a>
	 {include file="opt_transfer.inc.tpl" option_transfer=$opt_cfg}
	 </div>
	<br></br>
	<div style="float: left;">
		<input type="submit" name="update_testsuite" value="{$labels.btn_save}" />
		<input type="button" name="go_back" value="{$labels.cancel}" onclick="javascript:history.back();"/>
	</div>
	</form>
</div>

</body>
</html>