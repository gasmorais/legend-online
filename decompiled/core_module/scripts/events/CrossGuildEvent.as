package events
{
   import flash.events.Event;
   
   public class CrossGuildEvent extends Event
   {
      
      public static const SIGN_ITEM_SELECT:String = "SIGN_ITEM_SELECT";
      
      public static const MEMBER_ATTACK_CONTRIBUTION:String = "MEMBER_ATTACK_CONTRIBUTION";
      
      public static const CROSS_GUILD_SEASON_RANK:String = "CROSS_GUILD_SEASON_RANK";
      
      public static const CROSS_GUILD_MAIN_CHANGE:String = "CROSS_GUILD_MAIN_CHANGE";
      
      public static const ENTER_WAR:String = "ENTER_WAR";
      
      public static const TOWER_DETAIL_BACK:String = "TOWER_DETAIL_BACK";
      
      public static const WAR_MAIN_CHANGE:String = "WAR_MAIN_CHANGE";
      
      public static const ATTACK_RECORD_BACK:String = "ATTACK_RECORD_BACK";
      
      public static const WAR_OHTER_INFO_CHANGE:String = "WAR_OHTER_INFO_CHANGE";
      
      public var data:Object;
      
      public function CrossGuildEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

