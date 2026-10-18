package mvc.module.groupfb
{
   import yishi.manager.PlayerManager;
   
   public class GroupfbRoomInfo
   {
      
      public var id:int;
      
      public var name:String;
      
      public var count:int;
      
      public var total:int;
      
      public var state:int;
      
      public var passWord:String;
      
      public var captainId:int;
      
      public var list:Vector.<GroupfbPlayerInfo>;
      
      public var isNew:Boolean;
      
      public function GroupfbRoomInfo()
      {
         super();
         list = new Vector.<GroupfbPlayerInfo>();
      }
      
      public function get selfInfo() : GroupfbPlayerInfo
      {
         for each(var _loc1_:GroupfbPlayerInfo in list)
         {
            if(_loc1_.userId == PlayerManager.instance.currentPlayerModel.playerInfo.userId)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function getTeamList(param1:int) : Vector.<GroupfbPlayerInfo>
      {
         var _loc2_:Vector.<GroupfbPlayerInfo> = new Vector.<GroupfbPlayerInfo>();
         for each(var _loc3_:GroupfbPlayerInfo in list)
         {
            if(_loc3_.team == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function getAllTeamList() : Vector.<GroupfbPlayerInfo>
      {
         var _loc1_:Vector.<GroupfbPlayerInfo> = new Vector.<GroupfbPlayerInfo>();
         for each(var _loc2_:GroupfbPlayerInfo in list)
         {
            if(_loc2_.team == 1 || _loc2_.team == 2)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
   }
}

