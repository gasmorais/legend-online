package yishi.datas.templates.cate
{
   import logging.LoggerSys;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.AppellInfoTemplate;
   import yishi.manager.TempleteManager;
   
   public class PetChallengeRewardTemplate
   {
      
      public static const GOODS:int = 1;
      
      public static const BUFF:int = 2;
      
      public static const APPELL:int = 3;
      
      public var Type:int;
      
      public var Ranking:String = "";
      
      public var RewardType:int;
      
      public var TemplateId:int;
      
      public var Count:int;
      
      public var min:int;
      
      public var max:int;
      
      public var groupId:int;
      
      public var rewardObject:Object;
      
      public var rewardName:String = "";
      
      public function PetChallengeRewardTemplate()
      {
         super();
      }
      
      public function parseReward() : void
      {
         var _loc3_:Array = null;
         var _loc4_:GoodsInfo = null;
         var _loc2_:AppellInfoTemplateCate = null;
         var _loc1_:AppellInfoTemplate = null;
         _loc3_ = Ranking.split("|");
         if(_loc3_.length != 2)
         {
            LoggerSys.info("This note (PetChallengeReward) of template is Wrong!!!");
         }
         groupId = parseInt(_loc3_[0]);
         _loc3_ = _loc3_[1].split(",");
         if(_loc3_.length == 1)
         {
            min = parseInt(_loc3_[0]);
            max = parseInt(_loc3_[0]);
         }
         else if(_loc3_.length == 2)
         {
            min = parseInt(_loc3_[0]);
            max = parseInt(_loc3_[1]);
         }
         switch(RewardType - 1)
         {
            case 0:
               _loc4_ = new GoodsInfo();
               _loc4_.templateId = TemplateId;
               _loc4_.count = Count;
               if(_loc4_.templateInfo)
               {
                  rewardName = _loc4_.templateInfo.TemplateName + "*" + Count;
                  rewardObject = _loc4_;
               }
               break;
            case 1:
               break;
            case 2:
               _loc2_ = TempleteManager.instance.appellInfoTemplateCate;
               _loc1_ = _loc2_.getTemplateByID(TemplateId);
               if(_loc1_)
               {
                  rewardName = _loc1_.Title + LanguageMgr.GetTranslation("HigherGradeOpenTipView.content18");
                  rewardObject = _loc1_;
               }
         }
      }
   }
}

