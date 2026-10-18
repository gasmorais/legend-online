package kingcontract
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.KingContractEvents;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.KingContractManager;
   import mvc.module.kingcontract.KingContractInfo;
   import mvc.module.kingcontract.KingContractModel;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class KingContractFrame extends Frame implements IManualSize
   {
      
      private var _back:DisplayObject;
      
      private var _bg:Bitmap;
      
      private var _tileList:SimpleTileList;
      
      private var _view:KingContractView;
      
      private var _ad:Bitmap;
      
      private var _rechargeBtn:IconButton;
      
      private var _friendBtn:IconButton;
      
      private var _openMarketBtn:IconButton;
      
      private var _getBuffBtn:IconButton;
      
      private var _helpBtn:BaseButton;
      
      private var _openNowBtn:IconButton;
      
      private var _timeTxt:FilterFrameText;
      
      private var _leftTime:Bitmap;
      
      private var _kingInfo:KingContractInfo;
      
      private var _diamondNum:Bitmap;
      
      private var _scrollPanel:ScrollPanel;
      
      public function KingContractFrame()
      {
         super();
         initView();
         refreshView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("kingcontract.Back");
         _bg = ComponentFactory.Instance.creatBitmap("asset.kingcontract.gaiyaBg");
         _tileList = ComponentFactory.Instance.creatCustomObject("kingcontract.SimpleTileList",[2]);
         _ad = ComponentFactory.Instance.creatBitmap("asset.kingcontract.AD");
         _rechargeBtn = ComponentFactory.Instance.creatComponentByStylename("kingcontract.RechargeBtn");
         _friendBtn = ComponentFactory.Instance.creatComponentByStylename("kingcontract.FriendBtn");
         _openMarketBtn = ComponentFactory.Instance.creatComponentByStylename("kingcontract.openMarket");
         _getBuffBtn = ComponentFactory.Instance.creatComponentByStylename("kingcontract.fetchBtn");
         _openNowBtn = ComponentFactory.Instance.creatComponentByStylename("kingcontract.openNowBtn");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("kingcontract.HelpBtn");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("kingcontract.TimeTxt");
         _leftTime = ComponentFactory.Instance.creatBitmap("asset.kingcontract.leftTimeImg");
         _diamondNum = ComponentFactory.Instance.creatBitmap("asset.kingcontract.diamondNum");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("kingcontract.ScrollPanel");
         _helpBtn.tipData = LanguageMgr.GetTranslation("kingcontract.view.HelpFrame.helpTipData");
         _friendBtn.visible = false;
         _kingInfo = model.kingContractInfos[2];
         _timeTxt.x = _leftTime.x + _leftTime.width + 5;
         addToContent(_bg);
         addToContent(_back);
         addToContent(_ad);
         addToContent(_tileList);
         addToContent(_scrollPanel);
         addToContent(_rechargeBtn);
         addToContent(_friendBtn);
         addToContent(_getBuffBtn);
         addToContent(_openMarketBtn);
         addToContent(_openNowBtn);
         addToContent(_timeTxt);
         addToContent(_leftTime);
         addToContent(_diamondNum);
         var _loc1_:KingContractInfo = KingContractManager.Instance.model.getInfoById(6);
         if(_loc1_.leftTime > 0 && isGetKingBuffer)
         {
            _getBuffBtn.enable = false;
         }
         _scrollPanel.setView(_tileList);
      }
      
      private function refreshView() : void
      {
         var _loc3_:KingContractInfo = null;
         ObjectUtils.disposeAllChildren(_tileList);
         _tileList.beginChanges();
         var _loc1_:int = 0;
         for each(var _loc2_:int in KingContractModel.SORT_ARR)
         {
            _loc3_ = model.kingContractInfos[_loc2_];
            _view = new KingContractView();
            _view.data = _loc3_;
            _tileList.addChild(_view);
            _loc1_++;
         }
         _tileList.commitChanges();
         _scrollPanel.invalidateViewport();
         if(isKing)
         {
            if(_rechargeBtn)
            {
               _rechargeBtn.visible = true;
            }
            if(_getBuffBtn)
            {
               _getBuffBtn.visible = true;
            }
            if(_openMarketBtn)
            {
               _openMarketBtn.visible = true;
            }
            if(_openNowBtn)
            {
               _openNowBtn.visible = false;
            }
            _getBuffBtn.enable = canGetBuff;
            _openMarketBtn.enable = canOpenMarket;
            _timeTxt.visible = true;
            _leftTime.visible = true;
            _diamondNum.y = 361;
            if(isGetKingBuffer)
            {
               _getBuffBtn.enable = false;
            }
         }
         else
         {
            if(_rechargeBtn)
            {
               _rechargeBtn.visible = false;
            }
            if(_getBuffBtn)
            {
               _getBuffBtn.visible = false;
            }
            if(_openMarketBtn)
            {
               _openMarketBtn.visible = false;
            }
            if(_openNowBtn)
            {
               _openNowBtn.visible = true;
            }
            _timeTxt.visible = false;
            _leftTime.visible = false;
            _diamondNum.y = 378;
         }
         if(_openMarketBtn)
         {
            _openMarketBtn.visible = false;
         }
      }
      
      private function get model() : KingContractModel
      {
         return KingContractManager.Instance.model;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _rechargeBtn.addEventListener("click",__buyHandler);
         _openNowBtn.addEventListener("click",__buyHandler);
         _friendBtn.addEventListener("click",__friendBtnClickHandler);
         _getBuffBtn.addEventListener("click",__fetchBtnHandler);
         _openMarketBtn.addEventListener("click",__openBtnHandler);
         _helpBtn.addEventListener("click",__helpHandler);
         NotificationManager.instance.addEventListener("UPDATE_KINGCONTRACT",__updateKingContractHandler);
         NotificationManager.instance.addEventListener("KING_CONTRACT_BUFF_GET",__buffGetHandler);
         NotificationManager.instance.addEventListener("KING_CONTRACT",_closeSwitchHandler);
         _kingInfo.addEventListener("change",__changeHandler);
         _kingInfo.addEventListener("complete",__completeHandler);
         refreshTime();
      }
      
      private function _closeSwitchHandler(param1:NotificationEvent) : void
      {
         if(!VersionSwitch.KING_CONTRACT)
         {
            dispose();
         }
      }
      
      private function __buffGetHandler(param1:NotificationEvent) : void
      {
         if(_getBuffBtn)
         {
            _getBuffBtn.enable = false;
         }
      }
      
      private function __helpHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("kingcontract.HelpFrame");
         _loc2_.show();
      }
      
      private function __updateKingContractHandler(param1:KingContractEvents) : void
      {
         refreshView();
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _rechargeBtn.removeEventListener("click",__buyHandler);
         _openNowBtn.removeEventListener("click",__buyHandler);
         _friendBtn.removeEventListener("click",__friendBtnClickHandler);
         _getBuffBtn.removeEventListener("click",__fetchBtnHandler);
         _openMarketBtn.removeEventListener("click",__openBtnHandler);
         _helpBtn.removeEventListener("click",__helpHandler);
         NotificationManager.instance.removeEventListener("UPDATE_KINGCONTRACT",__updateKingContractHandler);
         NotificationManager.instance.removeEventListener("KING_CONTRACT_BUFF_GET",__buffGetHandler);
         NotificationManager.instance.removeEventListener("KING_CONTRACT",_closeSwitchHandler);
         _kingInfo.removeEventListener("change",__changeHandler);
         _kingInfo.removeEventListener("complete",__completeHandler);
      }
      
      private function __changeHandler(param1:Event) : void
      {
         var _loc2_:String = "";
         if(_kingInfo.leftTime >= 86400)
         {
            _loc2_ = int(_kingInfo.leftTime / 86400) + LanguageMgr.GetTranslation("public.day");
         }
         else if(_kingInfo.leftTime >= 3600)
         {
            _loc2_ = int(_kingInfo.leftTime / 3600) + LanguageMgr.GetTranslation("public.time.hour");
         }
         else if(_kingInfo.leftTime >= 60)
         {
            _loc2_ = int(_kingInfo.leftTime / 60) + LanguageMgr.GetTranslation("public.minute");
         }
         else
         {
            _loc2_ = _kingInfo.leftTime + LanguageMgr.GetTranslation("task.view.TaskMobilePhoneView.Text1");
         }
         _timeTxt.text = _loc2_;
         _timeTxt.width = _timeTxt.textWidth + 3;
         _timeTxt.setFrame(2);
      }
      
      private function __completeHandler(param1:Event) : void
      {
         _timeTxt.text = LanguageMgr.GetTranslation("kingcontract.view.CloseTxt");
         _timeTxt.width = _timeTxt.textWidth + 3;
      }
      
      private function refreshTime() : void
      {
         var _loc1_:Number = Number(_kingInfo.leftTime);
         if(_loc1_ > 0)
         {
            __changeHandler(null);
         }
         else
         {
            _timeTxt.text = LanguageMgr.GetTranslation("kingcontract.view.CloseTxt");
            _timeTxt.width = _timeTxt.textWidth + 3;
            _timeTxt.setFrame(1);
         }
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("kingcontract.KingContractFrame.title");
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __openBtnHandler(param1:Event) : void
      {
         var _loc2_:String = null;
         if(thane.grades < 26)
         {
            _loc2_ = LanguageMgr.GetTranslation("kingcontract.view.openMarket.fail");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
      }
      
      private function __fetchBtnHandler(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(KingContractManager.Instance.checkHasBuffById(6))
         {
            SimpleAlertHelper.instance.data = [fetchResponse];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc4_ = LanguageMgr.GetTranslation("public.prompt");
            _loc5_ = LanguageMgr.GetTranslation("KingContractFrame.fetchMessage");
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,false,true);
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("KingContractFrame.noOpen"));
         }
      }
      
      private function fetchResponse(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            KingContractManager.Instance.sendKingContractFench();
         }
      }
      
      private function __buyHandler(param1:MouseEvent) : void
      {
         var _loc5_:String = null;
         SoundManager.instance.play("022");
         SimpleAlertHelper.instance.data = [__alertBackHandler];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         if(param1.currentTarget == _openNowBtn)
         {
            _loc5_ = LanguageMgr.GetTranslation("kingcontract.view.allBuy1",point,day);
         }
         else if(param1.currentTarget == _rechargeBtn)
         {
            _loc5_ = LanguageMgr.GetTranslation("kingcontract.view.allBuy2",point,day);
         }
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,false,true);
      }
      
      private function __alertBackHandler(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:Array = null;
         if(param1)
         {
            if(playerInfo.point < point)
            {
               RechargeAlertMannager.show();
               return;
            }
            _loc3_ = KingContractManager.Instance.kingList;
            KingContractManager.Instance.sendKingContract(_loc3_);
         }
      }
      
      private function __friendBtnClickHandler(param1:MouseEvent) : void
      {
         if(!VersionSwitch.KING_CONTRACT)
         {
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("kingcontract",1);
      }
      
      private function get day() : int
      {
         return (KingContractManager.Instance.model.kingContractInfos[2] as KingContractInfo).template.Duration / 1440;
      }
      
      private function get point() : int
      {
         return int(TempleteManager.instance.getConfigInfoByConfigName("All_KingContract").ConfigValue);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP"];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,672,555);
      }
      
      private function get isGetKingBuffer() : Boolean
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo.isGetKingBuffer;
      }
      
      private function get canGetBuff() : Boolean
      {
         return KingContractManager.Instance.model.getInfoById(6).leftTime > 0;
      }
      
      private function get canOpenMarket() : Boolean
      {
         return true;
      }
      
      private function get isKing() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:Array = KingContractModel.SORT_ARR;
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            if(KingContractManager.Instance.model.getInfoById(_loc1_[_loc2_]).leftTime > 0)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_rechargeBtn);
         _rechargeBtn = null;
         ObjectUtils.disposeObject(_openNowBtn);
         _openNowBtn = null;
         ObjectUtils.disposeObject(_friendBtn);
         _friendBtn = null;
         ObjectUtils.disposeObject(_view);
         _view = null;
         ObjectUtils.disposeAllChildren(_tileList);
         ObjectUtils.disposeObject(_tileList);
         _tileList = null;
         ObjectUtils.disposeObject(_ad);
         _ad = null;
         ObjectUtils.disposeObject(_openMarketBtn);
         _openMarketBtn = null;
         ObjectUtils.disposeObject(_getBuffBtn);
         _getBuffBtn = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeObject(_leftTime);
         _leftTime = null;
         ObjectUtils.disposeObject(_diamondNum);
         _diamondNum = null;
         _kingInfo = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

