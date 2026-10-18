package mvc.module.alchemical
{
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.AlchemicalMineTempInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   
   public class AlchemicalMineInfo
   {
      
      public var mineId:int;
      
      public var pos:int;
      
      public var startTime:int;
      
      public function AlchemicalMineInfo()
      {
         super();
      }
      
      public function get mineTempInfo() : AlchemicalMineTempInfo
      {
         return TempleteManager.instance.alchemicalMineTempCate.getTempInfoById(mineId);
      }
      
      public function get curCount() : int
      {
         if(!mineTempInfo)
         {
            return 0;
         }
         if(playerModel.sysCurTimeBySecond <= startTime)
         {
            return 0;
         }
         var _loc1_:int = Math.floor((playerModel.sysCurTimeBySecond - startTime) / mineTempInfo.Speed);
         return _loc1_ > mineTempInfo.MaxCount ? mineTempInfo.MaxCount : _loc1_;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
   }
}

