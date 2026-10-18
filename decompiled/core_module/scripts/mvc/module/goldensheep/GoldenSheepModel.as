package mvc.module.goldensheep
{
   import events.GoldenSheepEvent;
   import flash.events.EventDispatcher;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   
   public class GoldenSheepModel extends EventDispatcher
   {
      
      public var index:int;
      
      public var myCount:int;
      
      public var isReward:int;
      
      public var rewardId:int;
      
      public var totalCount:int;
      
      public var curCount:int;
      
      public var state:int;
      
      public var isOpen:int;
      
      public var openTime:Date;
      
      public var endTime:Date;
      
      public var recordList:Vector.<GoldenSheepRecordInfo>;
      
      public function GoldenSheepModel()
      {
         super();
         recordList = new Vector.<GoldenSheepRecordInfo>();
      }
      
      public function get hasGotReward() : Boolean
      {
         var _loc1_:Boolean = false;
         if(isReward == 1)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function get needShow() : Boolean
      {
         var _loc1_:Boolean = false;
         if(isOpen == 1)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function get topBtnShow() : Boolean
      {
         if(needShow)
         {
            return true;
         }
         if(openTime && DateFormatter.checkIsSameDay(openTime,playerModel.sysCurtime) && playerModel.sysCurtime.time <= openTime.time)
         {
            return true;
         }
         if(endTime && openTime && playerModel.sysCurtime.time >= openTime.time && playerModel.sysCurtime.time < endTime.time)
         {
            return true;
         }
         return false;
      }
      
      public function get needShine() : Boolean
      {
         var _loc1_:Boolean = false;
         if(state == 1)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function updateAnimation() : void
      {
         dispatchEvent(new GoldenSheepEvent("ANIMATION_UPDATE",this));
      }
      
      public function updateState() : void
      {
         dispatchEvent(new GoldenSheepEvent("STATE_UPDATE",this));
      }
      
      public function commit() : void
      {
         dispatchEvent(new GoldenSheepEvent("INFO_UPDATE",this));
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
   }
}

