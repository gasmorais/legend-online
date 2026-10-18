package map.campaign.view.frame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.TrailPropInfo;
   import map.campaign.view.ui.CampaignBuffShopItem;
   import map.internals.data.RandomBuffMsgInfo;
   import yishi.datas.templates.RondamBossTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   
   public class CampaignBuffFrame extends Frame
   {
      
      private static const ITEM_COUNT:int = 4;
      
      private var _vbox:VBox;
      
      private var itemArr:Array;
      
      public function CampaignBuffFrame()
      {
         super();
         itemArr = [];
         initView();
         initEvent();
         refrehView();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("map.campaign.view.frame.titleText");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("campaign.TrailShop.TrailIBox");
         addToContent(_vbox);
      }
      
      private function refrehView() : void
      {
         var _loc3_:int = 0;
         var _loc5_:RandomBuffMsgInfo = null;
         var _loc1_:CampaignBuffShopItem = null;
         var _loc4_:TrailPropInfo = null;
         var _loc2_:RondamBossTemplateInfo = null;
         var _loc6_:Array = CampaignManager.instance.mapModel.randomBossBuffefMsgInfo.buffs;
         _loc3_ = 0;
         while(_loc3_ < _loc6_.length)
         {
            _loc5_ = _loc6_[_loc3_];
            _loc1_ = itemArr[_loc3_];
            if(_loc1_ == null)
            {
               _loc1_ = ComponentFactory.Instance.creatCustomObject("campaign.BuffShop.BuffItem");
               _vbox.addChild(_loc1_);
               itemArr.push(_loc1_);
            }
            _loc4_ = new TrailPropInfo();
            _loc2_ = TempleteManager.instance.randomBossTemplateCate.getTemplatesById(_loc5_.skillId);
            _loc4_.id = _loc2_.SkillId;
            _loc4_.index = _loc2_.Index;
            _loc4_.currentCount = _loc5_.buy_count;
            _loc4_.maxCount = _loc2_.CanBuyCount;
            _loc4_.cost = _loc2_.NeedCount;
            _loc4_.NeedItemId = _loc2_.NeedItemId;
            _loc1_.data = _loc4_;
            _loc3_++;
         }
      }
      
      private function onUpdate(param1:NotificationEvent) : void
      {
         refrehView();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         NotificationManager.instance.addEventListener("RANDOM_CAMPAIGN_UPDATE_BUFF",onUpdate);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         NotificationManager.instance.removeEventListener("RANDOM_CAMPAIGN_UPDATE_BUFF",onUpdate);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

