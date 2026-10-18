package map.internals.view.treasuremap
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.TreasureMapEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mainBar.effects.MainToolBtnGlowEffect;
   import manager.LanguageMgr;
   import managers.FreedomTeamManager;
   import managers.TreasureMapManager;
   import managers.TreasureMapSocketOutManager;
   import map.internals.view.treasuremap.getframe.TreasureMapGetItemView;
   import mvc.module.treasuremap.TreasureMapModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class TreasureMapGetFrame extends Frame
   {
      
      private var _refreshBtn:IconButton;
      
      private var _quicklyRefreshBtn:IconButton;
      
      private var _getBtn:IconButton;
      
      private var _helpBtn:BaseButton;
      
      private var _bg:Bitmap;
      
      private var _scaleBg:Scale9CornerImage;
      
      private var _treasureNameTxt:FilterFrameText;
      
      private var _tipsTxt:FilterFrameText;
      
      private var _mapNameBg:Bitmap;
      
      private var _getTimes:FilterFrameText;
      
      private var _getTimesImg:Bitmap;
      
      private var _itemContainer:Sprite;
      
      private var _itemList:Array;
      
      private var _quickPointsCost:int = 0;
      
      private var _quickItemCost:int = 0;
      
      private var _refreshPointsCost:int = 0;
      
      private var _refreshItemCost:int = 0;
      
      private var _effect:MainToolBtnGlowEffect;
      
      public function TreasureMapGetFrame()
      {
         super();
         _quickItemCost = getConfigValue("treasure_refresh_item");
         _quickPointsCost = _quickItemCost * 5;
         initView();
         addEvent();
         TreasureMapSocketOutManager.sendRequestTreasureMap();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","CASTLE_BUIDING_GROUP","BAG_GROUP"];
      }
      
      private function getConfigValue(param1:String) : int
      {
         if(TempleteManager.instance.getConfigInfoByConfigName(param1))
         {
            return int(TempleteManager.instance.getConfigInfoByConfigName(param1).ConfigValue);
         }
         return 0;
      }
      
      private function initView() : void
      {
         var _loc1_:TreasureMapGetItemView = null;
         var _loc2_:int = 0;
         titleText = LanguageMgr.GetTranslation("map.internals.view.treasuremap.TreasureMapGetFrame.Title");
         _refreshBtn = ComponentFactory.Instance.creatComponentByStylename("treasuremap.TreasureMapGetFrame.RefreshBtn");
         _quicklyRefreshBtn = ComponentFactory.Instance.creatComponentByStylename("treasuremap.TreasureMapGetFrame.QuicklyRefreshBtn");
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("treasuremap.TreasureMapGetFrame.GetBtn");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("treasuremap.TreasureMapGetFrame.helpBtn");
         _treasureNameTxt = ComponentFactory.Instance.creatComponentByStylename("treasuremap.TreasureMapGetFrame.TreasureNameTxt");
         _tipsTxt = ComponentFactory.Instance.creatComponentByStylename("treasuremap.TreasureMapGetFrame.TipsTxt");
         _scaleBg = ComponentFactory.Instance.creatComponentByStylename("treasuremap.TreasureMapUseFrame.scaleGetBg");
         _bg = ComponentFactory.Instance.creatBitmap("asset.treasuremap.getBg");
         _mapNameBg = ComponentFactory.Instance.creatBitmap("asset.treasuremap.getMapNameBg");
         _getTimes = ComponentFactory.Instance.creatComponentByStylename("treasuremap.TreasureMapGetFrame.getTimesTxt");
         _getTimesImg = ComponentFactory.Instance.creatBitmap("asset.treasuremap.getTimesImg");
         _itemContainer = ComponentFactory.Instance.creatCustomObject("treasuremap.TreasureMapGetFrame.Container");
         addToContent(_bg);
         addToContent(_scaleBg);
         addToContent(_refreshBtn);
         addToContent(_quicklyRefreshBtn);
         addToContent(_helpBtn);
         addToContent(_getBtn);
         addToContent(_mapNameBg);
         addToContent(_treasureNameTxt);
         addToContent(_tipsTxt);
         addToContent(_getTimesImg);
         addToContent(_getTimes);
         addToContent(_itemContainer);
         _helpBtn.tipData = LanguageMgr.GetTranslation("treasuremap.treasureMap.helpTipData");
         _quicklyRefreshBtn.tipData = LanguageMgr.GetTranslation("map.internals.view.treasuremap.TreasureMapGetFrame.quicklyRefreshBtnTipsTxt",_quickPointsCost,_quickItemCost);
         _tipsTxt.text = LanguageMgr.GetTranslation("map.internals.view.treasuremap.TreasureMapGetFrame.TipsTxt");
         _itemList = [];
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = new TreasureMapGetItemView(_loc2_ + 1);
            _loc1_.x = _loc2_ * (_loc1_.width + 5);
            _itemContainer.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
         _effect = new MainToolBtnGlowEffect(_quicklyRefreshBtn);
         _effect.stop();
      }
      
      private function uninitView() : void
      {
         _itemList = null;
         ObjectUtils.disposeAllChildren(_itemContainer);
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_scaleBg);
         _scaleBg = null;
         ObjectUtils.disposeObject(_refreshBtn);
         _refreshBtn = null;
         ObjectUtils.disposeObject(_quicklyRefreshBtn);
         _quicklyRefreshBtn = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_getBtn);
         _getBtn = null;
         ObjectUtils.disposeObject(_mapNameBg);
         _mapNameBg = null;
         ObjectUtils.disposeObject(_treasureNameTxt);
         _treasureNameTxt = null;
         ObjectUtils.disposeObject(_tipsTxt);
         _tipsTxt = null;
         ObjectUtils.disposeObject(_getTimesImg);
         _getTimesImg = null;
         ObjectUtils.disposeObject(_getTimes);
         _getTimes = null;
         ObjectUtils.disposeObject(_itemContainer);
         _itemContainer = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__responseHandler);
         if(_refreshBtn)
         {
            _refreshBtn.addEventListener("click",__refreshBtnClickHandler);
         }
         if(_quicklyRefreshBtn)
         {
            _quicklyRefreshBtn.addEventListener("click",__quicklyRefreshBtnClickHandler);
         }
         if(_getBtn)
         {
            _getBtn.addEventListener("click",__getBtnClickHandler);
         }
         _helpBtn.addEventListener("click",__helpBtnClickHandler);
         model.addEventListener("TREASURE_INFO_UPDATE",__treasureInfoUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         if(_refreshBtn)
         {
            _refreshBtn.removeEventListener("click",__refreshBtnClickHandler);
         }
         if(_quicklyRefreshBtn)
         {
            _quicklyRefreshBtn.removeEventListener("click",__quicklyRefreshBtnClickHandler);
         }
         if(_getBtn)
         {
            _getBtn.removeEventListener("click",__getBtnClickHandler);
         }
         _helpBtn.removeEventListener("click",__helpBtnClickHandler);
         model.removeEventListener("TREASURE_INFO_UPDATE",__treasureInfoUpdateHandler);
      }
      
      private function __treasureInfoUpdateHandler(param1:TreasureMapEvent) : void
      {
         var _loc3_:TreasureMapGetItemView = null;
         var _loc5_:int = 0;
         var _loc2_:int = int(model.templateIds[model.index]);
         var _loc4_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc2_);
         _refreshItemCost = _loc4_.Property3;
         _refreshPointsCost = _refreshItemCost * 5;
         _treasureNameTxt.text = _loc4_.TemplateName;
         _treasureNameTxt.setFrame(model.index + 1);
         _getTimes.text = model.joinMax - model.joinCount + " / " + model.joinMax;
         _loc5_ = 0;
         while(_loc5_ < 4)
         {
            _loc3_ = _itemList[_loc5_] as TreasureMapGetItemView;
            _loc4_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(model.templateIds[_loc5_]);
            _loc3_.data = _loc4_;
            if(_loc5_ < model.index)
            {
               _loc3_.selected = false;
               _loc3_.discard = true;
            }
            else if(_loc5_ == model.index)
            {
               _loc3_.selected = true;
               _loc3_.discard = false;
            }
            else
            {
               _loc3_.selected = false;
               _loc3_.discard = false;
            }
            _loc5_++;
         }
         _refreshBtn.tipData = LanguageMgr.GetTranslation("map.internals.view.treasuremap.TreasureMapGetFrame.refreshBtnTipsTxt",_refreshPointsCost,_refreshItemCost);
         setBtnEnabled();
      }
      
      private function setBtnEnabled() : void
      {
         if(model.index >= 3 || model.joinCount >= model.joinMax)
         {
            _refreshBtn.enable = false;
            _quicklyRefreshBtn.enable = false;
         }
         else
         {
            _refreshBtn.enable = true;
            _quicklyRefreshBtn.enable = true;
            if(!model.isFirstQuest)
            {
               _effect.play();
            }
         }
         if(model.joinCount >= model.joinMax)
         {
            _getBtn.enable = false;
         }
         else
         {
            _getBtn.enable = true;
         }
      }
      
      public function get quicklyRefreshBtn() : IconButton
      {
         return _quicklyRefreshBtn;
      }
      
      private function __helpBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("treasuremap.TreasureMapGetFrame.HelpFrame");
         _loc2_.show();
      }
      
      private function __getBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc5_:TodayNotAlertFrame = null;
         var _loc4_:String = null;
         var _loc2_:String = null;
         var _loc3_:Boolean = !SharedManager.instance.receiveMapFlag;
         if(_loc3_ && !FreedomTeamManager.instance.teamIsFull)
         {
            _loc5_ = ComponentFactory.Instance.creatComponentByStylename("worldboss.RiverNotAlert2");
            _loc4_ = LanguageMgr.GetTranslation("map.internals.view.treasuremap.TreasureMapGetFrame.getBtnAlertTxt");
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc5_.show(_loc4_,_loc2_,receiveMap,null,"center",2,true);
         }
         else if(model.joinCount < model.joinMax)
         {
            TreasureMapSocketOutManager.sendGetTreasureMap();
         }
      }
      
      private function receiveMap(param1:Boolean) : void
      {
         if(param1)
         {
            SharedManager.instance.receiveMapFlag = param1;
         }
         TreasureMapSocketOutManager.sendGetTreasureMap();
      }
      
      private function __quicklyRefreshBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc6_:TodayNotAlertFrame = null;
         var _loc5_:String = null;
         var _loc2_:String = null;
         _effect.stop();
         var _loc4_:Boolean = !SharedManager.instance.quicklyRefreshRewardNotAlert;
         var _loc3_:Boolean = Boolean(SharedManager.instance.quicklyRefreshRewardUseBind);
         if(_loc4_)
         {
            _loc6_ = ComponentFactory.Instance.creatComponentByStylename("worldboss.RiverNotAlert");
            _loc5_ = LanguageMgr.GetTranslation("map.internals.view.treasuremap.TreasureMapGetFrame.quicklyRefreshBtnAlertTxt",_quickPointsCost);
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc6_.show(_loc5_,_loc2_,quickRefreshTreasure,null,"center",2,true);
         }
         else if(model.joinCount < model.joinMax)
         {
            sendRefreshTreasureMap(true,_loc3_);
         }
      }
      
      private function __refreshBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc6_:TodayNotAlertFrame = null;
         var _loc5_:String = null;
         var _loc2_:String = null;
         _effect.stop();
         var _loc4_:Boolean = !SharedManager.instance.refreshRewardNotAlert;
         var _loc3_:Boolean = Boolean(SharedManager.instance.refreshRewardUseBind);
         if(_loc4_)
         {
            _loc6_ = ComponentFactory.Instance.creatComponentByStylename("worldboss.RiverNotAlert");
            _loc5_ = LanguageMgr.GetTranslation("map.internals.view.treasuremap.TreasureMapGetFrame.refreshBtnAlertTxt",_refreshPointsCost);
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc6_.show(_loc5_,_loc2_,refreshTreasure,null,"center",2,true);
         }
         else if(model.joinCount < model.joinMax)
         {
            sendRefreshTreasureMap(false,_loc3_);
         }
      }
      
      private function refreshTreasure(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            SharedManager.instance.refreshRewardNotAlert = param1;
            SharedManager.instance.refreshRewardUseBind = param2;
         }
         sendRefreshTreasureMap(false,param2);
      }
      
      private function quickRefreshTreasure(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            SharedManager.instance.quicklyRefreshRewardNotAlert = param1;
            SharedManager.instance.quicklyRefreshRewardUseBind = param2;
         }
         sendRefreshTreasureMap(true,param2);
      }
      
      private function sendRefreshTreasureMap(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:int = int(playerInfo.point);
         var _loc4_:int = int(GoodsManager.instance.getBagCountByTempId(1,208050));
         var _loc5_:int = 0;
         _loc3_ += _loc4_ * 5;
         if(param2)
         {
            _loc3_ += playerInfo.giftToken;
         }
         if(param1)
         {
            _loc5_ = _quickPointsCost;
         }
         else
         {
            _loc5_ = _refreshPointsCost;
         }
         if(_loc3_ >= _loc5_)
         {
            TreasureMapSocketOutManager.sendRefreshTreasureMap(param1,param2);
         }
         else
         {
            RechargeAlertMannager.show();
         }
      }
      
      private function __responseHandler(param1:FrameEvent) : void
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
      
      public function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function show() : void
      {
         var _loc1_:String = null;
         if(model.joinCount == model.joinMax)
         {
            _loc1_ = LanguageMgr.GetTranslation("map.internals.view.treasuremap.TreasureMapGetFrame.JoinMaxTipTxt");
            MessageTipManager.instance().show(_loc1_);
            dispose();
            return;
         }
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      private function get model() : TreasureMapModel
      {
         return TreasureMapManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

