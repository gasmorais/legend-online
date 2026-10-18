package worldboss.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.WorldBossManager;
   import managers.WorldBossSocketOutManager;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.manager.TempleteManager;
   
   public final class BuyAvatarFrame extends Frame
   {
      
      private var _pointBmp:ScaleFrameImage;
      
      private var _selfTipTxt:FilterFrameText;
      
      private var _submitButton:IconButton;
      
      private var _cancelButton:IconButton;
      
      private var _data:CampaignTemplate;
      
      public var campaignId:int;
      
      public function BuyAvatarFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _pointBmp = ComponentFactory.Instance.creatComponentByStylename("core.PayType");
         _selfTipTxt = ComponentFactory.Instance.creatComponentByStylename("worldboss.BuyAvatarFrame.DescriptionTxt");
         _submitButton = ComponentFactory.Instance.creatComponentByStylename("worldboss.BuyAvatarFrame.AlertButtonConfirm_2");
         _cancelButton = ComponentFactory.Instance.creatComponentByStylename("worldboss.BuyAvatarFrame.AlertButtonCancel_1");
         this.titleText = LanguageMgr.GetTranslation("worldboss.BuyAvatarFrame.command01");
         var _loc4_:TempleteManager = TempleteManager.instance;
         var _loc3_:int = 200;
         if(_loc4_.getConfigInfoByConfigName("WorldBoss_Replacement_Price"))
         {
            _loc3_ = parseInt(_loc4_.getConfigInfoByConfigName("WorldBoss_Replacement_Price").ConfigValue);
         }
         var _loc1_:String = LanguageMgr.GetTranslation("worldboss.BuyAvatarFrame.command02",_loc3_);
         _selfTipTxt.htmlText = _loc1_;
         var _loc2_:Rectangle = _selfTipTxt.getCharBoundaries(_selfTipTxt.text.indexOf("$"));
         _pointBmp.setFrame(1);
         _pointBmp.y = _selfTipTxt.y;
         _pointBmp.x = _loc2_.x - 9;
         _selfTipTxt.htmlText = _loc1_.replace("$","");
         addToContent(_selfTipTxt);
         addToContent(_pointBmp);
         addToContent(_submitButton);
         addToContent(_cancelButton);
         _loc4_ = null;
      }
      
      private function addEvent() : void
      {
         this.addEventListener("response",__frameResposeHandler);
         _submitButton.addEventListener("click",__onSubmitClick);
         _cancelButton.addEventListener("click",__onCancelClick);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("response",__frameResposeHandler);
         _submitButton.removeEventListener("click",__onSubmitClick);
         _cancelButton.removeEventListener("click",__onCancelClick);
      }
      
      private function __onSubmitClick(param1:MouseEvent = null) : void
      {
         WorldBossSocketOutManager.sendBuyStunmanFor(this.campaignId);
         WorldBossManager.instance.stuntman.buyFor(this.campaignId);
         dispose();
      }
      
      private function __onCancelClick(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function __frameResposeHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
            case 4:
               dispose();
               break;
            case 2:
               __onSubmitClick();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         removeEvent();
         _pointBmp = null;
         _cancelButton = null;
         _selfTipTxt = null;
         _submitButton = null;
         super.dispose();
      }
   }
}

