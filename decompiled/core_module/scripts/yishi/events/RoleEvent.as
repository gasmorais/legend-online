package yishi.events
{
   import flash.events.Event;
   
   [Event(name="lockRole",type="slg.core.events.RoleEvent.LOCK_ROLE")]
   [Event(name="action",type="slg.core.events.RoleEvent.ACTION")]
   [Event(name="pointChange",type="slg.core.events.RoleEvent.POINT_CHANGE")]
   [Event(name="bloodChange",type="slg.core.events.RoleEvent.BLOOD_CHANGE")]
   [Event(name="scaleX",type="slg.core.events.RoleEvent.SCALE_X")]
   public class RoleEvent extends Event
   {
      
      public static const LOCK_ROLE:String = "lockRole";
      
      public static const ACTION:String = "action";
      
      public static const POINT_CHANGE:String = "pointChange";
      
      public static const BLOOD_CHANGE:String = "bloodChange";
      
      public static const BLOOD_CHANGE_S:String = "bloodChangeS";
      
      public static const IS_LIVING:String = "isLiving";
      
      public static const DIE:String = "die";
      
      public static const SCALE_X:String = "scaleX";
      
      public static const COUNT_DOWN:String = "countDown";
      
      public static const COUNT:String = "count";
      
      public static const SP:String = "sp";
      
      public static const EFFECT_PLAY:String = "effectcPlay";
      
      public static const REFRESH_BUFFER:String = "REFRESH_BUFFER";
      
      public static const SHOW_BUFFER:String = "SHOW_BUFFER";
      
      public static const REFRESH_BUFFER_TURN:String = "REFRESH_BUFFER_TURN";
      
      public static const FACE_CHANGE:String = "FACE_CHANGE";
      
      public static const DIRECTION_CHANGE:String = "direction_change";
      
      public static const BATTLE_GOLD:String = "battleGold";
      
      public static const BATTLE_GP:String = "battleGP";
      
      public static const BATTLE_STRATEGY:String = "battleStrategy";
      
      public static const AWAKEN:String = "AWAKEN";
      
      public static const MORPH:String = "MORPH";
      
      public static const CHANGE_BODY:String = "CHANGE_BODY";
      
      public static const HIT_POINT:String = "HIT_POINT";
      
      public static const CHILD_CHANGE_VALUE:String = "CHILD_CHANGE_VALUE";
      
      public static const GODDESS_BELIEF_CHANGE:String = "GODDESS_BELIEF_CHANGE";
      
      public static const AVENGER_SP:String = "AVENGER_SP";
      
      public static const WARSOUL_SP:String = "WARSOUL_SP";
      
      public static const AVENGER_SKILL_CHANGE:String = "AVENGER_SKILL_CHANGE";
      
      public var data:Object;
      
      public function RoleEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

