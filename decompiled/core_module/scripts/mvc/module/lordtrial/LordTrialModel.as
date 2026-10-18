package mvc.module.lordtrial
{
   import events.LordTrialEvent;
   import flash.events.EventDispatcher;
   import managers.ChildManager;
   import mvc.module.children.ChildData;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   
   public class LordTrialModel extends EventDispatcher
   {
      
      private var _lordTrialRankData:Vector.<LordTrialRankInfo>;
      
      private var _mopupCount:int;
      
      public var mopupList:Array = [];
      
      public var isOpen:Boolean = false;
      
      public var maxMopupIndex:int;
      
      public var childId:int = -1;
      
      public var currentType:int = -1;
      
      public function LordTrialModel()
      {
         super();
      }
      
      public function get lordTrialRankData() : Vector.<LordTrialRankInfo>
      {
         return _lordTrialRankData;
      }
      
      public function set lordTrialRankData(param1:Vector.<LordTrialRankInfo>) : void
      {
         _lordTrialRankData = param1;
         dispatchEvent(new LordTrialEvent("UPDATE_RANKDATA",null));
      }
      
      public function get mopupCount() : int
      {
         return _mopupCount;
      }
      
      public function getChildData() : ChildData
      {
         if(childId == -1)
         {
            return null;
         }
         return ChildManager.instance.model.getChildById(childId);
      }
      
      public function set mopupCount(param1:int) : void
      {
         if(_mopupCount == param1)
         {
            return;
         }
         _mopupCount = param1;
         if(_mopupCount > 0)
         {
            FrameControllerManager.instance.openControllerByInfo("mopup",10);
         }
      }
      
      public function updateView() : void
      {
         dispatchEvent(new LordTrialEvent("UPDATE_VIEW"));
      }
      
      public function updateMopup(param1:Object = null) : void
      {
         dispatchEvent(new LordTrialEvent("UPDATEMOPUP",param1));
      }
      
      public function get isInActivity() : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:Date = PlayerManager.instance.currentPlayerModel.sysCurtime;
         var _loc2_:Boolean = true;
         if(_loc1_)
         {
            _loc4_ = _loc1_.getDay();
            _loc3_ = _loc1_.getHours();
            if(_loc4_ == 0 && _loc3_ == 23 || _loc4_ == 1 && _loc3_ == 0)
            {
               _loc2_ = false;
            }
         }
         return _loc2_;
      }
   }
}

