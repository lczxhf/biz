import React, { PropTypes } from 'react';
import ReactDOM from 'react-dom';

import Tree from '../../components/Product/Tree';

export default class TreeContainer  extends React.Component{

  constructor(props, context) {
    super(props, context);

    _.bindAll(this, 'onChange');
  }

  onChange(selectedItems){

    var names = selectedItems.map(function(ele){return ele.props.data.text});
    var ids = selectedItems.map(function(ele){return ele.props.data.id});
  
    $("#product_name").val(names);    
    $("#product_id").val(ids);
  }

  render(){ 
    var {...props} = this.props;    
    return  <div id="modal-tree" className="modal fade" tabIndex="-1">
              <div className="modal-dialog">
                <div className="modal-content">

                  <div className="modal-header">                      
                      <button type="button" className="close" data-dismiss="modal">&times;</button>
                      <h4 className="blue bigger">{this.props.title}</h4>
                  </div>

                  <div className="modal-body no-padding">
                    <Tree {...props} onChange={this.onChange}/>
                  </div>               
                  <div className="modal-footer no-margin-top">
                    <button className="btn btn-sm btn-danger pull-left" data-dismiss="modal">
                      <i className="ace-icon fa fa-times"></i>
                      关闭
                    </button>
                  </div> 
                </div>
              </div>
            </div>;                       
  }
}


