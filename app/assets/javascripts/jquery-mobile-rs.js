(function() {
    $(function() {
        $(document).on("recurring_select:cancel recurring_select:save", ".recurring_select", function() {
            return $(this).selectmenu('refresh');
        });
        return $(document).on("recurring_select:dialog_opened", ".rs_dialog_holder", function() {
            $(this).find("select").attr("data-theme", $('.recurring_select').data("theme")).attr("data-mini", true).selectmenu();
            $(this).find("input[type=text]").textinput();
            return $(this).on("recurring_select:dialog_positioned", ".rs_dialog", function() {
                return $(this).css({
                    "top": $(window).scrollTop() + "px"
                });
            });
        });
    });

}).call(this);