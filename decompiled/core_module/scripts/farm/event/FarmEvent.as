package farm.event
{
   import flash.events.Event;
   
   public class FarmEvent extends Event
   {
      
      public static const SELECTED_CHANGE:String = "SELECTED_CHANGE";
      
      public static const FARM_GP_CHANGE:String = "FARM_GP_CHANGE";
      
      public static const FARM_GRADE_CHANGE:String = "FARM_GRADE_CHANGE";
      
      public static const LAND_GRADE_CHANGE:String = "LAND_GRADE_CHANGE";
      
      public static const LAND_OPEN:String = "LAND_OPEN";
      
      public static const LANDINFO_UPDATE:String = "LANDINFO_UPDATE";
      
      public static const FRIEND_FARM_STATE_CHANGE:String = "FRIEND_FARM_STATE_CHANGE";
      
      public static const OPER_BACK:String = "OPER_BACK";
      
      public static const PET_LAND_OPEN:String = "PET_LAND_OPEN";
      
      public static const PET_LAND_UPDATE:String = "PET_LAND_UPDATE";
      
      public static const FARM_DEFENDER_CHANGE:String = "FARM_DEFENDER_CHANGE";
      
      public static const FARM_BIGBONFIRE_STATUS:String = "FARM_BIGBONFIRE_STATUS";
      
      public static const FARM_SELECTED_CHANGE:String = "FARM_SELECTED_CHANGE";
      
      public static const FARM_CURRENT_USER_CHANGE:String = "FARM_CURRENT_USER_CHANGE";
      
      public static const FARM_HOME_INFO:String = "FARM_HOME_INFO";
      
      public static const FARM_ARMY_ANIMATION:String = "FARM_ARMY_ANIMATION";
      
      public static const FARM_BONFIRE_LEFT_TIME:String = "FARM_BONFIRE_LEFT_TIME";
      
      public static const FARM_BONFIRE_BEGIN_TIME:String = "FARM_BONFIRE_BEGIN_TIME";
      
      private var _data:Object;
      
      private var _dataII:Object;
      
      public function FarmEvent(param1:String, param2:Object = null, param3:Object = null, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         _data = param2;
         _dataII = param3;
      }
      
      override public function clone() : Event
      {
         return new FarmEvent(type,data,bubbles,cancelable);
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function get dataII() : Object
      {
         return _dataII;
      }
   }
}

