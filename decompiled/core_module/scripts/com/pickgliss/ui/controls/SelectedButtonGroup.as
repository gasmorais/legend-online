package com.pickgliss.ui.controls
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class SelectedButtonGroup extends EventDispatcher implements Disposeable
   {
      
      private var _canUnSelect:Boolean;
      
      private var _currentSelecetdIndex:int = -1;
      
      private var _items:Vector.<ISelectable>;
      
      private var _lastSelectedButton:ISelectable;
      
      private var _mutiSelectCount:int;
      
      public function SelectedButtonGroup(param1:Boolean = false, param2:int = 1)
      {
         super();
         _mutiSelectCount = param2;
         _canUnSelect = param1;
         _items = new Vector.<ISelectable>();
      }
      
      public function addSelectItem(param1:ISelectable) : void
      {
         param1.addEventListener("click",__onItemClicked);
         param1.autoSelect = false;
         _items.push(param1);
      }
      
      public function removeAllItem() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _items.length)
         {
            _items[_loc1_].removeEventListener("click",__onItemClicked);
            _items[_loc1_].selected = false;
            _loc1_++;
         }
         _items.splice(0,_items.length);
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _items.length)
         {
            removeItemByIndex(0);
         }
         lastSelectedButton = null;
         _items = null;
      }
      
      public function getSelectIndexByItem(param1:ISelectable) : int
      {
         return _items.indexOf(param1);
      }
      
      public function getSelectedItem() : ISelectable
      {
         if(selectIndex == -1)
         {
            return null;
         }
         return _items[selectIndex];
      }
      
      public function get itemLength() : int
      {
         return _items.length;
      }
      
      public function removeItemByIndex(param1:int) : void
      {
         if(param1 != -1)
         {
            _items[param1].removeEventListener("click",__onItemClicked);
            ObjectUtils.disposeObject(_items[param1]);
            _items.splice(param1,1);
         }
      }
      
      public function removeSelectItem(param1:ISelectable) : void
      {
         var _loc2_:int = _items.indexOf(param1);
         removeItemByIndex(_loc2_);
      }
      
      public function get selectIndex() : int
      {
         return _items.indexOf(lastSelectedButton);
      }
      
      public function getIndexByItem(param1:ISelectable) : int
      {
         return _items.indexOf(param1);
      }
      
      public function set selectIndex(param1:int) : void
      {
         var _loc3_:ISelectable = null;
         var _loc2_:Boolean = _currentSelecetdIndex != param1;
         if(param1 == -1)
         {
            if(lastSelectedButton && selectedCount == _mutiSelectCount)
            {
               lastSelectedButton.selected = false;
            }
            _currentSelecetdIndex = param1;
            lastSelectedButton = null;
         }
         else
         {
            _loc3_ = _items[param1];
            if(!_loc3_.selected)
            {
               if(lastSelectedButton && selectedCount == _mutiSelectCount)
               {
                  lastSelectedButton.selected = false;
               }
               _loc3_.selected = true;
               _currentSelecetdIndex = param1;
               lastSelectedButton = _loc3_;
            }
            else if(_canUnSelect)
            {
               _loc3_.selected = false;
            }
         }
         if(_loc2_)
         {
            dispatchEvent(new Event("change"));
         }
      }
      
      public function get selectedCount() : int
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _items.length)
         {
            if(_items[_loc2_].selected)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function set selectedCount(param1:int) : void
      {
         _mutiSelectCount = param1;
      }
      
      private function __onItemClicked(param1:Event) : void
      {
         param1.stopPropagation();
         var _loc2_:ISelectable = param1.currentTarget as ISelectable;
         selectIndex = _items.indexOf(_loc2_);
      }
      
      public function get lastSelectedButton() : ISelectable
      {
         return _lastSelectedButton;
      }
      
      public function set lastSelectedButton(param1:ISelectable) : void
      {
         _lastSelectedButton = param1;
      }
   }
}

