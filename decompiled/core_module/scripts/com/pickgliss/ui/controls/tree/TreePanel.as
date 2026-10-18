package com.pickgliss.ui.controls.tree
{
   import avmplus.getQualifiedClassName;
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   
   [Event(name="TreeDataEvent.ITEM_OPEN",type="com.pickgliss.ui.controls.tree.TreeDataEvent")]
   [Event(name="TreeDataEvent.ITEM_SELECT",type="com.pickgliss.ui.controls.tree.TreeDataEvent")]
   public class TreePanel extends ScrollPanel
   {
      
      public static const P_spaceLeft:String = "spaceLeft";
      
      public static const P_cellHeight:String = "cellHeight";
      
      protected var _tree:TreeList = null;
      
      protected var _treeData:TreeNode = null;
      
      protected var _source:Array = [];
      
      protected var _autoCloseOther:Boolean = true;
      
      protected var _autoSelectFirst:Boolean = false;
      
      protected var _autoScrollTop:Boolean = true;
      
      protected var _spaceL:String = "0";
      
      protected var _spaceLeft:Array = [0];
      
      protected var _cellH:String = "0";
      
      protected var _cellHeight:Array = [0];
      
      public function TreePanel()
      {
         super(false);
         viewPort = _tree = new TreeList();
         _tree.addEventListener("TreeDataEvent.ITEM_CLICK",__itemClickHandler);
      }
      
      override public function dispose() : void
      {
         _tree.removeEventListener("TreeDataEvent.ITEM_CLICK",__itemClickHandler);
         _tree = null;
         ObjectUtils.disposeObject(_treeData);
         _treeData = null;
         if(_source)
         {
            _source.length = 0;
            _source = null;
         }
         super.dispose();
      }
      
      public function get treeData() : TreeNode
      {
         return _treeData;
      }
      
      public function set treeData(param1:TreeNode) : void
      {
         var _loc3_:TreeNode = null;
         if(_treeData != param1)
         {
            ObjectUtils.disposeObject(_treeData);
         }
         _treeData = param1;
         _tree.selectItem = null;
         _source.length = 0;
         TreeUtils.parseTree(param1,_source);
         if(_autoSelectFirst)
         {
            _loc3_ = selectFirst(_source[0]);
         }
         var _loc2_:Array = TreeUtils.getArray(_source,_spaceLeft,_cellHeight);
         _tree.array = _loc2_;
         if(_autoSelectFirst)
         {
            _tree.selectItem = _loc3_;
            sendEvent(TreeDataEvent,"TreeDataEvent.ITEM_SELECT",_loc3_);
         }
      }
      
      public function refresh() : void
      {
         _tree.refresh();
      }
      
      public function get autoCloseOther() : Boolean
      {
         return _autoCloseOther;
      }
      
      public function set autoCloseOther(param1:Boolean) : void
      {
         _autoCloseOther = param1;
      }
      
      public function get autoSelectFirst() : Boolean
      {
         return _autoSelectFirst;
      }
      
      public function set autoSelectFirst(param1:Boolean) : void
      {
         _autoSelectFirst = param1;
      }
      
      public function get autoScrollTop() : Boolean
      {
         return _autoScrollTop;
      }
      
      public function set autoScrollTop(param1:Boolean) : void
      {
         _autoScrollTop = param1;
      }
      
      public function get spaceLeft() : String
      {
         return _spaceL;
      }
      
      public function set spaceLeft(param1:String) : void
      {
         var _loc4_:int = 0;
         var _loc3_:TreeNode = null;
         var _loc6_:int = 0;
         if(_spaceL == param1)
         {
            return;
         }
         _spaceL = param1;
         _spaceLeft = _spaceL.split(",");
         for(var _loc5_ in _spaceLeft)
         {
            _spaceLeft[_loc5_] = int(_spaceLeft[_loc5_]);
         }
         var _loc2_:Array = _tree.array;
         if(_loc2_)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc2_.length)
            {
               _loc3_ = _loc2_[_loc6_];
               _loc4_ = TreeUtils.getDepth(_loc3_);
               if(_loc4_ == 0)
               {
                  _loc3_.left = 0;
               }
               else if(spaceLeft[_loc4_] != null)
               {
                  _loc3_.left = spaceLeft[_loc4_];
               }
               else
               {
                  _loc3_.left = spaceLeft[0] * _loc4_;
               }
               _loc6_++;
            }
         }
         onPropertiesChanged("spaceLeft");
      }
      
      public function get cellHeight() : String
      {
         return _cellH;
      }
      
      public function set cellHeight(param1:String) : void
      {
         if(_cellH == param1)
         {
            return;
         }
         _cellH = param1;
         _cellHeight = _cellH.split(",");
         for(var _loc2_ in _cellHeight)
         {
            _cellHeight[_loc2_] = int(_cellHeight[_loc2_]);
         }
         onPropertiesChanged("cellHeight");
      }
      
      public function get cellStyle() : String
      {
         return _tree.cellStyle;
      }
      
      public function set cellStyle(param1:String) : void
      {
         _tree.cellStyle = param1;
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["cellHeight"])
         {
            if(_source)
            {
               _tree.array = TreeUtils.getArray(_source,_spaceLeft,_cellHeight);
            }
            else
            {
               _tree.resetStartIndex(true);
            }
         }
         else if(_changedPropeties["spaceLeft"])
         {
            _tree.refresh();
         }
      }
      
      private function __itemClickHandler(param1:TreeDataEvent) : void
      {
         var _loc2_:TreeNode = null;
         var _loc5_:TreeNode = null;
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc4_:Array = null;
         var _loc8_:IntPoint = null;
         if(param1.params.getCellValue())
         {
            _loc2_ = param1.params.getCellValue();
            if(_loc2_.hasChild)
            {
               _loc2_.isOpen = !_loc2_.isOpen;
               if(_loc2_.isOpen)
               {
                  _loc5_ = _loc2_;
                  if(_autoSelectFirst)
                  {
                     _loc5_ = selectFirst(_loc5_);
                     if(_autoCloseOther)
                     {
                        closeOther(_loc5_.nodeParent);
                     }
                  }
                  else if(_autoCloseOther)
                  {
                     closeOther(_loc5_.nodeParent);
                  }
                  _tree.array = TreeUtils.getArray(_source,_spaceLeft,_cellHeight);
                  if(_autoSelectFirst)
                  {
                     if(!(_tree.selectItem && _tree.selectItem.nodeParent == _loc5_.nodeParent))
                     {
                        _tree.selectItem = _loc5_;
                        sendEvent(TreeDataEvent,"TreeDataEvent.ITEM_SELECT",_loc5_);
                     }
                  }
               }
               else
               {
                  _tree.array = TreeUtils.getArray(_source,_spaceLeft,_cellHeight);
               }
               sendEvent(TreeDataEvent,"TreeDataEvent.ITEM_OPEN",_loc2_);
               if(_loc2_.isOpen && _autoScrollTop)
               {
                  _loc6_ = 0;
                  _loc4_ = _tree.array;
                  _loc7_ = 0;
                  _loc3_ = int(_loc4_.length);
                  while(_loc7_ < _loc3_)
                  {
                     if(_loc4_[_loc7_] == _loc2_)
                     {
                        break;
                     }
                     _loc6_ += _loc4_[_loc7_].height;
                     _loc7_++;
                  }
                  _loc8_ = new IntPoint(_tree.viewPosition.x,_loc6_);
                  _tree.viewPosition = _loc8_;
               }
            }
            else
            {
               _tree.selectItem = _loc2_;
               sendEvent(TreeDataEvent,"TreeDataEvent.ITEM_SELECT",_loc2_);
            }
         }
      }
      
      private function selectFirst(param1:TreeNode) : TreeNode
      {
         if(param1 != null)
         {
            while(param1.hasChild)
            {
               param1.isOpen = true;
               param1 = param1.children()[0];
            }
         }
         return param1;
      }
      
      private function closeOther(param1:TreeNode) : void
      {
         var _loc2_:TreeNode = null;
         var _loc3_:* = undefined;
         if(param1 != null)
         {
            _loc2_ = param1.nodeParent;
            if(_loc2_ != null)
            {
               _loc3_ = _loc2_.children();
               for each(var _loc4_:TreeNode in _loc3_)
               {
                  if(_loc4_ != null && _loc4_ != param1)
                  {
                     _loc4_.isOpen = false;
                  }
               }
               closeOther(_loc2_);
            }
         }
      }
      
      private function sendEvent(param1:Class, ... rest) : void
      {
         var _loc3_:String = null;
         if(hasEventListener(rest[0]))
         {
            _loc3_ = getQualifiedClassName(param1);
            dispatchEvent(ClassUtils.CreatInstance(_loc3_,rest));
         }
      }
   }
}

