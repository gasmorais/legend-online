package mvc.module.friends
{
   import flash.events.EventDispatcher;
   
   public class FriendModel extends EventDispatcher
   {
      
      public static const ITEMTYPE_ADD_GROUP:int = -1;
      
      public static const ITEMTYPE_FRIEND:int = 0;
      
      public static const ITEMTYPE_GROUP:int = 1;
      
      public static const FIND_RESULTS_PER_PAGE:int = 10;
      
      public var lastReqRecentsTime:Number = -1;
      
      public var curSelectedGroup:FriendItemCellInfo;
      
      public function FriendModel()
      {
         super();
      }
   }
}

