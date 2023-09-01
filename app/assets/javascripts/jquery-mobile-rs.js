//= require recurring_select
//= require_self

$(function() {
  $(document).on("recurring_select:cancel recurring_select:save", ".recurring_select", function() {
    $(this).selectmenu('refresh');
  });

  $(document).on("recurring_select:dialog_opened", ".rs_dialog_holder", function() {
    $(this).find("select").attr("data-theme", $('.recurring_select').data("theme")).attr("data-mini", true).selectmenu();
    $(this).find("input[type=text]").textinput();

    $(this).on("recurring_select:dialog_positioned", ".rs_dialog", function() {
      $(this).css({
        "top" : $(window).scrollTop()+"px"});
    });
  });
});
