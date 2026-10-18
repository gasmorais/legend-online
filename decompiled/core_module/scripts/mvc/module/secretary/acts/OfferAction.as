package mvc.module.secretary.acts
{
   import managers.OfferRewardManager;
   import managers.SecretaryManager;
   import mvc.module.secretary.SecretaryData;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   
   public class OfferAction extends ILitteAction
   {
      
      private var _moneyState:Boolean = true;
      
      private var _type:int;
      
      public function OfferAction(param1:int, param2:Boolean)
      {
         _moneyState = param2;
         _type = param1;
         super();
      }
      
      override public function exc() : void
      {
         var _loc1_:int = playerInfo.point;
         if(_moneyState)
         {
            _loc1_ = playerInfo.point + playerInfo.giftToken;
         }
         if(_loc1_ < model.offerMoney)
         {
            RechargeAlertMannager.show();
            isFinish = true;
            return;
         }
         OfferRewardManager.instance.sendAllFinishRequest(_moneyState);
         isFinish = true;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get model() : SecretaryData
      {
         return SecretaryManager.instance.model;
      }
   }
}

