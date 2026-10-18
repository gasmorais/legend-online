package mvc.module.oldbacker
{
   import events.OldBackerEvents;
   import flash.events.EventDispatcher;
   
   public class OldBackerModel extends EventDispatcher
   {
      
      public var backerType:int;
      
      public var openTime:String;
      
      public var stopTime:String;
      
      public var singKey:String;
      
      public var openState:int;
      
      public var isUseKey:Boolean;
      
      public var isTakeBuffer:Boolean;
      
      public var isOpenNewSvr:Boolean;
      
      public var chargeTotalCount:int;
      
      public var viewInfoList:Array = [];
      
      public var currentType:int;
      
      public var needGrades:int;
      
      public function OldBackerModel()
      {
         super();
      }
      
      public function getViewInfoByType(param1:int) : Array
      {
         var _loc5_:OldBackerViewInfo = null;
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         var _loc3_:int = int(viewInfoList.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = viewInfoList[_loc4_];
            if(_loc5_.rewardTypes == param1)
            {
               _loc2_.push(_loc5_);
            }
            _loc4_ += 1;
         }
         _loc2_.sortOn("rewardLevel",16);
         return _loc2_;
      }
      
      public function commit() : void
      {
         this.dispatchEvent(new OldBackerEvents("REFRESH_VIEW_INFO"));
      }
   }
}

