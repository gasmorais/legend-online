package mvc.module.gloryGame
{
   import battle.utils.Int64Utils;
   import com.road.yishi.proto.Glory.PlayerBetMsg;
   import managers.GloryGameManager;
   import yishi.utils.DataUtils;
   import yishi.utils.DateFormatter;
   
   public class GloryGameBetInfo
   {
      
      public var id:int;
      
      public var round:int;
      
      public var teamUid1:String;
      
      public var teamScore1:int;
      
      public var teamUid2:String;
      
      public var teamScore2:int;
      
      public var betTiem:Number;
      
      public function GloryGameBetInfo(param1:PlayerBetMsg)
      {
         super();
         DataUtils.fillData(this,param1);
         betTiem = Int64Utils.int64ToNumber(param1.betTiem);
      }
      
      public function get teamName1() : String
      {
         if(teamUid1 == "")
         {
            return "";
         }
         return GloryGameManager.instance.model.teamNameMap.getValue(teamUid1) as String;
      }
      
      public function get teamName2() : String
      {
         if(teamUid2 == "")
         {
            return "";
         }
         return GloryGameManager.instance.model.teamNameMap.getValue(teamUid2) as String;
      }
      
      public function get betTimeStr() : String
      {
         return DateFormatter.timeFormat1(new Date(betTiem));
      }
   }
}

