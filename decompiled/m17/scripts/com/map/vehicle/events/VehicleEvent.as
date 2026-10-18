package com.map.vehicle.events
{
   import flash.events.Event;
   
   public class VehicleEvent extends Event
   {
      
      public static const ADD_PLAYER:String = "addPlayer";
      
      public static const REMOVE_PLAYER:String = "remove_player";
      
      public static const UPDATE_PLAYER:String = "update_player";
      
      public static const PLAYER_MOVE:String = "player_move";
      
      public static const ADD_NODE:String = "addNode";
      
      public static const UPDATE_NODE:String = "updateNode";
      
      public static const REMOVE_NODE:String = "REMOVE_NODE";
      
      public static const SKILL_CAST_OVER:String = "SKILL_CAST_OVER";
      
      public static const REFLSH_SKILL:String = "refresh_skill";
      
      public static const LEARN_SKILL:String = "learn_skill";
      
      public static const CLICK_SKILL:String = "click_skill";
      
      public static const ADD_VEHICLE_NPC:String = "addVehicleNpc";
      
      public static const RECEIVE_ATTACK:String = "receive_attack";
      
      public static const PLAY_SKILL:String = "play_skill";
      
      public static const UPDATE_WALK_TARGET:String = "UPDATE_WALK_TARGET";
      
      public static const SKILL_EFFECT:String = "SKILL_EFFECT";
      
      public static const CAST:String = "cast";
      
      public static const ADD_BUFF:String = "ADD_BUFF";
      
      public static const REMOVE_BUFF:String = "REMOVE_BUFF";
      
      public static const UPDATE_BUFF:String = "UPDATE_BUFF";
      
      public static const UPDATE_HP:String = "update_hp";
      
      public static const PICK_UP:String = "pickup";
      
      public static const STATE_CHANGE:String = "stateChange";
      
      public static const PLAYER_INFO_CHANGE:String = "playerInfoChange";
      
      public static const BUFF_HURT:String = "BUFF_HURT";
      
      public static const SKILL_INFO_CHANGE:String = "SKILL_INFO_CHANGE";
      
      public static const VEHICLE_TEMPLATE_CHANGE:String = "VEHICLE_TEMPLATE_CHANGE";
      
      public static const START_CD:String = "START_CD";
      
      public static const SCORE_CHANGE:String = "SCORE_CHANGE";
      
      public static const START_COUNTTIME:String = "START_COUNTTIME";
      
      public static const PLAYE_LIST_UPDATE:String = "PLAYE_LIST_UPDATE";
      
      public static const NEW_BUFF:String = "NEW_BUFF";
      
      public static const DIE:String = "DIE";
      
      public static const SKILL_HURT:String = "SKILL_HURT";
      
      public static const ATTACK_NOTICE:String = "ATTACK_NOTICE";
      
      public static const CHAT_DATA:String = "CHAT_DATA";
      
      public static const HP_ADD:String = "HP_ADD";
      
      public static const HP_CUT:String = "HP_CUT";
      
      public static const REVIER:String = "REVIER";
      
      public static const CHANGE_SKILL:String = "CHANGE_SKILL";
      
      public static const WALK_OVER:String = "WALK_OVER";
      
      public static const CLEAR_BUFF:String = "CLEAR_BUFF";
      
      public static const BREAK_PICKUP:String = "BREAK_PICKUP";
      
      public static const EARTHQUAKE:String = "EARTHQUAKE";
      
      public static const WARNING:String = "WARNING";
      
      public static const WARNING_CANCEL:String = "WARNING_CANCEL";
      
      public static const DIE_COUNT:String = "DIE_COUNT";
      
      public static const ADD_SLOW:String = "ADD_SLOW";
      
      public static const ADD_POISONING:String = "ADD_POISONING";
      
      public static const REMOVE_SLOW:String = "REMOVE_SLOW";
      
      public static const REMOVE_POISONING:String = "REMOVE_POISONING";
      
      public static const SKILL_SHOOT_OVER:String = "SKILL_SHOOT_OVER";
      
      public static const CAMPAIGN_TIME:String = "CAMPAIGN_TIME";
      
      public var data:*;
      
      public function VehicleEvent(param1:String, param2:*, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

