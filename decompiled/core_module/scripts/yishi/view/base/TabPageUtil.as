package yishi.view.base
{
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class TabPageUtil extends EventDispatcher
   {
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _pageFunList:Vector.<Function>;
      
      private var _pageViewList:Array;
      
      public function TabPageUtil()
      {
         super();
         init();
         initEvent();
      }
      
      private function init() : void
      {
         _btnGroup = new SelectedButtonGroup();
         _pageFunList = new Vector.<Function>();
         _pageViewList = [];
      }
      
      public function addItemPage(param1:ISelectable, param2:Function) : void
      {
         _btnGroup.addSelectItem(param1);
         _pageFunList.push(param2);
      }
      
      public function set selectIndex(param1:int) : void
      {
         if(_btnGroup)
         {
            _btnGroup.selectIndex = param1;
         }
      }
      
      public function get selectIndex() : int
      {
         if(_btnGroup == null)
         {
            return -1;
         }
         return _btnGroup.selectIndex;
      }
      
      public function get selectPage() : DisplayObject
      {
         return _pageViewList[_btnGroup.selectIndex];
      }
      
      private function initEvent() : void
      {
         if(_btnGroup)
         {
            _btnGroup.addEventListener("change",__tabChangeHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_btnGroup)
         {
            _btnGroup.removeEventListener("change",__tabChangeHandler);
         }
      }
      
      private function __tabChangeHandler(param1:Event) : void
      {
         var _loc3_:DisplayObject = null;
         var _loc5_:Function = null;
         var _loc2_:* = null;
         var _loc4_:int = 0;
         SoundManager.instance.play("022");
         _loc4_ = 0;
         while(_loc4_ < _pageFunList.length)
         {
            _loc5_ = _pageFunList[_loc4_];
            if(_loc5_ != null)
            {
               _loc3_ = _pageViewList[_loc4_];
               if(_loc4_ == _btnGroup.selectIndex)
               {
                  if(_loc3_ == null)
                  {
                     _loc3_ = _loc5_();
                     _pageViewList[_loc4_] = _loc3_;
                  }
               }
               else
               {
                  ObjectUtils.disposeObject(_loc3_);
                  _pageViewList[_loc4_] = null;
               }
            }
            _loc4_++;
         }
         dispatchEvent(new Event("change"));
      }
      
      public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:DisplayObject in _pageViewList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         _pageFunList = null;
      }
   }
}

