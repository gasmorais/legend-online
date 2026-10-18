package mvc.module.secretary.acts
{
   import manager.LanguageMgr;
   import managers.SecretaryManager;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.secretary.SecretaryData;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class AltarAction extends ILitteAction
   {
      
      public static const QUICK_BLESS_VIP_GRADE:int = 4;
      
      public function AltarAction()
      {
         super();
      }
      
      public static function canBless(param1:ConsortiaModel, param2:int, param3:int, param4:int, param5:int = 0) : Boolean
      {
         var _loc6_:String = null;
         if(param1.alTarBlessLeftTime >= param2)
         {
            _loc6_ = LanguageMgr.GetTranslation("consortia.helper.ConsortiaAltarHelper.command01");
            MessageTipManager.instance().show(_loc6_);
            return false;
         }
         if(param5 > param1.reputation)
         {
            _loc6_ = LanguageMgr.GetTranslation("ConsortiaAltarHelper.reputation.text");
            MessageTipManager.instance().show(_loc6_);
            return false;
         }
         if(param3 > param4)
         {
            addOffer();
            return false;
         }
         if(!param1.lastaltarGoods)
         {
         }
         return true;
      }
      
      private static function addOffer() : void
      {
         SimpleAlertHelper.instance.data = [__addOfferCallBack];
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc3_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("consortia.helper.ConsortiaAltarHelper.content02");
         SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc4_,_loc1_,_loc2_);
      }
      
      private static function __addOfferCallBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            FrameControllerManager.instance.consortiaController.closeBuildingFrame(false);
            FrameControllerManager.instance.consortiaController.showContributeFrame();
         }
      }
      
      override public function exc() : void
      {
         if(!canBless(model,totalTime,consume,playerInfo.consortiaOffer,altarReputationCost))
         {
            isFinish = true;
            return;
         }
         var _loc1_:int = Math.min(totalTime - model.alTarBlessLeftTime,playerInfo.consortiaOffer / consume);
         FrameControllerManager.instance.consortiaController.consortiaAltarBless(_loc1_);
         isFinish = true;
      }
      
      private function get modelSecretary() : SecretaryData
      {
         return SecretaryManager.instance.model;
      }
      
      private function get model1() : ConsortiaModel
      {
         return FrameControllerManager.instance.consortiaController.model;
      }
      
      private function get consume() : int
      {
         return TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(3,model.consortiaInfo.altarLevel).Property1;
      }
      
      private function get altarReputationCost() : int
      {
         var _loc1_:Array = ConfigInfoManager.instance.getAltarReputationCost();
         return _loc1_[model1.altarWorshipIndex - 1];
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get totalTime() : int
      {
         return TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(3,model.consortiaInfo.altarLevel).Property2;
      }
      
      private function get model() : ConsortiaModel
      {
         return FrameControllerManager.instance.consortiaController.model;
      }
      
      private function __quickBlessHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            FrameControllerManager.instance.openControllerByInfo("vip");
         }
      }
      
      override public function dispose() : void
      {
      }
   }
}

