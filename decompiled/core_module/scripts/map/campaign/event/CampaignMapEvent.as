package map.campaign.event
{
   import flash.events.Event;
   
   public class CampaignMapEvent extends Event
   {
      
      public static const PREPARE_BATTLE_FRAME2_COLSE:String = "PREPARE_BATTLE_FRAME2_COLSE";
      
      public static const UPDATE_HOUSE_OWNER:String = "UPDATE_HOUSE_OWNER";
      
      public static const UPDATE_IS_PLAYING:String = "UPDATE_IS_PLAYING";
      
      public static const UPDATE_CAMPAIGN_ARMY:String = "UPDATE_CAMPAIGN_ARMY";
      
      public static const ONLINE_STATE:String = "ONLINE_STATE";
      
      public static const UPDATE_CAMPAIGN_NODE_STATE:String = "UPDATE_CAMPAIGN_NODE_STATE";
      
      public static const NEXT_NODE_GUIDE_TIME:String = "NEXT_NODE_GUIDE_TIME";
      
      public static const NEXT_NODE_GUIDE_TIME_OVER:String = "NEXT_NODE_GUIDE_TIME_OVER";
      
      public static const SYS_FOG_DATA:String = "SYS_FOG_DATA";
      
      public static const LOCAL_UPDATE_FOG:String = "LOCAL_UPDATE_FOG";
      
      public static const SYN_FOG_DATA:String = "SYN_FOG_DATA";
      
      public static const UPDATE_CHEST_INFO:String = "UPDATE_CHEST_INFO";
      
      public static const ADD_CHEST_NODE:String = "ADD_CHEST_NODE";
      
      public static const ATTACK_BOSS_TEMA:String = "ATTACK_BOSS_TEMA";
      
      public static const ATTACK_BOSS_INVITE:String = "ATTACK_BOSS_INVITE";
      
      public static const MOVE_SCENET_END:String = "MOVE_SCENET_END";
      
      public static const DRAG_SCENE_END:String = "DRAG_SCENE_END";
      
      public static const LOOK_AT_ROLE:String = "LOOK_AT_ROLE";
      
      public static const CREATE_ARMY:String = "CREATE_ARMY";
      
      public static const IS_DIE:String = "IS_DIE";
      
      public static const MOVE_PATHS_ARMY:String = "MOVE_PATHS_ARMY";
      
      public static const GO_TO_POS:String = "GO_TO_POS";
      
      public static const UPDATE_WALK_TARGET:String = "UPDATE_WALK_TARGET";
      
      public static const HANGUP_STATE:String = "hangupState";
      
      public static const HANGUP_ADD:String = "hangupadd";
      
      public static const TRANSEFER_WAIT_STATE:String = "transeferWaitState";
      
      public static const MAZE_DIE:String = "MAZE_DIE";
      
      public static const BUFFER_TEMP_ID:String = "BUFFER_TEMP_ID";
      
      public static const UPDATE_PVP_SCORE:String = "UPDATE_PVP_SCORE";
      
      public static const UPDATE_PVP_GESTE:String = "UPDATE_PVP_GESTE";
      
      public static const UPDATE_TEAM_ID:String = "UPDATE_TEAM_ID";
      
      public static const SYNC_ERROR_TIME:String = "syncErrorTime";
      
      public static const OPENTIME_MV:String = "opentimemv";
      
      public static const MOVE_TO_VISIBLE:String = "MOVE_TO_VISIBLE";
      
      public static const MOVE_TO_UNVISIBLE:String = "MOVE_TO_UNVISIBLE";
      
      public static const IS_SELLING:String = "IS_SELLING";
      
      public static const ATTACK_BOSS_NOTICE:String = "ATTACK_BOSS_NOTICE";
      
      public static const ACTIVEVEHICLE_MOVE_PATH:String = "ACTIVEVEHICLE_MOVE_PATH";
      
      public static const SYN_CAMPAIGN_VIEW:String = "SYN_CAMPAIGN_VIEW";
      
      public static const MOVE_PATHS_ARMY_LIST:String = "MOVE_PATHS_ARMY_LIST";
      
      public var data:Object;
      
      public function CampaignMapEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

