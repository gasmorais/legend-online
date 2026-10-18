package outercityshop.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import events.OuterCityShopEvent;
   import manager.LanguageMgr;
   import managers.OuterCityShopManager;
   import mvc.module.outercityshop.OuterCityShopModel;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   
   public class OuterCityShopSelectedView extends Component
   {
      
      private var _valueTxt:FilterFrameText;
      
      private var _payIcon:ScaleFrameImage;
      
      private var _buyNeed:int;
      
      public function OuterCityShopSelectedView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _valueTxt = ComponentFactory.Instance.creatComponentByStylename("outercityshop.valueTxt");
         _payIcon = ComponentFactory.Instance.creatComponentByStylename("outercityshop.payIconImg");
         _payIcon.setFrame(1);
         addChild(_valueTxt);
         addChild(_payIcon);
         var _loc1_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("ShopFresh_NeedDiamond");
         if(_loc1_)
         {
            _buyNeed = int(_loc1_.ConfigValue);
         }
         __freshViewHandler(null);
      }
      
      private function addEvent() : void
      {
         model.addEventListener("FRESH_VIEW",__freshViewHandler);
      }
      
      private function __freshViewHandler(param1:OuterCityShopEvent) : void
      {
         _valueTxt.text = LanguageMgr.GetTranslation("outercityshop.nameTxt1") + " " + _buyNeed;
         updateValueFrame(_valueTxt,model.refreshNeedPoint > playerModel.playerInfo.point + playerModel.playerInfo.giftToken);
      }
      
      private function updateValueFrame(param1:FilterFrameText, param2:Boolean) : void
      {
         if(param2)
         {
            param1.setFrame(2);
         }
         else
         {
            param1.setFrame(1);
         }
      }
      
      public function get payType() : int
      {
         return 1;
      }
      
      private function removeEvent() : void
      {
         model.removeEventListener("FRESH_VIEW",__freshViewHandler);
      }
      
      private function get model() : OuterCityShopModel
      {
         return OuterCityShopManager.instance.model;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
      }
   }
}

