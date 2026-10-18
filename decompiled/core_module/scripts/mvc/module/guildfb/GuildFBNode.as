package mvc.module.guildfb
{
   import yishi.datas.templates.GuildFBTempInfo;
   import yishi.manager.TempleteManager;
   
   public class GuildFBNode
   {
      
      public static const FIGHT_ING:int = 3;
      
      public static const REWARD:int = 1;
      
      public static const FINISH:int = 2;
      
      public var nodeID:int;
      
      private var _rewardState:int;
      
      public var attackCount:int;
      
      public var bossHp:Number = 0;
      
      public var bossMaxHp:Number = 1;
      
      public var buffID:Array = [];
      
      public var playerList:Array = [];
      
      public function GuildFBNode()
      {
         super();
      }
      
      public function get rewardState() : int
      {
         return _rewardState;
      }
      
      public function set rewardState(param1:int) : void
      {
         if(_rewardState == param1)
         {
            return;
         }
         _rewardState = param1;
         if(_rewardState != 3)
         {
            playerList.length = 0;
            buffID.length = 0;
         }
      }
      
      public function get currTempInfo() : GuildFBTempInfo
      {
         return TempleteManager.instance.guildFBTempCate.getNodeById(nodeID);
      }
   }
}

