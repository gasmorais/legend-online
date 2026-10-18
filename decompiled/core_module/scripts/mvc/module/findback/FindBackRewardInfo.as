package mvc.module.findback
{
   import manager.LanguageMgr;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class FindBackRewardInfo
   {
      
      private var _goodsTempId:int;
      
      private var _goodsTempInfo:GoodsTemplateInfo;
      
      public var count:int = 0;
      
      public function FindBackRewardInfo(param1:int, param2:int)
      {
         super();
         goodsTempId = param1;
         count = param2;
      }
      
      public function get goodsTempId() : int
      {
         return _goodsTempId;
      }
      
      public function set goodsTempId(param1:int) : void
      {
         _goodsTempId = param1;
         _goodsTempInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1);
      }
      
      public function get icon() : String
      {
         if(_goodsTempInfo)
         {
            return _goodsTempInfo.Icon;
         }
         return "";
      }
      
      private function get needChanceUnit() : Boolean
      {
         if(goodsTempId == -1200 || goodsTempId == -700 || goodsTempId == -300 || goodsTempId == -100)
         {
            return true;
         }
         return false;
      }
      
      public function rewardName() : String
      {
         if(_goodsTempInfo && count > 0)
         {
            if(needChanceUnit)
            {
               return _goodsTempInfo.TemplateName + "x" + Math.ceil(count / 10000) + LanguageMgr.GetTranslation("public.tenThousands");
            }
            return _goodsTempInfo.TemplateName + "x" + count;
         }
         return "";
      }
      
      public function rewardNameZero() : String
      {
         if(_goodsTempInfo && count > 0)
         {
            if(needChanceUnit)
            {
               return _goodsTempInfo.TemplateName + "x" + 0;
            }
         }
         return "";
      }
      
      public function rewardTip() : String
      {
         if(_goodsTempInfo && count > 0)
         {
            if(needChanceUnit)
            {
               return _goodsTempInfo.TemplateName + "\nx" + Math.ceil(count / 10000) + LanguageMgr.GetTranslation("public.tenThousands");
            }
            return _goodsTempInfo.TemplateName + "\nx" + count;
         }
         return "";
      }
      
      public function get goodsTempInfo() : GoodsTemplateInfo
      {
         return _goodsTempInfo;
      }
   }
}

