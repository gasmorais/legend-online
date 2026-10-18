package events
{
   import flash.events.Event;
   
   public class MonsterEvent extends Event
   {
      
      public static const MONSTER_ITEM_SELECT:String = "MONSTER_ITEM_SELECT";
      
      public static const MONSTER_BAG_MOVE:String = "MONSTER_BAG_MOVE";
      
      public static const MONSTER_INFO_CHANGE:String = "MONSTER_INFO_CHANGE";
      
      public static const MONSTER_USER_INFO_CHANGE:String = "MONSTER_USER_INFO_CHANGE";
      
      public static const MONSTER_CALL_CHANGE:String = "MONSTER_CALL_CHANGE";
      
      public static const MONSTER_COOK_CHANGE:String = "MONSTER_COOK_CHANGE";
      
      public static const MONSTER_ITEMMSG_CHANGE:String = "MONSTER_ITEMMSG_CHANGE";
      
      public static const MONSTER_RECIPE_CHANGE:String = "MONSTER_RECIPE_CHANGE";
      
      public static const MONSTER_EXPLORE_IDLIST:String = "MONSTER_EXPLORE_IDLIST";
      
      public static const EXPLORE_HEAD_SELECT:String = "EXPLORE_HEAD_SELECT";
      
      public static const EXPLORE_HEAD_CHANGE:String = "EXPLORE_HEAD_CHANGE";
      
      public static const FORMATION_SERVER_BACK:String = "FORMATION_SERVER_BACK";
      
      public static const EXPLORE_CLICK_NODE:String = "EXPLORE_CLICK_NODE";
      
      public static const EXPLORE_NODE_CHANGE:String = "EXPLORE_NODE_CHANGE";
      
      public static const BATTLE_INFO_CHANGE:String = "BATTLE_INFO_CHANGE";
      
      public static const USER_INFO_CHANGE:String = "USER_INFO_CHANGE";
      
      public static const EXPLORE_EXP_CHANGE:String = "EXPLORE_EXP_CHANGE";
      
      public static const CONTRACT_ITEM_SELECT:String = "CONTRACT_ITEM_SELECT";
      
      public static const CONTRACT_INFO_CHANGE:String = "CONTRACT_INFO_CHANGE";
      
      public static const MOPUP_BOSS_INFO:String = "MOPUP_BOSS_INFO";
      
      public static const MOPUP_MAINSWEEP_OPEN:String = "MOPUP_MAINSWEEP_OPEN";
      
      public static const MOPUP_MAINSWEEP_CLOSE:String = "MOPUP_MAINSWEEP_CLOSE";
      
      public var data:Object;
      
      public function MonsterEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

