package battle.events
{
   import flash.events.Event;
   
   public class BattleEvent extends Event
   {
      
      public static const BEFORE_BATTLE_END:String = "BEFORE_BATTLE_END";
      
      public static const STATE_CHANGE:String = "stateChange";
      
      public static const SYNCHRONIZATION:String = "synchronization";
      
      public static const SKILL_CLICK:String = "SKILL_CLICK_BattleEvent";
      
      public static const ACTION_COUNT_CHANGE:String = "actionCountChange";
      
      public static const REDUCE_WORLD_BOSS_BLOOD:String = "reduceWorldBossBlood";
      
      public static const BATTLE_CANCEL:String = "battleCancel";
      
      public static const ATTACK_MODE_CHANGE:String = "battleModeChange";
      
      public static const BATTLE_COMPLETE:String = "battleComplete";
      
      public static const SELF_MOVE_START:String = "selfMoveStart";
      
      public static const BATTLE_UI_LOADED:String = "battleUILoaded";
      
      public static const ENTER_BATTLE_SCENE:String = "enterbattlescene";
      
      public static const SCENE_EFFECT_CLOSE:String = "sceneEffectClose";
      
      public static const SHAKE_MAP_COMPLETE:String = "shakeMapComplete";
      
      public static const BATTLE_MUSIC_ON_OFF:String = "battleMusicOnOff";
      
      public static const TRAIL_LAYER_CHANGE:String = "TRAIL_LAYER_CHANGE";
      
      public static const TRAIL_USECOUNT_CHANGE:String = "TRAIL_USECOUNT_CHANGE";
      
      public static const PROP_USECOUNT_CHANGE:String = "PROP_USECOUNT_CHANGE";
      
      public static const START_COUNT_DOWN:String = "START_COUNT_DOWN";
      
      public static const BATTLE_READ_GO:String = "BATTLE_READ_GO";
      
      public static const BATTLE_OTHER_LIVING_VISIBLE:String = "BATTLE_OTHER_LIVING_VISIBLE";
      
      public static const BATTLE_REINFORCE_HANDLER:String = "BATTLE_REINFORCE_HANDLER";
      
      public static const BATTLE_STONETRIGGER:String = "BATTLE_STONETRIGGER";
      
      public static const LOAD_COMPLETE_SINGEL:String = "LOAD_COMPLETE_SINGEL";
      
      public var data:Object;
      
      public function BattleEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

