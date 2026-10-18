package yishi.datas
{
   public class ComponentGroupType
   {
      
      public static const POPUP:String = "POPUP";
      
      public static const MOPUP:String = "MOPUP";
      
      public static const GROUPCHAT:String = "GROUPCHAT";
      
      public static const CASTLE_BUIDING_GROUP:String = "CASTLE_BUIDING_GROUP";
      
      public static const MAIN_TOOLS_GROUP:String = "MAIN_TOOLS_GROUP";
      
      public static const BAG_GROUP:String = "BAG_GROUP";
      
      public static const TREASURE_MAP_GROUP:String = "TREASURE_MAP_GROUP";
      
      public static const GVG_CROSS_ADD:String = "GVG_CROSS_ADD";
      
      public static const FULL_SCREEN_FRAME:String = "FULL_SCREEN_FRAME";
      
      public static const MONOPOLY_ALERT:String = "MONOPOLY_ALERT";
      
      public static const YEAR_ACTIVE:String = "YEAR_ACTIVE";
      
      public function ComponentGroupType()
      {
         super();
      }
      
      public static function get NONE() : String
      {
         return "none" + Math.random();
      }
   }
}

