
  jQuery(function($) {       

    if(!ace.vars['touch']) {          

      $('.chosen-select').chosen({allow_single_deselect:true}); 
      //resize the chosen on window resize

      $(window)
      .off('resize.chosen')
      .on('resize.chosen', function() {

        $('.chosen-select').each(function() {
           var $this = $(this);
           $this.next().css({'width': $this.parent().width()});
        })
      }).trigger('resize.chosen');
      
      //resize chosen on sidebar collapse/expand
      $(document).on('settings.ace.chosen', function(e, event_name, event_val) {
        if(event_name != 'sidebar_collapsed') return;
        $('.chosen-select').each(function() {
           var $this = $(this);
           $this.next().css({'width': $this.parent().width()});
        })
      });    
    }    

    $('[data-rel=tooltip]').tooltip({container:'body'});
    $('[data-rel=popover]').popover({container:'body'});

  });