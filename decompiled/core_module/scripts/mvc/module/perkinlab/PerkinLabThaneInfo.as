package mvc.module.perkinlab
{
   import yishi.datas.playerinfo.ThaneInfo;
   
   public class PerkinLabThaneInfo extends ThaneInfo
   {
      
      public var activeMagicCards:Array = [];
      
      public var isPerkinLabCrossInfo:Boolean = true;
      
      public function PerkinLabThaneInfo()
      {
         super();
      }
   }
}

