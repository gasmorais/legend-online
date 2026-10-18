package mvc.module.royaltyboss
{
   import yishi.datas.templates.RoyaltyTempInfo;
   import yishi.manager.TempleteManager;
   
   public class RoyaltyBossModel
   {
      
      public var royaltyLevel:int;
      
      public var passBossLevel:int;
      
      public var rankList:Vector.<RoyaltyRankInfo>;
      
      public function RoyaltyBossModel()
      {
         super();
         rankList = new Vector.<RoyaltyRankInfo>();
      }
      
      public function get forbidenBossLevel() : int
      {
         var _loc1_:RoyaltyTempInfo = TempleteManager.instance.royaltyTempCate.getTempInfoByLevel(royaltyLevel);
         if(_loc1_)
         {
            return _loc1_.OpenForbidenBoss;
         }
         return 0;
      }
   }
}

