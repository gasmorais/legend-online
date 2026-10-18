package planeswar.view.eventframe
{
   import chat.ChatSocketOutManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.PlanesWarEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.events.PlayerEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlanesWarManager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.DateFormatter;
   import yishi.view.frame.BuyFrameI;
   import yishi.view.tips.MessageTipManager;
   
   public class PlanesGetHelpFrame extends Frame
   {
      
      private var back:Image;
      
      private var remainTimeImage:Image;
      
      private var remainText:FilterFrameText;
      
      private var worldBtn:BaseButton;
      
      private var timer:Timer;
      
      private var lastSecond:int;
      
      private var lastTimeInfo:ConfigInfosTempInfo;
      
      private var _sendHelpFlag:Boolean;
      
      public function PlanesGetHelpFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("PlanesGetHelpFrame.back");
         remainTimeImage = ComponentFactory.Instance.creatComponentByStylename("PlanesGetHelpFrame.remainTimeImage");
         remainText = ComponentFactory.Instance.creatComponentByStylename("PlanesGetHelpFrame.remainText");
         worldBtn = ComponentFactory.Instance.creatComponentByStylename("PlanesGetHelpFrame.worldBtn");
         addToContent(back);
         addToContent(remainTimeImage);
         addToContent(remainText);
         addToContent(worldBtn);
         timer = new Timer(1000);
         lastTimeInfo = TempleteManager.instance.getConfigInfoByConfigName("planes_help_revive_time");
         lastSecond = parseInt(lastTimeInfo.ConfigValue);
         remainText.text = DateFormatter.getCountDateByMS(lastSecond);
         titleText = LanguageMgr.GetTranslation("PlanesGetHelpFrame.titleText");
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         worldBtn.addEventListener("click",__worldBtnClickHandler);
         PlanesWarManager.instance.addEventListener("HELP_RERIVE_BACK",__helpReveiveBackHandler);
         thane.addEventListener("SMALL_BUGLE_FREE_COUNT",__smallBugleFreeCountHandler);
         timer.addEventListener("timer",__timerHandler);
         timer.start();
      }
      
      protected function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __helpReveiveBackHandler(param1:PlanesWarEvent) : void
      {
         if(PlanesWarManager.instance.model.planesWarInfo.dead == false)
         {
            dispose();
         }
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         if(lastSecond > 0)
         {
            lastSecond = lastSecond - 1;
            remainText.text = DateFormatter.getCountDateByMS(lastSecond);
         }
         else
         {
            dispose();
         }
      }
      
      private function __worldBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc4_:String = null;
         SoundManager.instance.play("022");
         var _loc3_:int = int(GoodsManager.instance.getGoodsNumByTempId(208003));
         if(_loc3_ == 0)
         {
            if(thane.smallBugleFreeCount <= 0)
            {
               _loc4_ = LanguageMgr.GetTranslation("chat.view.ChatInputView.command06");
               MessageTipManager.instance().show(_loc4_);
               CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback);
               return;
            }
            _sendHelpFlag = true;
            ChatSocketOutManager.sendSmallBugleFreeCount();
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         var _loc5_:String = LanguageMgr.GetTranslation("PlanesGetHelpFrame.worldHelp.content");
         SharedManagerHelper.ins.needAlert("planeswar.view.eventframe.PlanesGetHelpFrame.worldHelp",worldHelpResultHandler,_loc2_,_loc5_);
      }
      
      private function worldHelpResultHandler() : void
      {
         PlanesWarManager.instance.sendPlanesOpMsg(33,[1]);
      }
      
      private function __smallBugleFreeCountHandler(param1:PlayerEvent) : void
      {
         var _loc4_:String = null;
         if(!_sendHelpFlag)
         {
            return;
         }
         _sendHelpFlag = false;
         var _loc3_:int = int(GoodsManager.instance.getGoodsNumByTempId(208003));
         if(_loc3_ == 0)
         {
            if(thane.smallBugleFreeCount <= 0)
            {
               _loc4_ = LanguageMgr.GetTranslation("chat.view.ChatInputView.command06");
               MessageTipManager.instance().show(_loc4_);
               CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback);
               return;
            }
         }
         var _loc2_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         var _loc5_:String = LanguageMgr.GetTranslation("PlanesGetHelpFrame.worldHelp.content");
         SharedManagerHelper.ins.needAlert("planeswar.view.eventframe.PlanesGetHelpFrame.worldHelp",worldHelpResultHandler,_loc2_,_loc5_);
      }
      
      private function quickUIcallback() : void
      {
         var _loc1_:BuyFrameI = ComponentFactory.Instance.creatComponentByStylename("quickbuy.buyFrame");
         var _loc2_:ShopGoodsInfo = TempleteManager.instance.getShopTempInfoByItemId(208003);
         _loc1_.data(_loc2_);
         _loc1_.show();
      }
      
      private function removeEvent() : void
      {
         if(worldBtn)
         {
            worldBtn.removeEventListener("click",__worldBtnClickHandler);
         }
         PlanesWarManager.instance.removeEventListener("HELP_RERIVE_BACK",__helpReveiveBackHandler);
         thane.removeEventListener("SMALL_BUGLE_FREE_COUNT",__smallBugleFreeCountHandler);
         removeEventListener("response",__frameResponse);
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1,0,true);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         KeyBoardRegister.instance.keyEnable = true;
         if(timer)
         {
            timer.stop();
            timer.removeEventListener("timer",__timerHandler);
            timer = null;
         }
         if(back)
         {
            ObjectUtils.disposeObject(back);
         }
         back = null;
         if(remainTimeImage)
         {
            ObjectUtils.disposeObject(remainTimeImage);
         }
         remainTimeImage = null;
         if(remainText)
         {
            ObjectUtils.disposeObject(remainText);
         }
         remainText = null;
         if(worldBtn)
         {
            ObjectUtils.disposeObject(worldBtn);
         }
         worldBtn = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

