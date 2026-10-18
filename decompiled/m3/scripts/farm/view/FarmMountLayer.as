package farm.view
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import farm.FarmManager;
   import farm.data.ShowMountMsgInfo;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class FarmMountLayer extends Sprite implements Disposeable
   {
      
      private static const MOUNTS_POS:Array = [[73,1499],[313,1661],[366,1264],[1036,1633],[740,697],[1162,782],[1812,834],[2085,763],[2287,1454],[2146,1549]];
      
      private var _mountData:Object;
      
      public function FarmMountLayer()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:FarmMountItem = null;
         _mountData = {};
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc1_ = new FarmMountItem();
            _loc1_.x = MOUNTS_POS[_loc2_][0];
            _loc1_.y = MOUNTS_POS[_loc2_][1];
            _loc1_.pos = _loc2_;
            addChild(_loc1_);
            _mountData[_loc2_] = _loc1_;
            _loc2_++;
         }
         updateView();
      }
      
      private function addEvent() : void
      {
         FarmManager.instance.model.addEventListener("FARM_HOME_INFO",onHomeInfo);
      }
      
      private function removeEvent() : void
      {
         FarmManager.instance.model.removeEventListener("FARM_HOME_INFO",onHomeInfo);
      }
      
      private function onHomeInfo(param1:Event) : void
      {
         updateView();
      }
      
      public function updateView() : void
      {
         var _loc1_:ShowMountMsgInfo = null;
         var _loc2_:FarmMountItem = null;
         var _loc4_:int = 0;
         var _loc3_:Array = FarmManager.instance.model.showMountMsgInfo;
         for each(_loc2_ in _mountData)
         {
            _loc2_.data = null;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc1_ = _loc3_[_loc4_];
            _loc2_ = _mountData[_loc1_.pos];
            if(_loc2_ == null)
            {
               _loc2_ = new FarmMountItem();
               _mountData[_loc1_.pos] = _loc2_;
               _loc2_.x = 1000 + _loc1_.pos * 100;
               _loc2_.y = 1000;
               addChild(_loc2_);
            }
            _loc2_.data = _loc1_;
            _loc4_++;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:FarmMountItem in _mountData)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         ObjectUtils.disposeObject(_mountData);
         _mountData = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

