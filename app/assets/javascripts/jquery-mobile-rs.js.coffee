//= require recurring_select
//= require_self

$ ->
  $(document).on "recurring_select:cancel recurring_select:save", ".recurring_select", ->
    $(this).data("native-menu", "false").selectmenu('refresh');
  
  $(document).on "recurring_select:dialog_opened", ".rs_dialog_holder", ->
    $(this).find("select").data("theme", $('.recurring_select').data("theme")).data("native-menu", "false").selectmenu()