package yishi.view.base
{
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import manager.LanguageMgr;
   import yishi.view.tips.MessageTipManager;
   
   public class GroupSelectObj extends VBox
   {
      
      private var _list:Array = [];
      
      private var _lock:int;
      
      private var _selectString:String = "";
      
      public function GroupSelectObj()
      {
         super();
      }
      
      public function set lock(param1:int) : void
      {
         _lock = param1;
      }
      
      public function addItem(param1:ISelectable) : void
      {
         _list.push(param1);
         addChild(param1 as DisplayObject);
         param1.addEventListener("select",selectHandler);
      }
      
      private function selectHandler(param1:Event) : void
      {
         var _loc7_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:ISelectable = param1.currentTarget as ISelectable;
         var _loc8_:int = _list.indexOf(_loc6_);
         var _loc3_:String = "" + _loc8_;
         var _loc4_:int = -1;
         var _loc5_:Array = _selectString != "" ? _selectString.split(",") : [];
         if(_loc5_.length == _lock)
         {
            if(_loc6_.selected)
            {
               if(_lock == 1)
               {
                  _loc7_ = _lock - 1;
                  _loc2_ = int(_loc5_[_loc7_]);
                  _loc5_[_loc7_] = _loc3_;
                  _list[_loc2_].selected = false;
               }
               else if(_lock > 1)
               {
                  _loc6_.selected = false;
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("groupSelectObj.selected.tipTxt",_lock));
                  return;
               }
            }
            else
            {
               _loc4_ = _loc5_.indexOf(_loc3_);
               if(_loc4_ != -1)
               {
                  _loc5_.splice(_loc4_,1);
               }
            }
         }
         else if(_loc6_.selected)
         {
            _loc5_.push(_loc3_);
         }
         else
         {
            _loc4_ = _loc5_.indexOf(_loc3_);
            if(_loc4_ != -1)
            {
               _loc5_.splice(_loc4_,1);
            }
         }
         _selectString = _loc5_.join(",");
         dispatchEvent(new Event("change"));
      }
      
      public function get selectString() : String
      {
         return _selectString;
      }
      
      public function set selectString(param1:String) : void
      {
         _selectString = param1;
      }
      
      override public function dispose() : void
      {
         for each(var _loc1_:ISelectable in _list)
         {
            _loc1_.removeEventListener("select",selectHandler);
            ObjectUtils.disposeObject(_loc1_);
         }
         _list = null;
         super.dispose();
      }
   }
}

