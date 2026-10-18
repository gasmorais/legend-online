package stelesys.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import stelesys.item.StelesysBackBoxItem;
   import stelesys.item.StelesysBaseBoxItem;
   
   public class StelesysIntensifyBagView extends StelesysBagView
   {
      
      private var _metrialItemList:Array = [];
      
      public function StelesysIntensifyBagView()
      {
         super();
      }
      
      public function refreshViewII(param1:Array, param2:Array) : void
      {
         _bagList.beginChanges();
         removeAllChildFromBagList();
         freshMetrial(param1);
         refreshView(param2);
         _bagList.commitChanges();
         _bagPanel.invalidateViewport();
         if(_stateTxt)
         {
            if(_bagList.numChildren == 0)
            {
               _stateTxt.visible = true;
            }
            else
            {
               _stateTxt.visible = false;
            }
         }
      }
      
      public function opUpdate() : void
      {
         var _loc2_:StelesysBaseBoxItem = null;
         var _loc3_:int = 0;
         var _loc1_:int = int(_bagList.numChildren);
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = _bagList.getChildAt(_loc3_) as StelesysBaseBoxItem;
            if(_loc2_)
            {
               _loc2_.opUpdate();
            }
            _loc3_++;
         }
      }
      
      public function get useMetrial() : String
      {
         var _loc2_:StelesysBackBoxItem = null;
         var _loc4_:int = 0;
         var _loc3_:int = int(_metrialItemList.length);
         var _loc1_:String = "";
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _metrialItemList[_loc4_];
            if(_loc2_.parent && _loc2_.data && _loc2_.useCount > 0)
            {
               if(_loc1_ == "")
               {
                  _loc1_ += _loc2_.data.id + "," + _loc2_.useCount;
               }
               else
               {
                  _loc1_ += "|" + _loc2_.data.id + "," + _loc2_.useCount;
               }
            }
            _loc4_++;
         }
         return _loc1_;
      }
      
      private function freshMetrial(param1:Array) : void
      {
         var _loc2_:StelesysBaseBoxItem = null;
         var _loc5_:int = 0;
         if(param1 == null || param1.length == 0)
         {
            return;
         }
         var _loc4_:int = int(_metrialItemList.length);
         var _loc3_:int = int(param1.length);
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            if(_loc5_ >= _loc4_)
            {
               _loc2_ = ComponentFactory.Instance.creatCustomObject("stelesys.cls.StelesysBackBoxItem");
               _metrialItemList.push(_loc2_);
            }
            else
            {
               _loc2_ = _metrialItemList[_loc5_];
            }
            _loc2_.data = param1[_loc5_];
            _bagList.addChild(_loc2_);
            _loc5_++;
         }
      }
      
      override public function refreshView(param1:Array) : void
      {
         var _loc2_:StelesysBaseBoxItem = null;
         var _loc5_:int = 0;
         if(param1 == null || param1.length == 0)
         {
            return;
         }
         var _loc4_:int = int(_itemList.length);
         var _loc3_:int = int(param1.length);
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            if(_loc5_ >= _loc4_)
            {
               _loc2_ = ComponentFactory.Instance.creatCustomObject(_clsStyle);
               _itemList.push(_loc2_);
            }
            else
            {
               _loc2_ = _itemList[_loc5_];
            }
            _loc2_.data = param1[_loc5_];
            _bagList.addChild(_loc2_);
            _loc5_++;
         }
      }
      
      override public function dispose() : void
      {
         for each(var _loc1_:StelesysBaseBoxItem in _metrialItemList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _metrialItemList = null;
         super.dispose();
      }
      
      public function get metrialItemList() : Array
      {
         return _metrialItemList;
      }
   }
}

