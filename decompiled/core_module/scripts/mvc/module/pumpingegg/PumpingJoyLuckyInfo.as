package mvc.module.pumpingegg
{
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   
   public class PumpingJoyLuckyInfo
   {
      
      public var uuid:String;
      
      public var eggId:int;
      
      public var timeOutDateNum:Number;
      
      public var takeState:int;
      
      public function PumpingJoyLuckyInfo()
      {
         super();
      }
      
      public function get leftTime() : Number
      {
         if(timeOutDateNum <= playerModel.sysCurTimeBySecond)
         {
            return 0;
         }
         return timeOutDateNum - playerModel.sysCurTimeBySecond;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
   }
}

