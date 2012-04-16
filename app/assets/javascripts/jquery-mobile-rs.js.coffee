//= require recurring_select
//= require_self

$ ->
  $(document).on "recurring_select:cancel recurring_select:save", ".recurring_select", ->
    $(this).selectmenu('refresh');

  $(document).on "recurring_select:dialog_opened", ".rs_dialog_holder", ->
    $(this).find("select").attr("data-theme", $('.recurring_select').data("theme")).attr("data-native-menu", "false").selectmenu()
    $(this).find("input[type=text]").textinput()
    # $.mobile.silentScroll $(this).find(".rs_dialog").offset().top

    $(this).on "recurring_select:dialog_positioned", ".rs_dialog", ->
      $(this).css
        "top" : $(window).scrollTop()+"px"

