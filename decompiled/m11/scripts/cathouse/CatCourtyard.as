package cathouse
{
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.cat.CattoysInfoMsg;
   import flash.utils.Dictionary;
   import managers.CatHouseManager;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   
   public class CatCourtyard extends Component
   {
      
      private const COUNT:int = 5;
      
      private const POS_LIST:Array = [[45,80],[510,80],[295,225],[45,325],[520,330]];
      
      private var _catConatinerList:Vector.<CatObjectPutConatiner>;
      
      public function CatCourtyard()
      {
         super();
         initView();
         addEvent();
         CatHouseManager.instance.OperateCatHouse(5);
      }
      
      private function initView() : void
      {
         var _loc1_:CatObjectPutConatiner = null;
         var _loc2_:int = 0;
         _catConatinerList = new Vector.<CatObjectPutConatiner>();
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = new CatObjectPutConatiner(_loc2_);
            _loc1_.x = POS_LIST[_loc2_][0];
            _loc1_.y = POS_LIST[_loc2_][1];
            addChild(_loc1_);
            _catConatinerList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("CATTOYS_UPDATE",__cattoysHandler);
         __cattoysHandler(null);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("CATTOYS_UPDATE",__cattoysHandler);
      }
      
      private function __cattoysHandler(param1:NotificationEvent = null) : void
      {
         var _loc2_:CatObjectPutConatiner = null;
         var _loc3_:CattoysInfoMsg = null;
         var _loc4_:int = 0;
         var _loc5_:Dictionary = CatHouseManager.instance.cattoysDic;
         _loc4_ = 0;
         while(_loc4_ < 5)
         {
            _loc2_ = _catConatinerList[_loc4_];
            _loc3_ = _loc5_[_loc4_];
            if(_loc3_)
            {
               _loc2_.updateUI(_loc3_);
            }
            else
            {
               _loc2_.clear();
            }
            _loc4_++;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_catConatinerList)
         {
            while(_catConatinerList.length)
            {
               ObjectUtils.disposeObject(_catConatinerList.pop());
            }
         }
         _catConatinerList = null;
         super.dispose();
      }
   }
}

