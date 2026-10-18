package events
{
   import flash.events.Event;
   
   public class DragonTalkerEvent extends Event
   {
      
      public static const DRAGON_TALKER_TALISMAN_UPDATE:String = "DRAGON_TALKER_TALISMAN_UPDATE";
      
      public static const DRAGON_TALKER_INFO_UPDATE:String = "DRAGON_TALKER_INFO_UPDATE";
      
      public static const DRAGON_TALKER_SKILLVIEW_CHANGE:String = "DRAGON_TALKER_SKILLVIEW_CHANGE";
      
      public static const SET_FAST_KEY:String = "SET_FAST_KEY";
      
      public static const FAST_KEY_MOVE:String = "FAST_KEY_MOVE";
      
      public static const TALISMAN_REMOVE_EQUIP:String = "TALISMAN_REMOVE_EQUIP";
      
      public static const HIDE_DIC_CHANGE:String = "HIDE_DIC_CHANGE";
      
      public static const TALISMAN_SWALLOW_BACK:String = "TALISMAN_SWALLOW_BACK";
      
      public static const TALISMAN_SWALLOW_SKILL_BACK:String = "TALISMAN_SWALLOW_SKILL_BACK";
      
      public static const ATTRIBUTE_CLICK:String = "ATTRIBUTE_CLICK";
      
      public static const CLOSE_PREVIEW_FRAME:String = "CLOSE_PREVIEW_FRAME";
      
      public static const ADD_INTENSIFY_TALISMAN:String = "ADD_INTENSIFY_TALISMAN";
      
      public static const MUTI_INTENSIFY_COUNT_CHANGE:String = "MUTI_INTENSIFY_COUNT_CHANGE";
      
      public static const MUTI_INTENSIFY_TALISMAN_DELETE:String = "MUTI_INTENSIFY_TALISMAN_DELETE";
      
      public static const TALISMAN_PAGE_CHANGE:String = "TALISMAN_PAGE_CHANGE";
      
      public static const MUTI_TALISMAN_STATE_CHANGE:String = "MUTI_TALISMAN_STATE_CHANGE";
      
      public static const MUTI_INTENSIFY_FRAME_CHANGE:String = "MUTI_INTENSIFY_FRAME_CHANGE";
      
      public static const SWITCH_EQUIPVIEW:String = "SWITCH_EQUIPVIEW";
      
      public function DragonTalkerEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

