package mvc.module.gloryGame
{
   import com.road.yishi.proto.Glory.GloryScheduleMsg;
   import yishi.utils.DataUtils;
   
   public class GloryGameScheduleInfo
   {
      
      public var scheduleUid:String;
      
      public var teamUid1:String;
      
      public var teamName1:String;
      
      public var serverName1:String;
      
      public var score1:int;
      
      public var teamUid2:String;
      
      public var teamName2:String;
      
      public var serverName2:String;
      
      public var score2:int;
      
      public var round:int;
      
      public var group:int;
      
      public function GloryGameScheduleInfo(param1:GloryScheduleMsg)
      {
         super();
         DataUtils.fillData(this,param1);
      }
      
      public function get rank() : int
      {
         return int(serverName2);
      }
   }
}

