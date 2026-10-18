package com.speedEngine.components.ui2D.controls
{
   import com.speedEngine.components.ui2D.SimpleTree;
   import com.speedEngine.components.ui2D.TinyUI;
   import flash.events.Event;
   
   public class TreeNode extends TinyUI
   {
      
      public static var OPENINDEX:String = "openindex";
      
      private var _data:Object;
      
      private var _childData:Object;
      
      protected var _tree:SimpleTree = new SimpleTree();
      
      protected var _item:TinyUI = new TinyUI();
      
      protected var _treeContainer:TinyUI = new TinyUI();
      
      private var _before:int = 20;
      
      private var _childItemClass:Class;
      
      private var _childItemProperty:Object;
      
      private var _isOpen:Boolean = true;
      
      private var _changStateCallback:Function = null;
      
      private var _parentData:Array;
      
      private var _mIndex:int;
      
      private var _isSelect:Boolean;
      
      private var _onCallBack:Function;
      
      private var _labelFiled:String;
      
      private var _label:String;
      
      private var _transition:Object;
      
      private var _parentTree:SimpleTree;
      
      private var _isScroll:Boolean;
      
      private var _openIndex:int;
      
      public function TreeNode()
      {
         super();
         _treeContainer.addChild(_tree);
         addChild(_item);
         addChild(_treeContainer);
         before = _before;
         _item.addEventListener("added",__onAdd);
         _item.addEventListener("removed",__onRemove);
      }
      
      override public function get height() : Number
      {
         layout();
         return super.height;
      }
      
      override public function get width() : Number
      {
         return super.width;
      }
      
      public function callAllNodeFun() : void
      {
         if(_onCallBack != null)
         {
            _onCallBack.call(null);
         }
         if(_tree)
         {
            _tree.callAllNodeFun();
         }
      }
      
      protected function __onAdd(param1:Event) : void
      {
         _treeContainer.y = _item.height;
      }
      
      override public function render() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TreeNode = null;
         var _loc3_:int = 0;
         super.render();
         layout();
         if(validateDic[OPENINDEX])
         {
            if(this.parentTree)
            {
               _loc1_ = this.parentTree.size;
               switch(openIndex + 1)
               {
                  case 0:
                     _loc3_ = 0;
                     while(_loc3_ < _loc1_)
                     {
                        _loc2_ = parentTree.childrenList[_loc3_];
                        _loc2_.changState(false);
                        _loc3_++;
                     }
                     break;
                  case 1:
                     _loc3_ = 0;
                     while(_loc3_ < _loc1_)
                     {
                        _loc2_ = parentTree.childrenList[_loc3_];
                        _loc2_.changState(true);
                        _loc3_++;
                     }
                     break;
                  default:
                     _loc3_ = 0;
                     while(_loc3_ < _loc1_)
                     {
                        _loc2_ = parentTree.childrenList[_loc3_];
                        if(openIndex - 1 != _loc3_)
                        {
                           _loc2_.changState(false);
                        }
                        else if(_loc2_.tree.size > 0)
                        {
                           _loc2_.changState(true);
                        }
                        else
                        {
                           _loc2_.changState(false);
                        }
                        _loc3_++;
                     }
               }
            }
         }
      }
      
      protected function __onRemove(param1:Event) : void
      {
         _treeContainer.y = _item.height;
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function setData(param1:Object) : void
      {
         if(param1["children"] && _isOpen)
         {
            _childData = param1["children"];
            _tree.setProperty(_tree,transition);
            _tree.labelFiled = this.labelFiled;
            _tree.itemClass = _childItemClass;
            _tree.itemClassProperty = _childItemProperty;
            _tree.data = _childData as Array;
            _tree.parentNode = this;
         }
         data = param1["data"];
      }
      
      public function set data(param1:Object) : void
      {
         _data = param1;
         validate(DATA);
      }
      
      public function updateTree() : void
      {
         this.validate(STYLE);
         if(this.parentTree)
         {
            this.parentTree.updateTree();
         }
      }
      
      public function layout() : void
      {
         _treeContainer.y = _item.height;
      }
      
      override public function __onAfterProp() : void
      {
         super.__onAfterProp();
      }
      
      override public function dispose() : void
      {
         _changStateCallback = null;
         if(_item)
         {
            _item.dispose();
            if(_item.parent == this)
            {
               removeChild(_item);
            }
         }
         if(_treeContainer)
         {
            _treeContainer.dispose();
            if(_treeContainer.parent == this)
            {
               removeChild(_treeContainer);
            }
         }
         super.dispose();
         _onCallBack = null;
         _parentTree = null;
         _item.removeEventListener("added",__onAdd);
         _item.removeEventListener("removed",__onRemove);
      }
      
      public function changState(param1:Boolean) : void
      {
         if(_tree)
         {
            _isOpen = param1;
            _tree.changState(param1);
            if(_changStateCallback != null)
            {
               _changStateCallback.apply(this);
            }
            if(_isOpen)
            {
               if(_tree && _tree.data == null && _data["children"])
               {
                  _tree.setProperty(_tree,transition);
                  _tree.labelFiled = this.labelFiled;
                  _tree.itemClass = _childItemClass;
                  _tree.itemClassProperty = _childItemProperty;
                  _tree.data = _data["children"] as Array;
                  _tree.parentNode = this;
               }
               addChild(_treeContainer);
            }
            else if(_treeContainer.parent)
            {
               removeChild(_treeContainer);
            }
         }
      }
      
      public function get before() : int
      {
         return _before;
      }
      
      public function set before(param1:int) : void
      {
         _before = param1;
         _treeContainer.x = _before;
      }
      
      public function get childItemClassName() : Class
      {
         return _childItemClass;
      }
      
      public function set childItemClassName(param1:Class) : void
      {
         _childItemClass = param1;
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      public function get item() : TinyUI
      {
         return _item;
      }
      
      public function get parentData() : Array
      {
         return _parentData;
      }
      
      public function set parentData(param1:Array) : void
      {
         _parentData = param1;
      }
      
      public function get index() : int
      {
         return _mIndex;
      }
      
      public function set index(param1:int) : void
      {
         _mIndex = param1;
      }
      
      public function get isScroll() : Boolean
      {
         return _isScroll;
      }
      
      public function set isScroll(param1:Boolean) : void
      {
         _isScroll = param1;
      }
      
      public function get onCallBack() : Function
      {
         return _onCallBack;
      }
      
      public function set onCallBack(param1:Function) : void
      {
         _onCallBack = param1;
      }
      
      public function get isSelect() : Boolean
      {
         return _isSelect;
      }
      
      public function set isSelect(param1:Boolean) : void
      {
         _isSelect = param1;
      }
      
      public function get labelFiled() : String
      {
         return _labelFiled;
      }
      
      public function set labelFiled(param1:String) : void
      {
         _labelFiled = param1;
      }
      
      public function get label() : String
      {
         return data["data"][labelFiled];
      }
      
      public function set label(param1:String) : void
      {
         data["data"][labelFiled] = param1;
      }
      
      public function get childItemProperty() : Object
      {
         return _childItemProperty;
      }
      
      public function set childItemProperty(param1:Object) : void
      {
         _childItemProperty = param1;
      }
      
      public function get transition() : Object
      {
         return _transition;
      }
      
      public function set transition(param1:Object) : void
      {
         _transition = param1;
      }
      
      public function get tree() : SimpleTree
      {
         return _tree;
      }
      
      public function get parentTree() : SimpleTree
      {
         return _parentTree;
      }
      
      public function set parentTree(param1:SimpleTree) : void
      {
         _parentTree = param1;
      }
      
      public function get childData() : Object
      {
         return _childData;
      }
      
      public function get openIndex() : int
      {
         return _openIndex;
      }
      
      public function set openIndex(param1:int) : void
      {
         _openIndex = param1;
         validate(OPENINDEX);
      }
      
      public function get changStateCallback() : Function
      {
         return _changStateCallback;
      }
      
      public function set changStateCallback(param1:Function) : void
      {
         _changStateCallback = param1;
      }
   }
}

