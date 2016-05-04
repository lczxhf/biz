
toolbutton_header = '<div class=\'button-group\''

toolbutton_header_end = '>'
toolbutton = '<div class=\'hidden-sm hidden-xs action-buttons\'> <a class=\'blue\' href=\'javascript: void(0);\'> <i class=\'ace-icon fa fa-search-plus bigger-130\'></i> </a> <a class=\'green\' href=\'#\'> <i class=\'ace-icon fa fa-pencil bigger-130\'></i> </a> <a class=\'red\' href=\'#\'> <i class=\'ace-icon fa fa-trash-o bigger-130\'></i> </a> </div> <div class=\'hidden-md hidden-lg\'> <div class=\'inline pos-rel\'> <button class=\'btn btn-minier btn-yellow dropdown-toggle\' data-toggle=\'dropdown\' data-position=\'auto\'> <i class=\'ace-icon fa fa-caret-down icon-only bigger-120\'></i> </button> <ul class=\'dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close\'> <li> <a href=\'#\' class=\'tooltip-info view\' data-rel=\'tooltip\' title=\'View\'> <span class=\'blue\'> <i class=\'ace-icon fa fa-search-plus bigger-120\'></i> </span> </a> </li> <li> <a href=\'#\' class=\'tooltip-success\' data-rel=\'tooltip\' title=\'Edit\'> <span class=\'green\'> <i class=\'ace-icon fa fa-pencil-square-o bigger-120\'></i> </span> </a> </li> <li> <a href=\'#\' class=\'tooltip-error\' data-rel=\'tooltip\' title=\'Delete\'> <span class=\'red\'> <i class=\'ace-icon fa fa-trash-o bigger-120\'></i> </span> </a> </li> </ul> </div> </div></div>'
strArray = eval($('#columns').attr('data-columns'))
cols = [ null ]
#tooltip placement on right or left

tooltip_placement = (context, source) ->
  $source = $(source)
  $parent = $source.closest('table')
  off1 = $parent.offset()
  w1 = $parent.width()
  off2 = $source.offset()
  #var w2 = $source.width();
  if parseInt(off2.left) < parseInt(off1.left) + parseInt(w1 / 2)
    return 'right'
  'left'

strArray.map (element) ->
  cols[cols.length] = data: element
  return
cols[cols.length] = null
para = window.location.search
oTable1 = $('#dynamic-table').dataTable(
  bAutoWidth: false
  'processing': true
  'serverSide': true
  'aaSorting': []
  ajax: gon.base_url + para
  columns: cols
  columnDefs: [
    {
      'render': (data, type, row) ->
        '<div class=\'center\'><label class=\'pos-rel\'><input class=\'ace\' type=\'checkbox\'/><span class=\'lbl\'/> </label></div>'
      'targets': 0
    }
    {
      'bSortable': false
      'targets': [
        0
        -1
      ]
    }
    {
      'render': (data, type, row) ->
        toolbutton_header + 'item-id = ' + '\'' + row['_id'] + '\'' + toolbutton_header_end + toolbutton
      'targets': -1
    }
    {
      'visible': false
      'targets': [ 1 ]
    }
  ]
  'oLanguage':
    'sLengthMenu': '每页显示 _MENU_ 条记录'
    'sZeroRecords': '抱歉， 没有找到'
    'sInfo': '从 _START_ 到 _END_ /共 _TOTAL_ 条数据'
    'sInfoEmpty': '没有数据'
    'sInfoFiltered': '(从 _MAX_ 条数据中检索)'
    'oPaginate':
      'sFirst': '首页'
      'sPrevious': '前一页'
      'sNext': '后一页'
      'sLast': '尾页'
    'sProcessing': '<div class=\'col-xs-12 center\'><img src=\'/assets/images/loading.gif\' /></div>'
  'sZeroRecords': '没有检索到数据')
#oTable1.fnAdjustColumnSizing();
#TableTools settings
TableTools.classes.container = 'btn-group btn-overlap'
TableTools.classes.print =
  'body': 'DTTT_Print'
  'info': 'tableTools-alert gritter-item-wrapper gritter-info gritter-center white'
  'message': 'tableTools-print-navbar'
#initiate TableTools extension
tableTools_obj = new ($.fn.dataTable.TableTools)(oTable1,
  'sSwfPath': '/assets/swf/copy_csv_xls_pdf.swf'
  'sRowSelector': 'td:not(:last-child)'
  'sRowSelect': 'multi'
  'fnRowSelected': (row) ->
    #check checkbox when row is selected
    try
      $(row).find('input[type=checkbox]').get(0).checked = true
    catch e
    return
  'fnRowDeselected': (row) ->
    #uncheck checkbox
    try
      $(row).find('input[type=checkbox]').get(0).checked = false
    catch e
    return
  'sSelectedClass': 'success'
  'aButtons': [
    {
      'sExtends': 'copy'
      'sToolTip': 'Copy to clipboard'
      'sButtonClass': 'btn btn-white btn-primary btn-bold'
      'sButtonText': '<i class=\'fa fa-copy bigger-110 pink\'></i>'
      'fnComplete': ->
        @fnInfo '<h3 class="no-margin-top smaller">Table copied</h3>              <p>Copied ' + oTable1.fnSettings().fnRecordsTotal() + ' row(s) to the clipboard.</p>', 1500
        return

    }
    {
      'sExtends': 'csv'
      'sToolTip': 'Export to CSV'
      'sButtonClass': 'btn btn-white btn-primary  btn-bold'
      'sButtonText': '<i class=\'fa fa-file-excel-o bigger-110 green\'></i>'
    }
    {
      'sExtends': 'pdf'
      'sToolTip': 'Export to PDF'
      'sButtonClass': 'btn btn-white btn-primary  btn-bold'
      'sButtonText': '<i class=\'fa fa-file-pdf-o bigger-110 red\'></i>'
    }
    {
      'sExtends': 'print'
      'sToolTip': 'Print view'
      'sButtonClass': 'btn btn-white btn-primary  btn-bold'
      'sButtonText': '<i class=\'fa fa-print bigger-110 grey\'></i>'
      'sMessage': '<div class=\'navbar navbar-default\'><div class=\'navbar-header pull-left\'><a class=\'navbar-brand\' href=\'#\'><small>打印预览</small></a></div></div>'
      'sInfo': '<h3 class=\'no-margin-top\'>打印预览</h3>                <p>s使用浏览器打印功能进行打印.                <br />按 <b>escape</b> 退出.</p>'
    }
  ])
#we put a container before our table and append TableTools element to it
$(tableTools_obj.fnContainer()).appendTo $('.tableTools-container')
#also add tooltips to table tools buttons
#addding tooltips directly to "A" buttons results in buttons disappearing (weired! don't know why!)
#so we add tooltips to the "DIV" child after it becomes inserted
#flash objects inside table tools buttons are inserted with some delay (100ms) (for some reason)
setTimeout (->
  $(tableTools_obj.fnContainer()).find('a.DTTT_button').each ->
    div = $(this).find('> div')
    if div.length > 0
      div.tooltip container: 'body'
    else
      $(this).tooltip container: 'body'
    return
  return
), 200
#ColVis extension
colvis = new ($.fn.dataTable.ColVis)(oTable1,
  'buttonText': '<i class=\'fa fa-search\'></i>'
  'aiExclude': [
    0
    6
  ]
  'bShowAll': true
  'sAlign': 'right'
  'fnLabel': (i, title, th) ->
    $(th).text()
    #remove icons, etc
)
#style it
$(colvis.button()).addClass('btn-group').find('button').addClass 'btn btn-white btn-info btn-bold'
#and append it to our table tools btn-group, also add tooltip
$(colvis.button()).prependTo('.tableTools-container .btn-group').attr('title', 'Show/hide columns').tooltip container: 'body'
#and make the list, buttons and checkboxed Ace-like
$(colvis.dom.collection).addClass('dropdown-menu dropdown-light dropdown-caret dropdown-caret-right').find('li').wrapInner('<a href="javascript:void(0)" />').find('input[type=checkbox]').addClass('ace').next().addClass 'lbl padding-8'
#///////////////////////////////
#table checkboxes
$('th input[type=checkbox], td input[type=checkbox]').prop 'checked', false
#select/deselect all rows according to table header checkbox
$('#dynamic-table > thead > tr > th input[type=checkbox]').eq(0).on 'click', ->
  th_checked = @checked
  #checkbox inside "TH" table header
  $(this).closest('table').find('tbody > tr').each ->
    row = this
    if th_checked
      tableTools_obj.fnSelect row
    else
      tableTools_obj.fnDeselect row
    return
  return
#select/deselect a row when the checkbox is checked/unchecked
$('#dynamic-table').on 'click', 'td input[type=checkbox]', ->
  row = $(this).closest('tr').get(0)
  if !@checked
    tableTools_obj.fnSelect row
  else
    tableTools_obj.fnDeselect $(this).closest('tr').get(0)
  return
$(document).on 'click', '#dynamic-table .dropdown-toggle', (e) ->
  e.stopImmediatePropagation()
  e.stopPropagation()
  e.preventDefault()
  return

###******************************###

#add tooltip for small view action buttons in dropdown menu
$('[data-rel="tooltip"]').tooltip placement: tooltip_placement

# ---
# generated by js2coffee 2.2.0


delete_selected_item = (item_id) ->
  $.ajax
    url: gon.base_url + item_id
    type: 'DELETE'
    success: (result) ->
      if result['result_code'] == 1
        # $("#"+ item_id).fadeOut();
        table = $('#dynamic-table').DataTable()
        table.ajax.reload()
      else
        console.log 'error'
      return
  return

batch_delete = (ids) ->
  $.ajax
    url: gon.base_url + "/batch_delete"
    type: 'POST'
    data: ids: ids
    success: (result) ->
      if result['result_code'] == 1
        # $("#"+ item_id).fadeOut();
        table = $('#dynamic-table').DataTable()
        table.ajax.reload()
      else
        console.log 'error'
      return
  return

delete_table_item = (item_id) ->
  d = dialog(
    title: '警告'
    content: '确定删除所选项目？ 删除后不能恢复'
    okValue: '确定'
    ok: ->
      @title '提交中…'
      delete_selected_item item_id
      true
    cancelValue: '取消'
    cancel: ->
      @close()
      return
  )
  d.show()
  return

$('#dynamic-table').on 'draw.dt', ->
  $('a.red').on 'click', (e) ->
    e.preventDefault()
    item_id = $(this).parents('.button-group')[0].getAttribute('item-id')
    delete_table_item item_id
    return
  $('a.green').on 'click', (e) ->
    #var item_id = $(this).parents("tr")[0].getAttribute("item-id");
    item_id = $(this).parents('.button-group')[0].getAttribute('item-id')
    location.href = gon.base_url + item_id + '/edit'
    return
  $('a.blue').on 'click', (e) ->
    item_id = $(this).parents('.button-group')[0].getAttribute('item-id')
    console.log item_id
    location.href = gon.base_url + item_id
    return
  $('span.red').on 'click', (e) ->
    e.preventDefault()
    item_id = $(this).parents('.button-group')[0].getAttribute('item-id')
    delete_table_item item_id
    return
  $('span.green').on 'click', (e) ->
    #var item_id = $(this).parents("tr")[0].getAttribute("item-id");
    item_id = $(this).parents('.button-group')[0].getAttribute('item-id')
    location.href = gon.base_url + item_id + '/edit'
    return
  $('span.blue').on 'click', (e) ->
    item_id = $(this).parents('.button-group')[0].getAttribute('item-id')
    console.log item_id
    location.href = gon.base_url + item_id
    return
  return

$('a.batch_delete').on 'click', ->
  ids = []
  $('#dynamic-table > tbody > tr > td input[type=checkbox]').each (i) ->
    if @checked
      ids.push $(this).parents('tr').children('td').children('.button-group')[0].getAttribute('item-id')
    return
  batch_delete ids
  return


