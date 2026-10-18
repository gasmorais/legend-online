package yishi.datas.consant
{
   import manager.LanguageMgr;
   
   public class SexType
   {
      
      public function SexType()
      {
         super();
      }
      
      public static function getSexDescript(param1:int) : String
      {
         switch(param1)
         {
            case 0:
               return LanguageMgr.GetTranslation("sns.SNSModel.sex02");
            case 1:
               return LanguageMgr.GetTranslation("sns.SNSModel.sex01");
            case 2:
               return LanguageMgr.GetTranslation("yishi.datas.consant.JobType.Name01");
            default:
               return LanguageMgr.GetTranslation("yishi.datas.goods.GoodsProfile.profile01");
         }
      }
   }
}

