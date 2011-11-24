window.RecurringSelectDialog =
  class RecurringSelectDialog
    constructor: (@recurring_selector) ->
      @current_rule = @recurring_selector.recurring_select('current_rule')
      @initOuterDialogBox()  
      
    
    initOuterDialogBox: ->
      $(".rs_dialog_holder").remove()
      @outer_holder = $(document.createElement("div"))
      @outer_holder.addClass "rs_dialog_holder"
      @inner_holder = $(document.createElement("div"))
      @inner_holder.addClass "rs_dialog"
      @content = $(document.createElement("div"))
      @content.addClass "rs_dialog_content"
      
      @outer_holder.append @inner_holder
      @inner_holder.append @content
      
      title = @content.append("<h1>Repeat <a href='#' title='Cancel' Alt='Cancel'></a> </h1>")
      cancel_link = title.find('a')
      
      cancel_link.on 'click', @cancel
      @outer_holder.on 'click', @cancel
      @inner_holder.on 'click', (event) -> event.stopPropagation()
      
      $('body').append @outer_holder
      @positionDialog(true)
      @setupForm()
      
      
    positionDialog: (initial_positioning) ->
      window_height = $(window).height()
      dialog_height = @content.height()
      if dialog_height < 100
        dialog_height = 100
      marginTop = (window_height - dialog_height)/2 - 20
      
      new_style_hash = {"margin-top": marginTop+"px", "height":dialog_height+"px"}
      if initial_positioning?
        @inner_holder.css new_style_hash
      else
        @inner_holder.animate new_style_hash
        
    setupForm: ->
      @frequencyMethods.addTo.apply @
      @summmary.addTo.apply @

    cancel: =>
      @outer_holder.remove()
      @recurring_selector.recurring_select('cancel')

    frequencyMethods:
      addTo: ->
        freq_holder = $(document.createElement("p"))
        label = $(document.createElement("label")).text("Frequency")
        label.for = "rs_frequency"
        @freq_select = $(document.createElement("select"))
        @freq_select.name = "rs_frequency"
        @freq_select.append $(document.createElement("option")).text("Daily")
        @freq_select.append $(document.createElement("option")).text("Weekly")
        @freq_select.append $(document.createElement("option")).text("Monthly")
        @freq_select.append $(document.createElement("option")).text("Yearly")

        freq_holder.append label
        freq_holder.append @freq_select
        @content.append freq_holder
        @frequencyMethods.selectDefault.apply @
        
      selectDefault: ->
        rule_type = @current_rule.hash.rule_type
        if rule_type?
          if rule_type.search(/Weekly/) != -1
            @freq_select.prop('selectedIndex', 1)
          else if rule_type.search(/Monthly/) != -1
            @freq_select.prop('selectedIndex', 2)
          else if rule_type.search(/Yearly/) != -1
            @freq_select.prop('selectedIndex', 3)
          
    summmary:
      addTo: ->
        @summary = $(document.createElement("p"))
        @summary.addClass "rs_summary"

        if @current_rule.str?
          @summary.text @current_rule.str
          
        @content.append @summary
        