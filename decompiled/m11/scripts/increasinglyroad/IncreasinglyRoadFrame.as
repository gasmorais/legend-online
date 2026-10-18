package increasinglyroad
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import increasinglyroad.view.IncreasinglyroadLayerItemView;
   import mainBar.ChatBar;
   import manager.LanguageMgr;
   import managers.IncreasinglyRoadManager;
   import mvc.module.increasingly.IncreasinglyBossInfo;
   import mvc.module.increasingly.IncreasinglyModel;
   import ui.maintoolbar.MainToolBar;
   import ui.toptoolbar.TopToolsBar;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.OldPlayerReturnManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManagerHelper;
   import yishi.scene.BaseSceneView;
   import yishi.scene.SceneManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringHelper;
   import yishi.view.base.NumberBitmap;
   import yishi.view.tips.MessageTipManager;
   
   public class IncreasinglyRoadFrame extends BaseSceneView
   {
      
      private var _bg:Image;
      
      private var _titleBg:Image;
      
      private var _titleBg2:Image;
      
      private var _leftBg:Image;
      
      private var _activeValueBg:Image;
      
      private var _smallBg:Image;
      
      private var _activeValueImg:Image;
      
      private var _activeValueImgMask:Shape;
      
      private var _buyActiveBtn:BaseButton;
      
      private var _activePressTxt:FilterFrameText;
      
      private var _upBtn:IconButton;
      
      private var _downBtn:IconButton;
      
      private var _refreshBtn:IconButton;
      
      private var _descTxt:FilterFrameText;
      
      private var _layerBitMap:NumberBitmap;
      
      private var _layerData:BitmapData;
      
      private var _layaItemContain:Sprite;
      
      private var _leftBuyCountMc:MovieClip;
      
      private var _currentLayer:int;
      
      private var _refreshCostDiamondCount:int;
      
      private var _itemList:Array;
      
      private var _maxEnergy:int;
      
      private var _initEnergy:int;
      
      private var _maxBuyCount:int;
      
      private var _currentBuyCost:int;
      
      private var _buyCostInfoArr:Array;
      
      private var _shopBtn:BaseButton;
      
      private var hasGoodItem:Boolean = false;
      
      public function IncreasinglyRoadFrame()
      {
         super();
      }
      
      override public function enter(param1:BaseSceneView, param2:Object = null) : void
      {
         super.enter(param1,param2);
         initView();
         initEvent();
         initData();
         IncreasinglyRoadManager.instance.pageChange();
         TopToolsBar.instance.hide();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("increasinglyroad.bg");
         _titleBg = ComponentFactory.Instance.creatComponentByStylename("increasinglyroad.titleBg");
         _titleBg2 = ComponentFactory.Instance.creatComponentByStylename("increasinglyroad.titleBg2");
         _smallBg = ComponentFactory.Instance.creatComponentByStylename("increasinglyroad.smallBg");
         _leftBg = ComponentFactory.Instance.creatComponentByStylename("increasinglyroad.leftBg");
         _activeValueBg = ComponentFactory.Instance.creatComponentByStylename("increasinglyroad.progressBg");
         _activeValueImg = ComponentFactory.Instance.creatComponentByStylename("increasinglyroad.progressImg");
         _activeValueImgMask = new Shape();
         _activeValueImgMask.graphics.beginFill(0);
         _activeValueImgMask.graphics.drawRect(0,0,_activeValueImg.width,_activeValueImg.height);
         _activeValueImgMask.graphics.endFill();
         _activeValueImgMask.x = _activeValueImg.x;
         _activeValueImgMask.y = _activeValueImg.y;
         _activeValueImg.mask = _activeValueImgMask;
         _activePressTxt = ComponentFactory.Instance.creatComponentByStylename("increasinglyroad.activePressTxt");
         _buyActiveBtn = ComponentFactory.Instance.creatComponentByStylename("increasinglyroad.buyActiveBtn");
         _upBtn = ComponentFactory.Instance.creatComponentByStylename("increasinglyroad.upBtn");
         _downBtn = ComponentFactory.Instance.creatComponentByStylename("increasinglyroad.downBtn");
         _refreshBtn = ComponentFactory.Instance.creatComponentByStylename("increasinglyroad.refreshBtn");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("increasinglyroad.descTxt");
         _descTxt.text = LanguageMgr.GetTranslation("IncreasinglyRoadFrame.descText");
         _layerData = ComponentFactory.Instance.creatBitmap("asset.increasinglyroad.layerNumData").bitmapData;
         _layerBitMap = ComponentFactory.Instance.creatCustomObject("increasinglyroad.layerBitMap");
         _layerBitMap.initParams(null,"asset.increasinglyroad.layerNumData",46,40,26,46,"0123456789",0,0,0,54);
         _layaItemContain = new Sprite();
         _leftBuyCountMc = ComponentFactory.Instance.creatCustomObject("core.InfoTipsMc");
         _leftBuyCountMc.mouseChildren = _leftBuyCountMc.mouseEnabled = false;
         _leftBuyCountMc.visible = false;
         _leftBuyCountMc.x = 990;
         _leftBuyCountMc.y = 675;
         _shopBtn = ComponentFactory.Instance.creatComponentByStylename("IncreasinglyRoadFrame.shopBtn");
         addChild(_bg);
         addChild(_titleBg);
         addChild(_titleBg2);
         addChild(_smallBg);
         addChild(_leftBg);
         addChild(_activeValueBg);
         addChild(_activeValueImg);
         addChild(_activeValueImgMask);
         addChild(_activePressTxt);
         addChild(_buyActiveBtn);
         addChild(_upBtn);
         addChild(_downBtn);
         addChild(_refreshBtn);
         addChild(_descTxt);
         addChild(_layerBitMap);
         addChild(_leftBuyCountMc);
         addChild(_layaItemContain);
         _layaItemContain.x = 385;
         _layaItemContain.y = 105;
         if(VersionSwitch.INCREASINGLY_SHOP)
         {
            addChild(_shopBtn);
         }
      }
      
      private function initEvent() : void
      {
         StageReferance.stage.addEventListener("resize",__resizeHanlder);
         addEventListener("response",__responseHandler);
         if(_upBtn != null)
         {
            _upBtn.addEventListener("click",onPageUpClick);
         }
         if(_downBtn != null)
         {
            _downBtn.addEventListener("click",onPageDownClick);
         }
         _buyActiveBtn.addEventListener("click",onBuyActiveClick);
         _refreshBtn.addEventListener("click",__refreshBtnHandler);
         NotificationManager.instance.addEventListener("INCREASINGLY_ROAD_INFO",onInfo);
         _shopBtn.addEventListener("click",shopClickHandler);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",__resizeHanlder);
         removeEventListener("response",__responseHandler);
         if(_upBtn != null)
         {
            _upBtn.removeEventListener("click",onPageUpClick);
         }
         if(_downBtn != null)
         {
            _downBtn.removeEventListener("click",onPageDownClick);
         }
         _buyActiveBtn.removeEventListener("click",onBuyActiveClick);
         _refreshBtn.removeEventListener("click",__refreshBtnHandler);
         NotificationManager.instance.removeEventListener("INCREASINGLY_ROAD_INFO",onInfo);
         _shopBtn.removeEventListener("click",shopClickHandler);
      }
      
      private function shopClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("shop",1022);
      }
      
      private function initData() : void
      {
         var _loc1_:IncreasinglyroadLayerItemView = null;
         var _loc4_:int = 0;
         var _loc2_:Array = null;
         _itemList = [];
         _loc4_ = 0;
         while(_loc4_ < 6)
         {
            _loc1_ = new IncreasinglyroadLayerItemView();
            _loc1_.isOpen = false;
            _loc1_.x = _loc4_ % 3 * 225;
            _loc1_.y = _loc4_ > 2 ? 245 : 0;
            _layaItemContain.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc4_++;
         }
         var _loc5_:String = ConfigInfoManager.instance.getIncreasinglyRoadRefreshCost();
         if(!StringHelper.isNullOrEmpty(_loc5_))
         {
            _loc2_ = _loc5_.split(",");
            if(_loc2_)
            {
               _refreshCostDiamondCount = _loc2_[2];
               _maxEnergy = _loc2_[1];
               _initEnergy = _maxEnergy;
               model.enterBattleCostEnergy = _loc2_[0];
            }
         }
         _activePressTxt.text = _initEnergy.toString();
         _activeValueImgMask.scaleX = _initEnergy / _maxEnergy > 1 ? 1 : _initEnergy / _maxEnergy;
         _buyCostInfoArr = ConfigInfoManager.instance.getIncreasinglyEnergyBuy();
         var _loc3_:int = int(OldPlayerReturnManager.instance.model.increasinglyRoadCount);
         _maxBuyCount = _buyCostInfoArr.length + _loc3_;
         _upBtn.enable = _downBtn.enable = false;
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      private function __resizeHanlder(param1:Event = null) : void
      {
         x = (StageReferance.gameStageWidth - width) / 2;
         y = (StageReferance.gameStageHeight - height) / 2;
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
      
      private function onPageUpClick(param1:MouseEvent) : void
      {
         model.currentLayer -= 1;
         IncreasinglyRoadManager.instance.pageChange();
      }
      
      private function onPageDownClick(param1:MouseEvent) : void
      {
         model.currentLayer += 1;
         IncreasinglyRoadManager.instance.pageChange();
      }
      
      private function onBuyActiveClick(param1:MouseEvent) : void
      {
         var _loc5_:int = _maxBuyCount - model.todayHasBuyCount;
         if(_loc5_ <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("skyboxroad.SkyBoxRoadFrame.txt3"));
            return;
         }
         var _loc2_:String = _buyCostInfoArr[model.todayHasBuyCount];
         _currentBuyCost = _loc2_.split(",")[0];
         var _loc6_:int = int(_loc2_.split(",")[1]);
         SimpleAlertHelper.instance.data = [buyActiveCallBack];
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc7_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc8_:String = LanguageMgr.GetTranslation("skyboxroad.SkyBoxRoadFrame.txt2",_currentBuyCost,_loc6_,_loc5_);
         SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc8_,_loc3_,_loc4_,true,true,false,2,"SIMPLE_ALERT");
      }
      
      private function buyActiveCallBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(playerInfo.point < _currentBuyCost)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("sacrifice.sacrificeFrame.pointNotEnough"));
               return;
            }
            IncreasinglyRoadManager.instance.buyEnergy();
         }
      }
      
      private function __refreshBtnHandler(param1:MouseEvent) : void
      {
         if(playerInfo.point < _refreshCostDiamondCount)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("sacrifice.sacrificeFrame.pointNotEnough"));
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("active.expback.frame.selectbtntxt");
         var _loc3_:String = LanguageMgr.GetTranslation("increasinglyroad.IncreasinglyRoadFrame.txt",_refreshCostDiamondCount);
         SharedManagerHelper.ins.needAlert("increasinglyroad.IncreasinglyRoadFrame.refreshClick",refreshCallBack,_loc2_,_loc3_);
      }
      
      private function refreshCallBack() : void
      {
         var _loc1_:String = null;
         var _loc4_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(hasGoodItem)
         {
            _loc1_ = LanguageMgr.GetTranslation("increasinglyroad.view.goodItemHint");
            _loc4_ = LanguageMgr.GetTranslation("public.prompt");
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            SimpleAlertHelper.instance.data = [realCallback];
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc1_,_loc2_,_loc3_,false,false,false,1);
         }
         else
         {
            realCallback(true,true);
         }
      }
      
      private function realCallback(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            IncreasinglyRoadManager.instance.refreshCurrentLayerReward();
         }
      }
      
      private function onInfo(param1:Event) : void
      {
         var _loc2_:IncreasinglyroadLayerItemView = null;
         var _loc4_:int = 0;
         hasGoodItem = false;
         var _loc3_:int = int(model.currentLayer);
         if(_loc3_ <= 10)
         {
            _layerBitMap.num = _loc3_ - 1;
         }
         else if(model.currentLayer > 10)
         {
            _layerBitMap.num = 90 + _loc3_ - 11;
         }
         _activePressTxt.text = model.energy.toString();
         _activeValueImgMask.scaleX = model.energy / _maxEnergy > 1 ? 1 : model.energy / _maxEnergy;
         _loc4_ = 0;
         while(_loc4_ < 6)
         {
            _loc2_ = _itemList[_loc4_] as IncreasinglyroadLayerItemView;
            _loc2_.isOpen = isOpen(_loc4_);
            _loc2_.data = model.bossInfos[_loc4_] as IncreasinglyBossInfo;
            if(_loc2_.hasGoodItem)
            {
               hasGoodItem = true;
            }
            _loc4_++;
         }
         model.isRefresh = false;
         _upBtn.enable = model.currentLayer > 1 ? true : false;
         _downBtn.enable = model.currentLayer < model.maxLayer ? true : false;
         _refreshBtn.tipData = ConfigInfoManager.instance.getIncreasinglyTips(model.currentLayer);
         _leftBuyCountMc.visible = true;
         _leftBuyCountMc.txt.text = _maxBuyCount - model.todayHasBuyCount < 0 ? 0 : _maxBuyCount - model.todayHasBuyCount;
      }
      
      private function isOpen(param1:int) : Boolean
      {
         var _loc2_:Boolean = false;
         if(model.currentLayer < model.maxLayer)
         {
            _loc2_ = true;
         }
         else if(param1 + 1 <= model.currentIndex)
         {
            _loc2_ = true;
         }
         else
         {
            _loc2_ = false;
         }
         return _loc2_;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function enterOver() : void
      {
         super.enterOver();
         MainToolBar.instance.updateFriendNoticeBtnPos(false);
         MainToolBar.instance.show();
         ChatBar.instance.show();
         MainToolBar.instance.getButtnByType(10).visible = false;
         MainToolBar.instance.getButtnByType(15).visible = false;
         MainToolBar.instance.getButtnByType(16).visible = false;
         MainToolBar.instance.getButtnByType(9).enable = true;
         MainToolBar.instance.getMovieImageByType(1).visible = false;
         MainToolBar.instance.getMovieImageByType(2).visible = false;
         SceneManager.instance.isEnterFullScene = true;
         __resizeHanlder();
      }
      
      override public function leaving() : void
      {
         dispose();
      }
      
      private function get model() : IncreasinglyModel
      {
         return IncreasinglyRoadManager.instance.model;
      }
      
      override public function get SceneName() : String
      {
         return "INCREASINGLY_ROAD_SCENE";
      }
      
      override public function preLoadingStart(param1:Object = null) : void
      {
         super.preLoadingStart(param1);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,6,true,false,1,0,true);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      public function dispose() : void
      {
         TopToolsBar.instance.show();
         ChatBar.instance.hide();
         FrameControllerManager.instance.increasinglyRoadControler.isIncreasinglyRoadFrame = false;
         SceneManager.instance.isEnterFullScene = false;
         MainToolBar.instance.buttonsStageByScene(SceneManager.instance.currentType);
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_titleBg);
         _titleBg = null;
         ObjectUtils.disposeObject(_titleBg2);
         _titleBg2 = null;
         ObjectUtils.disposeObject(_smallBg);
         _smallBg = null;
         ObjectUtils.disposeObject(_leftBg);
         _leftBg = null;
         ObjectUtils.disposeObject(_upBtn);
         _upBtn = null;
         ObjectUtils.disposeObject(_downBtn);
         _downBtn = null;
         ObjectUtils.disposeObject(_activeValueBg);
         _activeValueBg = null;
         ObjectUtils.disposeObject(_activeValueImg);
         _activeValueImg = null;
         ObjectUtils.disposeObject(_buyActiveBtn);
         _buyActiveBtn = null;
         ObjectUtils.disposeObject(_activePressTxt);
         _activePressTxt = null;
         ObjectUtils.disposeObject(_activeValueImgMask);
         _activeValueImgMask = null;
         ObjectUtils.disposeObject(_refreshBtn);
         _refreshBtn = null;
         ObjectUtils.disposeObject(_descTxt);
         _descTxt = null;
         ObjectUtils.disposeObject(_layerBitMap);
         _layerBitMap = null;
         ObjectUtils.disposeObject(_layerData);
         _layerData = null;
         ObjectUtils.disposeObject(_layaItemContain);
         _layaItemContain = null;
         ObjectUtils.disposeViolentMc(_leftBuyCountMc);
         _leftBuyCountMc = null;
         ObjectUtils.disposeObject(_shopBtn);
         _shopBtn = null;
         for each(var _loc1_:IncreasinglyroadLayerItemView in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _itemList = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

