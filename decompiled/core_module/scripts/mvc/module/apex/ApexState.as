package mvc.module.apex
{
   import com.road.yishi.proto.apex.ApexStateMsg;
   import manager.LanguageMgr;
   import yishi.utils.DateFormatter;
   
   public class ApexState
   {
      
      public static const STATE_SIGN:int = 1;
      
      public static const STATE_GUESS:int = 2;
      
      public static const STATE_READY:int = 3;
      
      public static const STATE_FIGHT:int = 4;
      
      public static const STATE_AWARD:int = 5;
      
      public static const STATE_END:int = 6;
      
      public static const STAGE_1:int = 1;
      
      public static const STAGE_2:int = 2;
      
      public static const STAGE_3:int = 3;
      
      public static const STAGE_4:int = 4;
      
      public var signUpStartTime:Number;
      
      public var signUpEndTime:Number;
      
      public var betStartTime:Number;
      
      public var betEndTime:Number;
      
      public var fightStartTime:Number;
      
      public var fightEndTime:Number;
      
      public var index:int;
      
      public var stage:int;
      
      public var state:int;
      
      public function ApexState(param1:ApexStateMsg)
      {
         super();
         signUpStartTime = DateFormatter.parse(param1.signUpStartTime,"YYYY-MM-DD hh:mm:ss").time;
         signUpEndTime = DateFormatter.parse(param1.signUpEndTime,"YYYY-MM-DD hh:mm:ss").time;
         betStartTime = DateFormatter.parse(param1.betStartTime,"YYYY-MM-DD hh:mm:ss").time;
         betEndTime = DateFormatter.parse(param1.betEndTime,"YYYY-MM-DD hh:mm:ss").time;
         fightStartTime = DateFormatter.parse(param1.fightStartTime,"YYYY-MM-DD hh:mm:ss").time;
         fightEndTime = DateFormatter.parse(param1.fightEndTime,"YYYY-MM-DD hh:mm:ss").time;
         index = param1.index;
         stage = param1.stage;
         state = param1.state;
      }
      
      public function get isGuessTime() : Boolean
      {
         var _loc1_:Number = DateFormatter.parse("2000-01-01 00:00:00","YYYY-MM-DD hh:mm:ss").time;
         return betStartTime != _loc1_;
      }
      
      public function get signTimeStr() : String
      {
         var _loc1_:String = "";
         var _loc2_:String = LanguageMgr.GetTranslation("apex.hall.time1");
         return DateFormatter.format(new Date(signUpStartTime),_loc2_) + " - " + DateFormatter.format(new Date(signUpEndTime),_loc2_);
      }
      
      public function get canGuess() : Boolean
      {
         return state == 2;
      }
      
      public function get betTimeStr() : String
      {
         var _loc1_:String = "";
         var _loc2_:String = LanguageMgr.GetTranslation("apex.hall.time1");
         return DateFormatter.format(new Date(betStartTime),_loc2_) + " - " + DateFormatter.format(new Date(betEndTime),_loc2_);
      }
      
      public function get fightTimeStr() : String
      {
         var _loc1_:String = "";
         var _loc2_:String = LanguageMgr.GetTranslation("apex.hall.time1");
         return DateFormatter.format(new Date(fightStartTime),_loc2_) + " - " + DateFormatter.format(new Date(fightEndTime),_loc2_);
      }
      
      public function get overText() : String
      {
         var _loc1_:String = null;
         if(stage > 1)
         {
            _loc1_ = LanguageMgr.GetTranslation("apex.rank.over1");
         }
         if(stage > 2)
         {
            _loc1_ = LanguageMgr.GetTranslation("apex.rank.over2");
         }
         if(stage > 3)
         {
            _loc1_ = LanguageMgr.GetTranslation("apex.rank.over3");
         }
         if(stage == 4 && state == 6)
         {
            _loc1_ = LanguageMgr.GetTranslation("apex.rank.over4");
         }
         return _loc1_;
      }
   }
}

