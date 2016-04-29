import React, { PropTypes } from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';


var gItems = [];
function regItem(item){
  gItems.push(item);
}

export default class Tree extends React.Component {

  constructor(props, context) {
    super(props, context);

    this.state = {
      children:[], name:"",  selectedKeys: this.props.selected,
    };

    _.bindAll(this, 'onSelect');
  }

  componentDidMount() {
    $.getJSON(this.props.url, function(value) {
      this.setState({name: value.text, children: value.children});
    }.bind(this));
  }

  onSelect(item) {
    const selectedKeys = [...this.state.selectedKeys];
    // console.log(selectedKeys);

    const index = selectedKeys.indexOf(item.props.data.id);
    // console.log(item.props.data.id); 

    if(index != -1){        
      selectedKeys.splice(index, 1);

    }else{
      if(this.props.multi == false){        
        selectedKeys.length = 0;              
      }
      
      selectedKeys.push(item.props.data.id);    
    }

    this.setState({selectedKeys: selectedKeys});

    var selectedItems = []; //gItems.filter(function(item){ return selectedKeys.includes(item.props.data.id)});

    gItems.forEach( function(element, index) {
      
      if(selectedKeys.includes (element.props.data.id) ){
          element.setState({checked:true});
          selectedItems.push(element);
      }else{
          element.setState({checked:false});
      }
    });

    // console.log(selectedItem);
    this.props.onChange(selectedItems);    
  }

  render(){    

    return <div className="col-sm-12">
        <div className="widget-box widget-color-blue">
          <div className="widget-header hide">
            <h4 className="widget-title lighter smaller">{this.props.title}</h4>
            <button type="button" className="close" data-dismiss="modal">&times;</button>     
          </div>

          <div className="widget-body">
            <div className="widget-main padding-8">
              <ul className="tree tree-selectable"> {
                  this.state.children.map(function(child){
                    if(child.folder){
                      return <TreeFolder key={child.id} name = {child.text} id = {child.id} selected = {this.state.selectedKeys} root={this}/>;  
                    }else{                      
                      return <TreeItem data={child} key = {child.id} root={this} selected = {this.state.selectedKeys}/>;
                    }                    
                  }.bind(this))
                }
              </ul>
            </div>
          </div>
        </div>
      </div>
  }  
};

var TreeFolder = React.createClass({
  getInitialState: function(){
    return { collapsed: true, loading: false, children: [], selectedKeys: this.props.selected};
  },

  handleItemClick: function(){

    if(this.state.collapsed == false){
      this.setState({collapsed: true});
      return;
    }

    this.setState({loading:true});

    $.getJSON("/api/tree?id=" + this.props.id, function(value) {
      this.setState({collapsed: false, children: value.children, loading:false});
    }.bind(this));

  },

  onSelect(item) {
    this.props.root.onSelect(item);
    // console.log(this.props.data.id);
  },

  render: function(){  
    var loadingClass = "tree-loader ";
    if(this.state.loading == false){
      loadingClass += "hide";
    };

    var childrenClass = "tree-branch-children ";

    var stateClass = "icon-folder ace-icon ";
    if(this.state.collapsed){
      stateClass += "tree-plus";
      childrenClass += 'hide';
    }else{
      stateClass += "tree-minus";
    }

    return <li key={this.props.key} className="tree-branch">
      <div className="tree-branch-header">
        <span className = "tree-branch-name" onClick={this.handleItemClick}>
          <i className={stateClass}/>
          <span className = "tree-label">{this.props.name}</span>
        </span>
      </div>
      <ul className = "tree-branch-children">
        <div className={loadingClass}>
          <div className="tree-loading">
            <i className="ace-icon fa fa-refresh fa-spin blue"/>
          </div>
        </div>
      </ul>    

      <ul className= {childrenClass}>{
        this.state.children.map(function(item){
          if(item.folder){
            return <TreeFolder key={item.id} name = {item.text} id = {item.id}  selected = {this.state.selectedKeys} root = {this}/>;  
          }else{                        
            return <TreeItem data={item} key={item.id} checked={this.state.selectedKeys.includes(item.id)} root = {this}/>;  
          }
          
        }.bind(this))
      }
      </ul>        
    </li>;
  }
});

var TreeItem  = React.createClass({

    getInitialState: function(){
      return { checked: this.props.checked };
    },

    handleItemClick: function(){
      // this.setState({checked: !this.state.checked});
      // console.log(this.props.data.id);     
      this.onSelect();
    },

    onSelect() {
      this.props.root.onSelect(this);
      // console.log(this.props.data.text);
    },

    componentDidMount: function() {
         regItem(this);
    },

    render: function(){
      var checkedClass = "icon-item ace-icon fa ";
      var liCheckedClass = "tree-item ";
      if(this.state.checked){
        checkedClass += "fa-check";
        liCheckedClass += "tree-selected";
      }else{
        checkedClass += "fa-times";
      }

      return <li key={this.props.data.id} className={liCheckedClass} >        
          <span className = "tree-item-name" onClick={this.handleItemClick}>
            <i className= {checkedClass}/>
            <span className = "tree-label"> {this.props.data.text}</span>
          </span>        
      </li>;
    }
});


