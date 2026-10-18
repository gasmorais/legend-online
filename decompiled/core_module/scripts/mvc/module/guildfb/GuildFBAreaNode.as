package mvc.module.guildfb
{
   import yishi.datas.templates.GuildFBTempInfo;
   import yishi.manager.TempleteManager;
   
   public class GuildFBAreaNode
   {
      
      public var areaId:int;
      
      public var diff:int;
      
      public var rewardState:int;
      
      public var leader:GuildFBPlayerInfo;
      
      public function GuildFBAreaNode()
      {
         super();
         leader = new GuildFBPlayerInfo();
      }
      
      public function get currTempInfo() : GuildFBTempInfo
      {
         return TempleteManager.instance.guildFBTempCate.getOneNode(areaId,diff);
      }
   }
}

