package tasktracetip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import manager.LanguageMgr;
   import managers.TaskTraceTipManager;
   import tasktracetip.data.TipMessageData;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.service.managers.SocketSendManager;
   
   public class CampaignCardTipView extends TaskTraceTipView
   {
      
      private var txt:FilterFrameText;
      
      private var btn:IconButton;
      
      public function CampaignCardTipView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         var _loc3_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.taskTrace.card.bg");
         var _loc4_:BitmapData = _loc3_.bitmapData;
         var _loc8_:Bitmap = new Bitmap(_loc4_);
         var _loc7_:Matrix = _loc8_.transform.matrix;
         _loc7_.a = -1;
         _loc7_.tx = _loc8_.width;
         _loc8_.transform.matrix = _loc7_;
         _loc8_.x = _loc3_.width * 2;
         var _loc6_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.taskTrace.card.titlebg");
         _loc6_.x = 55;
         _loc6_.y = -20;
         var _loc2_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.taskTrace.campaigncard.title");
         _loc2_.x = 78;
         _loc2_.y = -5;
         var _loc5_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.taskTrace.card.itembg");
         _loc5_.x = 55;
         _loc5_.y = 30;
         var _loc9_:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("campaign.campaignCardIcon");
         txt = ComponentFactory.Instance.creatComponentByStylename("vip.vipCardTxt");
         var _loc1_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("vip.vipCardTipTxt");
         _loc1_.htmlText = LanguageMgr.GetTranslation("tasktracetip.view.campaignCommand01");
         btn = ComponentFactory.Instance.creatComponentByStylename("campaign.useCampaignCardBtn");
         addChild(_loc3_);
         addChild(_loc8_);
         addChild(_loc6_);
         addChild(_loc2_);
         addChild(_loc5_);
         addChild(_loc9_);
         addChild(txt);
         addChild(_loc1_);
         addChild(btn);
      }
      
      override protected function initEvent() : void
      {
         btn.addEventListener("click",__clickHandler);
      }
      
      override protected function removeEvent() : void
      {
         if(btn)
         {
            btn.removeEventListener("click",__clickHandler);
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         useVipCard();
         TaskTraceTipManager.instance.cleanByType(data.type);
      }
      
      override public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         if(data)
         {
            txt.text = data.goods.templateInfo.TemplateName;
         }
         LayerManager.Instance.addToLayer(this,1,true,true,2);
      }
      
      private function useVipCard() : void
      {
         data && SocketSendManager.instance.sendUseItem(data.goods.pos);
      }
      
      override public function set data(param1:TipMessageData) : void
      {
         super._data = param1;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         if(btn)
         {
            btn.dispose();
         }
         btn = null;
         if(txt)
         {
            txt.dispose();
         }
         txt = null;
         if(_data)
         {
            _data.goods = null;
         }
         _data = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

