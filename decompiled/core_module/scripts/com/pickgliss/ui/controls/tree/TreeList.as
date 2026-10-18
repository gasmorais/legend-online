package com.pickgliss.ui.controls.tree
{
   import com.pickgliss.ui.controls.DisplayObjectViewport;
   import com.pickgliss.ui.controls.cell.ITreeListCell;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.MouseEvent;
   
   [Event(name="TreeDataEvent.ITEM_CLICK",type="com.pickgliss.ui.controls.tree.TreeDataEvent")]
   internal class TreeList extends DisplayObjectViewport
   {
      
      public static const P_render:String = "render";
      
      public static const P_cellChange:String = "cellChange";
      
      public static const P_cellMinHeight:String = "cellMinHeight";
      
      protected var _cells:Vector.<ITreeListCell> = new Vector.<ITreeListCell>();
      
      protected var _cellContainer:Component;
      
      protected var _array:Array;
      
      protected var _startIndex:int;
      
      protected var _selectItem:TreeNode;
      
      protected var _cellMinH:int;
      
      protected var _cellStyle:String;
      
      protected var _cellNum:int = 0;
      
      public function TreeList()
      {
         super();
         _cellContainer = new Component();
         setView(_cellContainer);
      }
      
      public function get cellStyle() : String
      {
         return _cellStyle;
      }
      
      public function set cellStyle(param1:String) : void
      {
         if(_cellStyle != param1)
         {
            _cellStyle = param1;
            onPropertiesChanged("cellChange");
         }
      }
      
      public function get array() : Array
      {
         return _array;
      }
      
      public function set array(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         _array = param1 || [];
         _viewHeight = 0;
         var _loc2_:int = 2147483647;
         _loc4_ = 0;
         _loc3_ = int(param1.length);
         while(_loc4_ < _loc3_)
         {
            _loc2_ = Math.min(_loc2_,param1[_loc4_].height);
            _viewHeight += param1[_loc4_].height;
            _loc4_++;
         }
         if(_cellContainer.height != _viewHeight)
         {
            _cellContainer.height = _viewHeight;
         }
         if(_cellMinH != _loc2_)
         {
            _cellMinH = _loc2_;
            onPropertiesChanged("cellMinHeight");
         }
         resetStartIndex(true);
      }
      
      public function resetStartIndex(param1:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(_array)
         {
            _loc3_ = 0;
            _loc4_ = 0;
            _loc2_ = int(_array.length);
            while(_loc4_ < _loc2_ && _loc3_ < _viewPosition.y)
            {
               _loc3_ += _array[_loc4_].height;
               _loc4_++;
            }
            _loc5_ = _loc4_ == 0 ? 0 : _loc4_ - 1;
            if(_loc5_ != _startIndex || param1)
            {
               _startIndex = _loc5_;
               renderItems();
            }
         }
      }
      
      public function refresh() : void
      {
         onPropertiesChanged("render");
      }
      
      public function get selectItem() : TreeNode
      {
         return _selectItem;
      }
      
      public function set selectItem(param1:TreeNode) : void
      {
         var _loc2_:int = 0;
         if(_selectItem != param1)
         {
            if(_selectItem)
            {
               _loc2_ = _selectItem.tag - _startIndex;
               if(_loc2_ > 0 && _loc2_ < _cells.length)
               {
                  _cells[_loc2_].setCellSelectStatus(false);
               }
            }
            _selectItem = param1;
            if(_selectItem)
            {
               _loc2_ = _selectItem.tag - _startIndex;
               if(_loc2_ > 0 && _loc2_ < _cells.length)
               {
                  _cells[_loc2_].setCellSelectStatus(true);
               }
            }
         }
      }
      
      protected function getCellObject() : ITreeListCell
      {
         if(_cellStyle)
         {
            return ClassUtils.CreatInstance(_cellStyle);
         }
         return null;
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["width"])
         {
            _cellContainer.width = _width;
         }
         if(_changedPropeties["cellChange"])
         {
            changeCells(true);
            renderItems();
         }
         else if(_changedPropeties["cellMinHeight"])
         {
            changeCells(false);
         }
         if(_changedPropeties["viewPosition"])
         {
            resetStartIndex();
         }
         else if(_changedPropeties["render"])
         {
            renderItems();
         }
      }
      
      protected function changeCells(param1:Boolean) : void
      {
         var _loc2_:ITreeListCell = null;
         if(param1)
         {
            while(_cells.length > 0)
            {
               _loc2_ = _cells.pop();
               removeCell(_loc2_);
            }
            _cellNum = 0;
         }
         var _loc3_:int = Math.round(_height / _cellMinH) + 2;
         _cellContainer.width = _width;
         if(_cellNum == _loc3_)
         {
            return;
         }
         if(_cellNum > _loc3_)
         {
            while(_cells.length != _loc3_)
            {
               _loc2_ = _cells.pop();
               removeCell(_loc2_);
            }
         }
         else
         {
            while(_cells.length != _loc3_)
            {
               _loc2_ = getCellObject();
               addCell(_loc2_);
               _cellContainer.addChild(_loc2_ as DisplayObject);
            }
         }
         _cellNum = _loc3_;
      }
      
      protected function renderItems() : void
      {
         var _loc5_:int = 0;
         var _loc7_:ITreeListCell = null;
         var _loc1_:TreeNode = null;
         var _loc3_:ScaleFrameImage = null;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         _loc6_ = 0;
         while(_loc6_ < _startIndex)
         {
            _loc4_ += _array[_loc6_].height;
            _loc6_++;
         }
         _loc6_ = 0;
         _loc2_ = int(_cells.length);
         while(_loc6_ < _loc2_)
         {
            _loc7_ = _cells[_loc6_];
            _loc5_ = _startIndex + _loc6_;
            _loc3_ = _loc7_.arrow;
            if(_array && _loc5_ < _array.length)
            {
               _loc1_ = _array[_loc5_];
               _loc7_.x = _viewPosition.x;
               _loc7_.y = _loc4_;
               _loc4_ += _array[_loc5_].height;
               _loc1_.tag = _loc5_;
               if(_loc3_ != null)
               {
                  if(_loc1_.hasChild)
                  {
                     (_loc7_ as DisplayObjectContainer).addChild(_loc3_);
                     _loc3_.setFrame(_loc1_.isOpen ? 2 : 1);
                     _loc7_.container.x = _loc3_.width + _loc1_.left;
                  }
                  else
                  {
                     ObjectUtils.removeFromParent(_loc3_);
                     _loc7_.container.x = _loc1_.left;
                  }
                  _loc7_.arrow.x = _loc1_.left;
               }
               else
               {
                  _loc7_.container.x = _loc1_.left;
               }
               _loc7_.setCellValue(_array[_loc5_]);
               _loc7_.setCellSelectStatus(_loc1_ == _selectItem);
               _loc7_.visible = true;
            }
            else
            {
               _loc7_.x = _viewPosition.x;
               _loc7_.y = _loc4_;
               _loc4_ += _cellMinH;
               ObjectUtils.removeFromParent(_loc3_);
               _loc7_.container.x = 0;
               _loc7_.setCellValue(null);
               _loc7_.setCellSelectStatus(false);
               _loc7_.visible = false;
            }
            _loc6_++;
         }
      }
      
      protected function onCellMouse(param1:MouseEvent) : void
      {
         var _loc3_:ITreeListCell = param1.currentTarget as ITreeListCell;
         var _loc2_:int = _startIndex + _cells.indexOf(_loc3_);
         if(param1.type == "rollOver" || param1.type == "rollOut")
         {
            _loc3_.setCellOverStatus(param1.type == "rollOver");
         }
         else
         {
            _loc3_.setCellOverStatus(false);
         }
         if(param1.type == "click")
         {
            if(hasEventListener("TreeDataEvent.ITEM_CLICK"))
            {
               dispatchEvent(new TreeDataEvent("TreeDataEvent.ITEM_CLICK",_loc3_));
            }
         }
      }
      
      protected function addCell(param1:ITreeListCell) : ITreeListCell
      {
         param1.addEventListener("click",onCellMouse);
         param1.addEventListener("rollOver",onCellMouse);
         param1.addEventListener("rollOut",onCellMouse);
         if(_cells.indexOf(param1) == -1)
         {
            _cells.push(param1);
         }
         return param1;
      }
      
      private function removeCell(param1:ITreeListCell) : ITreeListCell
      {
         param1.removeEventListener("click",onCellMouse);
         param1.removeEventListener("rollOver",onCellMouse);
         param1.removeEventListener("rollOut",onCellMouse);
         ObjectUtils.disposeObject(param1);
         return param1;
      }
      
      override public function dispose() : void
      {
         var _loc1_:ITreeListCell = null;
         if(_cells)
         {
            while(_cells.length > 0)
            {
               _loc1_ = _cells.pop();
               removeCell(_loc1_);
            }
            _cells = null;
         }
         _array = null;
         _cellContainer = null;
         super.dispose();
      }
   }
}

