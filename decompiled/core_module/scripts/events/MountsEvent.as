package events
{
   import flash.events.Event;
   
   public class MountsEvent extends Event
   {
      
      public static const MOUNT_INFO_CHANGE:String = "mountInfoChange";
      
      public static const MOUNT_LIST_CHANGE:String = "mountListChange";
      
      public static const PAGE_INDEX_CHANGE:String = "pageIndexChange";
      
      public static const MOUNT_LEVEL_UP:String = "mountLevelup";
      
      public static const PROP_LEVEL_UP:String = "propLevelup";
      
      public static const MOUNT_ITEM_CHANGE:String = "mountItemChange";
      
      public static const MOUNT_KINGINFO_CHANGE:String = "mountKingInfoChange";
      
      public static const MOUNT_SHOPINFO_CHANGE:String = "mountShopInfoChange";
      
      public static const MOUNT_SHOP_PREVIEW:String = "MOUNT_SHOP_PREVIEW";
      
      public static const MOUNT_REFINING_SOUL_CHANGE:String = "MOUNT_REFINING_SOUL_CHANGE";
      
      public var data:*;
      
      public function MountsEvent(param1:String, param2:* = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.data = param2;
      }
   }
}

