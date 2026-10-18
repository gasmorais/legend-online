package map.campaign.view.ui
{
   import battle.utils.Int64Utils;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.forbiddenboss.ForbiddenBossMsg;
   import com.road.yishi.proto.forbiddenboss.ForbiddenBossRankMsg;
   import events.KingContractEvents;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.KingContractManager;
   import managers.TheseussoulManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignMapModel;
   import mvc.module.forbiddenboss.ForbiddenBossModel;
   import mvc.module.theseus.TheseussoulModel;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.ForbiddenBossTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.PlayerEvent;
   import yishi.manager.ForbiddenBossManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   
   public class ForbiddenBossView extends Sprite implements Disposeable
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _back:MutipleImage;
      
      private var _vBox:VBox;
      
      private var _mapBtn:IconButton;
      
      private var _txtBg:Bitmap;
      
      private var _txt:FilterFrameText;
      
      private var _autoBtn:IconButton;
      
      private var _lock:Bitmap;
      
      private var _timeTxt:FilterFrameText;
      
      private var _endTime:Number = 0;
      
      public function ForbiddenBossView()
      {
         super();
         initView();
         initEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         var _loc4_:Date = null;
         var _loc1_:String = null;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossView.bg");
         _back = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossView.back");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossView.vBox");
         _mapBtn = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossView.mapBtn");
         _txtBg = ComponentFactory.Instance.creatBitmap("asset.forbiddenBossView.txtBg");
         _txt = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossView.txt");
         _autoBtn = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossView.autoBtn");
         _lock = ComponentFactory.Instance.creatBitmap("asset.ForbiddenBossView.lock");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossItem.refreshTxt");
         addChild(_bg);
         addChild(_back);
         addChild(_vBox);
         addChild(_mapBtn);
         addChild(_txtBg);
         addChild(_txt);
         addChild(_autoBtn);
         addChild(_lock);
         addChild(_timeTxt);
         _timeTxt.x = 75;
         _timeTxt.y = -27;
         _timeTxt.text = "";
         for each(var _loc2_:ForbiddenBossMsg in model.bossList)
         {
            if(_loc2_.bossId == model.SelectBoss)
            {
               if(_loc2_.endTime && Int64Utils.int64ToNumber(_loc2_.endTime) != 0)
               {
                  _endTime = Int64Utils.int64ToNumber(_loc2_.endTime);
                  _loc4_ = new Date(_endTime);
                  _loc1_ = DateFormatter.format(_loc4_,"hh:mm:ss");
                  _loc5_ = _endTime / 1000 - playerModel.sysSecond;
                  _loc3_ = _loc5_ / 60;
                  if(_loc5_ > 0)
                  {
                     _timeTxt.text = LanguageMgr.GetTranslation("forbiddenBossItem.refreshTxt.text3",_loc1_);
                     _timeTxt.setFrame(2);
                  }
               }
            }
         }
         _lock.visible = !KingContractManager.Instance.checkHasBuffById(15);
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function refreshView() : void
      {
         var _loc2_:ForbiddenBossRankItem = null;
         var _loc1_:ForbiddenBossRankMsg = null;
         var _loc3_:int = 0;
         _vBox.removeAllChild();
         _vBox.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < model.rankList.length)
         {
            _loc1_ = model.rankList[_loc3_];
            _loc2_ = new ForbiddenBossRankItem();
            _loc2_.data = _loc1_;
            _vBox.addChild(_loc2_);
            _loc3_++;
         }
         _vBox.commitChanges();
         refreshEquipView();
      }
      
      private function initEvent() : void
      {
         _mapBtn.addEventListener("click",__mapBtnClickHandler);
         playerModel.addEventListener("SYSTIME_UPGRADE_SECOND",__systimeUpdateHandler);
         MsgMan.addObserver("FORBIDDEN_BOSS_RANK_UPDATE",this,__updateRankHandler);
         TheseussoulManager.Instance.addEventListener("EVENT_SUIT_UPDATE",__updateHandler);
         TheseussoulManager.Instance.addEventListener("EVENT_CHOOSE_SUIT",__updateHandler);
         TheseussoulManager.Instance.addEventListener("EVENT_PROPERTY_UPDATE",__updateHandler);
         _autoBtn.addEventListener("click",__autoBtnClickHandler);
         MsgMan.addObserver("FORBIDDEN_BOSS_LIST_UPDATE",this,__updateListHandler);
         NotificationManager.instance.addEventListener("UPDATE_KINGCONTRACT",__updateKingContractHandler);
      }
      
      private function __updateListHandler(param1:String, param2:Object) : void
      {
         for each(var _loc3_:ForbiddenBossMsg in model.bossList)
         {
            if(_loc3_.bossId == model.SelectBoss)
            {
               if(_loc3_.endTime && Int64Utils.int64ToNumber(_loc3_.endTime) != 0)
               {
                  _endTime = Int64Utils.int64ToNumber(_loc3_.endTime);
                  break;
               }
            }
         }
      }
      
      private function removeEvent() : void
      {
         _mapBtn.removeEventListener("click",__mapBtnClickHandler);
         MsgMan.removeObserver("FORBIDDEN_BOSS_LIST_UPDATE",this,__updateListHandler);
         playerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__systimeUpdateHandler);
         MsgMan.removeObserver("FORBIDDEN_BOSS_RANK_UPDATE",this,__updateRankHandler);
         TheseussoulManager.Instance.removeEventListener("EVENT_SUIT_UPDATE",__updateHandler);
         TheseussoulManager.Instance.removeEventListener("EVENT_CHOOSE_SUIT",__updateHandler);
         TheseussoulManager.Instance.removeEventListener("EVENT_PROPERTY_UPDATE",__updateHandler);
         _autoBtn.removeEventListener("click",__autoBtnClickHandler);
         NotificationManager.instance.removeEventListener("UPDATE_KINGCONTRACT",__updateKingContractHandler);
      }
      
      private function __systimeUpdateHandler(param1:PlayerEvent) : void
      {
         var _loc4_:Date = null;
         var _loc2_:String = null;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         if(_endTime != 0)
         {
            _loc4_ = new Date(_endTime);
            _loc2_ = DateFormatter.format(_loc4_,"hh:mm:ss");
            _loc5_ = _endTime / 1000 - playerModel.sysSecond;
            _loc3_ = _loc5_ / 60;
            if(_loc5_ > 0)
            {
               _timeTxt.text = LanguageMgr.GetTranslation("forbiddenBossItem.refreshTxt.text3",_loc2_);
               _timeTxt.setFrame(2);
            }
            else
            {
               _timeTxt.text = "";
            }
         }
      }
      
      private function __updateKingContractHandler(param1:KingContractEvents) : void
      {
         _lock.visible = !KingContractManager.Instance.checkHasBuffById(15);
      }
      
      private function __autoBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc4_:String = null;
         if(KingContractManager.Instance.checkHasBuffById(15))
         {
            NotificationManager.instance.dispatchEvent(new NotificationEvent("WORK_NEXT_NODE",null));
         }
         else
         {
            SimpleAlertHelper.instance.data = [__alertBackHandler];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc5_ = LanguageMgr.GetTranslation("public.prompt");
            _loc4_ = LanguageMgr.GetTranslation("kingcontract.view.allBuyFrontAlert");
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc4_,_loc2_,_loc3_,false,true);
         }
      }
      
      private function __alertBackHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            FrameControllerManager.instance.openControllerByInfo("kingcontract");
         }
      }
      
      private function __updateHandler(param1:Event) : void
      {
         refreshEquipView();
      }
      
      private function refreshEquipView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:ForbiddenBossTempInfo = null;
         var _loc3_:String = null;
         if(mapModel.campaignTemplate)
         {
            _loc1_ = int(mapModel.campaignTemplate.CampaignId);
            _loc2_ = TempleteManager.instance.forbiddenBossTempCate.getTempInfoByCampaignId(_loc1_);
            if(_loc2_)
            {
               _loc3_ = "";
               if(theseusModel.propertys.armour < _loc2_.BAV)
               {
                  _loc3_ = "<font color=\'#ff0000\'>" + theseusModel.propertys.armour + "</font>";
               }
               else
               {
                  _loc3_ = theseusModel.propertys.armour.toString();
               }
               _txt.htmlText = LanguageMgr.GetTranslation("forbiddenBossView.txt.text",_loc3_,_loc2_.BAV);
            }
         }
      }
      
      private function __updateRankHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __mapBtnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("forbiddenboss",4);
      }
      
      private function get model() : ForbiddenBossModel
      {
         return ForbiddenBossManager.instance.model;
      }
      
      private function get mapModel() : CampaignMapModel
      {
         return CampaignManager.instance.mapModel;
      }
      
      private function get theseusModel() : TheseussoulModel
      {
         return TheseussoulManager.Instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

