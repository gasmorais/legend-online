package mvc.module.skytreasure
{
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   
   public class SkyTreasureLotteryDataInfo
   {
      
      private var _actId:String;
      
      private var _times:int;
      
      private var _freeTime:Date;
      
      public function SkyTreasureLotteryDataInfo(param1:String, param2:String, param3:int)
      {
         super();
         _actId = param1;
         _freeTime = DateFormatter.parse(param2,"YYYY-MM-DD hh:mm:ss");
         _times = param3;
      }
      
      public function get actId() : String
      {
         return _actId;
      }
      
      public function get freeLotteryLeftTimes() : Number
      {
         return Math.max(0,(_freeTime.time - currTime) / 1000);
      }
      
      public function get nextBigGiftTimes() : int
      {
         return _times;
      }
      
      private function get currTime() : Number
      {
         return PlayerManager.instance.currentPlayerModel.sysCurtime.time;
      }
      
      public function updateLotteryData(param1:String, param2:int) : void
      {
         _freeTime = DateFormatter.parse(param1,"YYYY-MM-DD hh:mm:ss");
         _times = param2;
      }
   }
}

