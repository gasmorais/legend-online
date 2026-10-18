package events
{
   import flash.events.Event;
   
   public class ArmyEvent extends Event
   {
      
      public static const RECIEVED_ARMY:String = "RECIEVED_ARMY";
      
      public static const ARMY_INFO_CHANGE:String = "ARMY_PAWN_CHANGE";
      
      public static const UPDATE_STATE:String = "UPDATE_STATE";
      
      public static const UPDATE_CASTLE:String = "UPDATE_CASTLE";
      
      public static const SORT_PAWN:String = "SORT_PAWN";
      
      public static const PETINFO_CHANGED:String = "PETINFO_CHANGED";
      
      public static const CHILDRENINFO_CHANGED:String = "CHILDRENINFO_CHANGED";
      
      public static const MONSTER_CHANGED:String = "MONSTER_CHANGED";
      
      public static const CHECK_SNOW_BALL_POS:String = "CHECK_SNOW_BALL_POS";
      
      public static var BE_MOUNTATTACK:String = "BE_MOUNTATTACK";
      
      public static const SKILL_CAST_OVER:String = "SKILL_CAST_OVER";
      
      public static const SKILL_SHOOT_OVER:String = "SKILL_SHOOT_OVER";
      
      public static const DANNAY:String = "DANNAY";
      
      public static const USE_SKILL:String = "USE_SKILL";
      
      public static const BREAK_ACTION:String = "BREAK_ACTION";
      
      public static const ENTER_NODE:String = "ENTER_NODE";
      
      public static const EXIT_NODE:String = "EXIT_NODE";
      
      public static const ORENUM_CHANGE:String = "ORENUM_CHANGE";
      
      public static const ADD_BUFF:String = "ADD_BUFF";
      
      public static const REMOVE_BUFF:String = "REMOVE_BUFF";
      
      public static const UPDATE_BUFF:String = "UPDATE_BUFF";
      
      public static const PICK_UP:String = "PICK_UP";
      
      public static const LAYOUT:String = "LAYOUT";
      
      public static const STEEL_INFO_CHANGE:String = "STEEL_INFO_CHANGE";
      
      public static const STEEL_SKILL_CHANGE:String = "STEEL_SKILL_CHANGE";
      
      public static const STEEL_SKILL_COUNT_CHANGE:String = "STEEL_SKILL_COUNT_CHANGE";
      
      public static const TATTOO_INFO:String = "TATTOO_INFO";
      
      public static const TATTOO_NEWHOLE_INFO:String = "TATTOO_NEWHOLE_INFO";
      
      public static const TATTOO_NEWHOLE_SELECT:String = "TATTOO_NEWHOLE_SELECT";
      
      public static const ACTIVEVEHICLE_INFO_CHANGE:String = "ACTIVEVEHICLE_INFO_CHANGE";
      
      public static const ACTIVEVEHICLE_HP_CHANGE:String = "ACTIVEVEHICLE_HP_CHANGE";
      
      public static const ACTIVEVEHICLE_SKILL_CHANGE:String = "ACTIVEVEHICLE_SKILL_CHANGE";
      
      public static const ACTIVEVEHICLE_SKILL_COUNT_CHANGE:String = "ACTIVEVEHICLE_SKILL_COUNT_CHANGE";
      
      public static const ACTIVEVEHICLE_HOLD_KEY_STATE_CHANGE:String = "ACTIVEVEHICLE_HOLD_KEY_STATE_CHANGE";
      
      public static const USE_JUMP_SKILL:String = "USE_JUMP_SKILL";
      
      public static const UNREAL_MAZE_INFO_CHANGE:String = "UNREAL_MAZE_INFO_CHANGE";
      
      public static const UNREAL_MAZE_SKILL_CHANGE:String = "UNREAL_MAZE_SKILL_CHANGE";
      
      public static const UNREAL_MAZE_SKILL_COUNT_CHANGE:String = "UNREAL_MAZE_SKILL_COUNT_CHANGE";
      
      public static const UNREAL_MAZE_HOLD_KEY_STATE_CHANGE:String = "UNREAL_MAZE_HOLD_KEY_STATE_CHANGE";
      
      public static const UNREAL_MAZE_ENERGY_CHANGE:String = "UNREAL_MAZE_ENERGY_CHANGE";
      
      public static const UNREAL_SHOOTING_INFO_CHANGE:String = "UNREAL_SHOOTING_INFO_CHANGE";
      
      public static const UNREAL_SHOOTING_SKILL_CHANGE:String = "UNREAL_SHOOTING_SKILL_CHANGE";
      
      public static const UNREAL_SHOOTING_SKILL_COUNT_CHANGE:String = "UNREAL_SHOOTING_SKILL_COUNT_CHANGE";
      
      public static const UNREAL_SHOOTING_HOLD_KEY_STATE_CHANGE:String = "UNREAL_SHOOTING_HOLD_KEY_STATE_CHANGE";
      
      public static const UNREAL_SHOOTING_ENERGY_CHANGE:String = "UNREAL_SHOOTING_ENERGY_CHANGE";
      
      public static const STONE_GET_CHANGE:String = "STONE_GET_CHANGE";
      
      public var data:Object;
      
      public function ArmyEvent(param1:String, param2:Object)
      {
         data = param2;
         super(param1,false,false);
      }
   }
}

