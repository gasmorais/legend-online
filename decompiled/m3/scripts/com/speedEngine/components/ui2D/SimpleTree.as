package com.speedEngine.components.ui2D
{
   import com.speedEngine.components.ui2D.controls.ScrollbarView;
   import com.speedEngine.components.ui2D.controls.TreeNode;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   
   public class SimpleTree extends TinyUI
   {
      
      public static var SCROLL:String = "scroll";
      
      private var _gap:int = 5;
      
      private var _itemClassName:Class;
      
      private var _itemClassProperty:Object;
      
      private var _texture:BitmapData;
      
      private var _selectItem:TreeNode;
      
      private var _labelFiled:String = "label";
      
      private var _isScroll:Boolean = false;
      
      private var _scrollBar:NewScrollBar;
      
      private var _scrollProperty:Object;
      
      private var _data:Array;
      
      private var _container:TinyUI = new TinyUI();
      
      private var _childrenList:Vector.<TreeNode> = new Vector.<TreeNode>(0);
      
      private var _scrollWidth:int;
      
      private var _scrollHeight:int;
      
      private var _openTreeNumber:int = 0;
      
      private var _levels:int = 0;
      
      private var _parentNode:TreeNode;
      
      private var _isOpen:Boolean;
      
      protected var _bg:SimpleImage;
      
      protected var _rootTree:SimpleTree;
      
      public function SimpleTree()
      {
         super();
         changState(true);
      }
      
      public function setData(param1:Array, param2:String = "ID", param3:String = "parentID") : void
      {
         var _loc5_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc6_:Array = [];
         var _loc4_:int = int(param1.length);
         var _loc7_:Object = {};
         _loc9_ = 0;
         while(_loc9_ < _loc4_)
         {
            _loc5_ = int(param1[_loc9_][param2]);
            _loc8_ = int(param1[_loc9_][param3]);
            _loc7_[_loc5_] = {};
            _loc7_[_loc5_]["data"] = param1[_loc9_]["data"];
            _loc7_[_loc5_][param3] = _loc8_;
            _loc9_++;
         }
         _loc9_ = 0;
         while(_loc9_ < _loc4_)
         {
            _loc8_ = int(param1[_loc9_][param3]);
            _loc5_ = int(param1[_loc9_][param2]);
            if(_loc8_ != -1)
            {
               if(!_loc7_[_loc8_]["children"])
               {
                  _loc7_[_loc8_]["children"] = [];
               }
               _loc7_[_loc8_]["children"].push(_loc7_[_loc5_]);
            }
            _loc9_++;
         }
         _loc9_ = 0;
         while(_loc9_ < _loc4_)
         {
            if(_loc7_[_loc9_] == null)
            {
               throw Error(param2 + "不连续，请检{invalid_utf8=230}{invalid_utf8=159}?" + param2 + "是否是从0{invalid_utf8=229}{invalid_utf8=188}?始连续的数字");
            }
            if(_loc7_[_loc9_][param3] == -1)
            {
               _loc6_.push(_loc7_[_loc9_]);
            }
            delete _loc7_[_loc9_][param3];
            _loc9_++;
         }
         data = _loc6_;
      }
      
      override public function getBoundRect(param1:DisplayObject = null) : Rectangle
      {
         var _loc2_:Rectangle = super.getBoundRect(param1);
         if(_isScroll)
         {
            _loc2_.width = _scrollWidth;
            _loc2_.height = _scrollHeight;
         }
         return _loc2_;
      }
      
      override public function getMaxHeight() : Number
      {
         return super.getBoundRect(this).height;
      }
      
      override public function getMaxWidth() : Number
      {
         return super.getBoundRect(this).width;
      }
      
      override public function render() : void
      {
         super.render();
         if(validateDic[DATA] || validateDic[STYLE])
         {
            layout();
            if(_scrollBar)
            {
               _scrollBar.refreshView();
            }
            if(!_rootTree)
            {
               if(this._parentNode)
               {
                  _rootTree = this._parentNode.tree;
               }
               else
               {
                  _rootTree = this;
               }
            }
         }
         if(validateDic[SCROLL])
         {
            if(isScroll)
            {
               setProperty(_scrollBar,_scrollProperty);
            }
         }
      }
      
      public function swapNodeData(param1:Object, param2:Object) : void
      {
         var _loc3_:TreeNode = getNodeByData(param1);
         var _loc4_:TreeNode = getNodeByData(param2);
         if(_loc3_ && _loc4_)
         {
            swapNode(_loc3_,_loc4_);
         }
      }
      
      public function swapNode(param1:TreeNode, param2:TreeNode) : void
      {
         var _loc8_:* = null;
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:SimpleTree = param1.parentTree;
         var _loc6_:SimpleTree = param2.parentTree;
         var _loc9_:int = _loc4_.childrenList.indexOf(param1);
         var _loc3_:int = _loc6_.childrenList.indexOf(param2);
         if(_loc9_ > -1 && _loc3_ > -1)
         {
            _loc4_.addNodeData(param2.data);
            _loc4_.addNodeData(param1.data);
            _loc4_.removeNode(param1);
            _loc6_.removeNode(param2);
         }
      }
      
      public function setProperty(param1:Object, param2:Object) : void
      {
         if(!param1 || !param2)
         {
            return;
         }
         for(var _loc3_:String in param2)
         {
            if(param1.hasOwnProperty(_loc3_))
            {
               param1[_loc3_] = param2[_loc3_];
            }
         }
      }
      
      public function changState(param1:Boolean) : void
      {
         _isOpen = param1;
         if(param1)
         {
            openTree();
         }
         else
         {
            closeTree();
         }
         updateTree();
      }
      
      public function updateTree() : void
      {
         if(this.parentNode)
         {
            this.parentNode.updateTree();
         }
         validate(STYLE);
      }
      
      public function callAllNodeFun() : void
      {
         var _loc3_:TreeNode = null;
         var _loc2_:int = 0;
         var _loc1_:int = _container.numChildren;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = _container.getChildAt(_loc2_) as TreeNode;
            _loc3_.callAllNodeFun();
            _loc2_++;
         }
      }
      
      protected function layout() : void
      {
         var _loc4_:TreeNode = null;
         var _loc3_:int = 0;
         var _loc1_:int = _container.numChildren;
         if(_container.parent != this)
         {
            _loc1_ = 0;
         }
         var _loc2_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc4_ = _container.getChildAt(_loc3_) as TreeNode;
            _loc4_.x = 0;
            _loc4_.y = _loc2_;
            _loc2_ += _loc4_.height + _gap;
            _loc3_++;
         }
      }
      
      protected function openTree() : void
      {
         _container.visible = true;
         addChild(_container);
         if(_scrollBar)
         {
            _scrollBar.view = this;
         }
      }
      
      protected function closeTree() : void
      {
         _container.visible = false;
         if(_container.parent == this)
         {
            removeChild(_container);
            if(_scrollBar)
            {
               _scrollBar.view = null;
            }
         }
      }
      
      override public function __onAfterProp() : void
      {
         super.__onAfterProp();
      }
      
      public function addNodeData(param1:Object, param2:int = -1, param3:Boolean = true) : TreeNode
      {
         var _loc4_:Class = null;
         var _loc5_:TreeNode = null;
         _loc4_ = _itemClassName;
         _loc5_ = new _loc4_();
         setProperty(_loc5_,itemClassProperty);
         if(_loc5_ is TreeNode)
         {
            if(!_loc5_.childItemClassName)
            {
               _loc5_.childItemClassName = _itemClassName;
            }
            if(!_loc5_.childItemProperty)
            {
               _loc5_.childItemProperty = itemClassProperty;
            }
            _loc5_.transition = {
               "levels":levels + 1,
               "scrollProperty":scrollProperty
            };
            _loc5_.labelFiled = labelFiled;
            _loc5_.index = _childrenList.length;
            _loc5_.parentData = data;
            _loc5_.setData(param1);
            _loc5_.parentTree = this;
            addNode(_loc5_,param2,param3);
            return _loc5_;
         }
         throw new Error("item必须是TreeNode或继承TreeeNode");
      }
      
      public function removeNodeData(param1:Object) : TreeNode
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc4_:TreeNode = getNodeByData(param1);
         if(_loc4_ != null)
         {
            removeNode(_loc4_);
         }
         return _loc4_;
      }
      
      public function getNodeByData(param1:Object) : TreeNode
      {
         var _loc4_:int = 0;
         var _loc3_:int = data.indexOf(param1);
         var _loc5_:TreeNode = null;
         var _loc2_:int = 0;
         if(_loc3_ > -1)
         {
            return _childrenList[_loc3_];
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc5_ = _childrenList[_loc4_].tree.getNodeByData(param1);
            _loc4_++;
         }
         return _loc5_;
      }
      
      public function removeNode(param1:TreeNode) : void
      {
         var _loc2_:SimpleTree = param1.parentTree;
         var _loc3_:int = _loc2_.childrenList.indexOf(param1);
         if(_loc3_ > -1)
         {
            _loc2_._container.removeChild(param1);
            _loc2_.childrenList.splice(_loc3_,1);
            _loc2_.data.splice(_loc3_,1);
            param1.dispose();
         }
         _loc2_.validate(STYLE);
      }
      
      public function addNode(param1:TreeNode, param2:int = -1, param3:Boolean = true) : void
      {
         if(_childrenList.indexOf(param1) < 0)
         {
            if(param2 < 0)
            {
               _childrenList.push(param1);
               _container.addChild(param1);
               _data.push(param1.data);
               param1.index = _childrenList.length;
            }
            else
            {
               _childrenList.splice(param2,0,param1);
               _container.addChildAt(param1,param2);
               _data.splice(param2,0,param1.data);
               param1.index = param2;
            }
         }
         if(param3)
         {
            validate(STYLE);
         }
      }
      
      override public function dispose() : void
      {
         if(_container)
         {
            _container.dispose();
            if(_container.parent == this)
            {
               removeChild(_container);
            }
            _container.removeChildren();
            _childrenList.splice(0,_childrenList.length);
            if(_data)
            {
               _data.splice(0,data.length);
            }
         }
         if(_scrollBar)
         {
            _scrollBar.dispose();
            _scrollBar = null;
         }
         super.dispose();
         _rootTree = null;
         _parentNode = null;
         _selectItem = null;
      }
      
      override public function addChild(param1:DisplayObject) : DisplayObject
      {
         return super.addChild(param1);
      }
      
      override public function removeChild(param1:DisplayObject) : DisplayObject
      {
         return super.removeChild(param1);
      }
      
      public function get gap() : int
      {
         return _gap;
      }
      
      public function set gap(param1:int) : void
      {
         _gap = param1;
      }
      
      public function get data() : Array
      {
         return _data;
      }
      
      public function set data(param1:Array) : void
      {
         var _loc3_:int = 0;
         if(_data == param1)
         {
            return;
         }
         _data = param1;
         _container.dispose();
         _container.removeChildren();
         _childrenList.length = 0;
         var _loc2_:int = int(_data.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            addNodeData(_data[_loc3_],-1,false);
            _loc3_++;
         }
         validate(DATA);
      }
      
      public function get itemClass() : Class
      {
         return _itemClassName;
      }
      
      public function set itemClass(param1:Class) : void
      {
         _itemClassName = param1;
      }
      
      public function get texture() : BitmapData
      {
         return _texture;
      }
      
      public function set texture(param1:BitmapData) : void
      {
         _texture = param1;
         if(_texture)
         {
            if(!_bg)
            {
               _bg = new SimpleImage();
            }
            _bg.texture = _texture;
            addChildAt(_bg,0);
         }
         pushDisposeBitmap(param1);
      }
      
      public function get selectItem() : TreeNode
      {
         if(_rootTree == this)
         {
            return _selectItem;
         }
         return _rootTree.selectItem;
      }
      
      public function set selectItem(param1:TreeNode) : void
      {
         if(_rootTree.selectItem)
         {
            _rootTree.selectItem.isSelect = false;
         }
         if(_rootTree == this)
         {
            _selectItem = param1;
            _selectItem.isSelect = true;
         }
         else
         {
            _rootTree.selectItem = param1;
            _rootTree.selectItem.isSelect = true;
         }
      }
      
      public function get labelFiled() : String
      {
         return _labelFiled;
      }
      
      public function set labelFiled(param1:String) : void
      {
         _labelFiled = param1;
      }
      
      public function get itemClassProperty() : Object
      {
         return _itemClassProperty;
      }
      
      public function set itemClassProperty(param1:Object) : void
      {
         _itemClassProperty = param1;
      }
      
      public function get childrenList() : Vector.<TreeNode>
      {
         return _childrenList;
      }
      
      public function get isScroll() : Boolean
      {
         return _isScroll;
      }
      
      public function set isScroll(param1:Boolean) : void
      {
         validate(SCROLL);
         _isScroll = param1;
         if(_isScroll && !_scrollBar)
         {
            _scrollBar = new NewScrollBar();
            _scrollBar.barView = new ScrollbarView();
            setProperty(_scrollBar,_scrollProperty);
            _scrollBar.view = this;
         }
      }
      
      override public function set height(param1:Number) : void
      {
         super.height = param1;
         validate(SCROLL);
      }
      
      override public function set width(param1:Number) : void
      {
         super.width = param1;
         validate(SCROLL);
      }
      
      public function get scrollProperty() : Object
      {
         return _scrollProperty;
      }
      
      public function set scrollProperty(param1:Object) : void
      {
         _scrollProperty = param1;
         validate(SCROLL);
      }
      
      public function get scrollWidth() : int
      {
         return _scrollWidth;
      }
      
      public function set scrollWidth(param1:int) : void
      {
         if(_isScroll)
         {
            _scrollWidth = param1;
            _scrollBar.showWidth = this.scrollWidth != 0 ? this.scrollWidth : this.width;
            validate(SCROLL);
         }
      }
      
      public function get scrollHeight() : int
      {
         return _scrollHeight;
      }
      
      public function set scrollHeight(param1:int) : void
      {
         if(_isScroll)
         {
            _scrollHeight = param1;
            _scrollBar.showHeight = this.scrollHeight;
            validate(SCROLL);
         }
      }
      
      public function get levels() : int
      {
         return _levels;
      }
      
      public function set levels(param1:int) : void
      {
         _levels = param1;
      }
      
      public function get size() : int
      {
         return _childrenList.length;
      }
      
      public function get parentNode() : TreeNode
      {
         return _parentNode;
      }
      
      public function set parentNode(param1:TreeNode) : void
      {
         _parentNode = param1;
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      public function get rootTree() : SimpleTree
      {
         return _rootTree;
      }
   }
}

