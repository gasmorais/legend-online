package map.campaign.view.house
{
   import battle.chat.FurnitureChatController;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import farm.FarmManager;
   import farm.view.FarmBonCdTimeView;
   import farm.view.FarmInfoView;
   import farm.view.FarmToolbar;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import home.HomeSender;
   import mainBar.ChatBar;
   import manager.LanguageMgr;
   import managers.HomeManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.helper.house.FurnitureSortHelper;
   import map.campaign.view.layer.CampaignMainBuidingLayer;
   import map.campaign.view.layer.CampaignWalkLayer;
   import mvc.module.home.FurnitureInfo;
   import mvc.module.home.HomeModel;
   import ui.maintoolbar.MainToolBar;
   import ui.resourcebar.ResourcesBar;
   import water.view.FarmFriendListView;
   import yishi.datas.templates.FurnitureTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   import yishi.utils.WorldBossHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class HouseUIView extends Sprite implements Disposeable
   {
      
      private var _titleSp:Sprite;
      
      private var _right:Sprite;
      
      private var _store:HouseStoreView;
      
      private var _titleBg:Image;
      
      private var _titleIcon:ScaleFrameImage;
      
      private var _titleTxt:GradientText;
      
      private var _setBtn:IconButton;
      
      private var _moveBtn:IconButton;
      
      private var _rotationBtn:IconButton;
      
      private var _recoverBtn:IconButton;
      
      private var _friendListView:FarmFriendListView;
      
      private var _farmInfoView:FarmInfoView;
      
      private var _farmToolbar:FarmToolbar;
      
      private var _myHouseBtn:BaseButton;
      
      private var _cdTime:FarmBonCdTimeView;
      
      private var _leftTimeText:FilterFrameText;
      
      private var _bonfireBtn:BaseButton;
      
      private var _leftTime:int;
      
      private var _uint:uint;
      
      private var _currentLuxu:int;
      
      public function HouseUIView()
      {
         super();
         initView();
         initevent();
         __resizeHandler(null);
      }
      
      private function initView() : void
      {
         _titleBg = ComponentFactory.Instance.creatComponentByStylename("HouseUIView.titleBg");
         _titleIcon = ComponentFactory.Instance.creatComponentByStylename("HouseUIView.titleIcon");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("HouseUIView.titleTxt");
         _setBtn = ComponentFactory.Instance.creatComponentByStylename("HouseUIView.setBtn");
         _moveBtn = ComponentFactory.Instance.creatComponentByStylename("HouseUIView.moveBtn");
         _rotationBtn = ComponentFactory.Instance.creatComponentByStylename("HouseUIView.rotationBtn");
         _recoverBtn = ComponentFactory.Instance.creatComponentByStylename("HouseUIView.recoverBtn");
         _myHouseBtn = ComponentFactory.Instance.creatComponentByStylename("HomeFrame.returnHomeBtn");
         _bonfireBtn = ComponentFactory.Instance.creatComponentByStylename("HouseUIView.bonfireBtn");
         _leftTimeText = ComponentFactory.Instance.creatComponentByStylename("farm.bigbon.statusTxt");
         _myHouseBtn.tipData = LanguageMgr.GetTranslation("map.campaign.view.house.HouseUIView.myHouse");
         _titleSp = new Sprite();
         _right = furnitureLayer.btnSp;
         _store = new HouseStoreView();
         _friendListView = new FarmFriendListView();
         if(inHome)
         {
            _farmToolbar = new FarmToolbar();
            _farmInfoView = new FarmInfoView();
         }
         _cdTime = new FarmBonCdTimeView();
         addChild(_titleSp);
         addChild(_friendListView);
         _friendListView.type = 1;
         if(_farmInfoView)
         {
            addChild(_farmInfoView);
         }
         if(_farmToolbar)
         {
            addChild(_farmToolbar);
         }
         addChild(_bonfireBtn);
         addChild(_leftTimeText);
         addChild(_myHouseBtn);
         addChild(_store);
         addChild(_cdTime);
         _titleSp.addChild(_titleBg);
         _titleSp.addChild(_titleIcon);
         _titleSp.addChild(_titleTxt);
         _titleSp.addChild(_setBtn);
         _right.addChild(_moveBtn);
         _right.addChild(_rotationBtn);
         _right.addChild(_recoverBtn);
         _moveBtn.tipData = LanguageMgr.GetTranslation("HouseUIView.moveBtn");
         _rotationBtn.tipData = LanguageMgr.GetTranslation("HouseUIView.rotationBtn");
         _recoverBtn.tipData = LanguageMgr.GetTranslation("HouseUIView.recoverBtn");
         if(inHouse)
         {
            _titleTxt.text = LanguageMgr.GetTranslation("map.campaign.view.house.HouseUIView.buyName",model.info.houseName);
            _titleIcon.setFrame(1);
         }
         else if(inHome)
         {
            _titleTxt.text = LanguageMgr.GetTranslation("map.campaign.view.house.HouseUIView.buyName",model.info.homeName);
            _titleIcon.setFrame(2);
         }
         _titleSp.mouseEnabled = false;
         _setBtn.mouseEnabled = true;
         refresh();
         setFixUp();
         farmStatusChange(null);
      }
      
      private function initevent() : void
      {
         StageReferance.stage.addEventListener("resize",__resizeHandler);
         if(_setBtn)
         {
            _setBtn.addEventListener("click",__setBtnHandler);
         }
         if(_moveBtn)
         {
            _moveBtn.addEventListener("click",__moveBtnHandler);
         }
         if(_rotationBtn)
         {
            _rotationBtn.addEventListener("click",__rotationBtnHandler);
         }
         if(_recoverBtn)
         {
            _recoverBtn.addEventListener("click",__recoverBtnHandler);
         }
         if(_myHouseBtn)
         {
            _myHouseBtn.addEventListener("click",__myHouseBtnClick);
         }
         if(_bonfireBtn)
         {
            _bonfireBtn.addEventListener("click",__onBonfireClickHandler);
         }
         MsgMan.addObserver("ChildEvent.FIX_CHANGE",this,__fixChangeHandler);
         MsgMan.addObserver("ChildEvent.FURN_CLICK",this,__furnSelectedHandler);
         MsgMan.addObserver("ChildEvent.HOME_INFO",this,__infoHandler);
         MsgMan.addObserver("ChildEvent.ADD_OR_REMOVE",this,__addOrRemoveHandler);
         MsgMan.addObserver("ChildEvent.STORE_BUY",this,__storeBuyHandler);
         MsgMan.addObserver("ChildEvent.SPECIAL_REFRESH",this,__specialRefreshHandler);
         FarmManager.instance.model.addEventListener("FARM_BIGBONFIRE_STATUS",farmStatusChange);
         FarmManager.instance.model.addEventListener("FARM_SELECTED_CHANGE",farmStatusChange);
         FarmManager.instance.model.addEventListener("FARM_BONFIRE_BEGIN_TIME",farmStatusChange);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",__resizeHandler);
         if(_setBtn)
         {
            _setBtn.removeEventListener("click",__setBtnHandler);
         }
         if(_moveBtn)
         {
            _moveBtn.removeEventListener("click",__moveBtnHandler);
         }
         if(_rotationBtn)
         {
            _rotationBtn.removeEventListener("click",__rotationBtnHandler);
         }
         if(_recoverBtn)
         {
            _recoverBtn.removeEventListener("click",__recoverBtnHandler);
         }
         if(_myHouseBtn)
         {
            _myHouseBtn.removeEventListener("click",__myHouseBtnClick);
         }
         if(_bonfireBtn)
         {
            _bonfireBtn.removeEventListener("click",__onBonfireClickHandler);
         }
         MsgMan.removeObserver("ChildEvent.FIX_CHANGE",this,__fixChangeHandler);
         MsgMan.removeObserver("ChildEvent.FURN_CLICK",this,__furnSelectedHandler);
         MsgMan.removeObserver("ChildEvent.HOME_INFO",this,__infoHandler);
         MsgMan.removeObserver("ChildEvent.ADD_OR_REMOVE",this,__addOrRemoveHandler);
         MsgMan.removeObserver("ChildEvent.STORE_BUY",this,__storeBuyHandler);
         MsgMan.removeObserver("ChildEvent.SPECIAL_REFRESH",this,__specialRefreshHandler);
         FarmManager.instance.model.removeEventListener("FARM_BIGBONFIRE_STATUS",farmStatusChange);
         FarmManager.instance.model.removeEventListener("FARM_SELECTED_CHANGE",farmStatusChange);
         FarmManager.instance.model.removeEventListener("FARM_BONFIRE_BEGIN_TIME",farmStatusChange);
      }
      
      private function farmStatusChange(param1:Event = null) : void
      {
         var _loc2_:Date = null;
         _leftTimeText.text = "";
         _bonfireBtn.enable = true;
         furnitureLayer.setFindPathData();
         if(FarmManager.instance.model.bigBonFireIsOpen)
         {
            _setBtn.enable = false;
            hideFurnitures();
         }
         else
         {
            _setBtn.enable = true;
            showFurnitures();
         }
         if(FarmManager.instance.model.masterId != ArmyManager.instance.thane.userId)
         {
            _bonfireBtn.enable = false;
            _setBtn.enable = false;
         }
         else if(FarmManager.instance.model.isBigBonfire || FarmManager.instance.model.beginLeftTime > 0)
         {
            _bonfireBtn.enable = false;
            _loc2_ = PlayerManager.instance.currentPlayerModel.sysCurtime;
            _loc2_.setDate(_loc2_.date + 1);
            _loc2_.setHours(0);
            _loc2_.setMinutes(0);
            _loc2_.setSeconds(0);
            _leftTime = _loc2_.valueOf() / 1000 - PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
            _leftTimeText.text = DateFormatter.getConsortiaCountDate(_leftTime);
            _uint = setInterval(updateTime,1000);
         }
      }
      
      private function updateTime() : void
      {
         _leftTime = _leftTime - 1;
         if(_leftTime <= 0)
         {
            clearInterval(_uint);
            if(_leftTimeText != null)
            {
               _leftTimeText.text = "";
            }
            if(_bonfireBtn != null)
            {
               _bonfireBtn.enable = true;
            }
            return;
         }
         if(_bonfireBtn != null)
         {
            _bonfireBtn.enable = false;
         }
         if(_leftTimeText != null)
         {
            _leftTimeText.text = DateFormatter.getConsortiaCountDate(_leftTime);
         }
      }
      
      private function __specialRefreshHandler(param1:String, param2:Object) : void
      {
         var _loc3_:int = 0;
         var _loc4_:FurnitureInfo = param2 as FurnitureInfo;
         if(furnitureLayer && _loc4_)
         {
            _loc3_ = 0;
            while(_loc3_ < model.fixUpList.length)
            {
               if(model.fixUpList[_loc3_].templateInfo.Type == _loc4_.templateInfo.Type)
               {
                  furnitureLayer.removeFurniture(model.fixUpList[_loc3_]);
                  break;
               }
               _loc3_++;
            }
            furnitureLayer.addFurniture(_loc4_);
            refresh();
            MsgMan.notifyObserver("ChildEvent.ADD_OR_REMOVE");
         }
      }
      
      private function __storeBuyHandler(param1:String, param2:Object) : void
      {
         if(_store)
         {
            if(model.inBuy)
            {
               if(_store.parent)
               {
                  _store.parent.removeChild(_store);
               }
               LayerManager.Instance.addToLayer(_store,2,false,false,1);
            }
            else
            {
               addChild(_store);
            }
         }
      }
      
      private function __addOrRemoveHandler(param1:String, param2:Object) : void
      {
         model.isChange = true;
         refresh();
      }
      
      private function __infoHandler(param1:String, param2:Object) : void
      {
         refresh();
      }
      
      private function refresh() : void
      {
         var _loc1_:FurnitureTempInfo = null;
         var _loc2_:* = null;
         var _loc3_:* = undefined;
         _currentLuxu = 0;
         if(model.inFixUp && model.masterId == PlayerManager.instance.currentPlayerModel.playerInfo.userId)
         {
            for each(_loc2_ in model.fixUpList)
            {
               _loc1_ = TempleteManager.instance.furnitureTemplateCate.getTempById(_loc2_.templateId);
               _currentLuxu += _loc1_.Luxury;
            }
         }
         else
         {
            _loc3_ = new Vector.<FurnitureInfo>();
            if(inHouse)
            {
               _loc3_ = model.info.layList1;
            }
            else if(inHome)
            {
               _loc3_ = model.info.layList2;
            }
            for each(_loc2_ in _loc3_)
            {
               _loc1_ = TempleteManager.instance.furnitureTemplateCate.getTempById(_loc2_.templateId);
               _currentLuxu += _loc1_.Luxury;
            }
         }
      }
      
      private function __myHouseBtnClick(param1:MouseEvent) : void
      {
         FarmManager.instance.model.curSelectedUserInfo = ArmyManager.instance.thane;
         HomeSender.enterHouse(PlayerManager.instance.currentPlayerModel.playerInfo.userId);
      }
      
      private function __furnSelectedHandler(param1:String, param2:Object) : void
      {
         if(_right)
         {
            _right.x = model.opPoint.x;
            _right.y = model.opPoint.y;
            if(_right.y + _right.height > furnitureLayer.globalToLocal(new Point(_store.x,_store.y)).y)
            {
               _right.y = furnitureLayer.globalToLocal(new Point(_store.x,_store.y)).y - _right.height - 5;
            }
            _right.visible = model.inFixUp && Boolean(model.isSelf) && model.clickFurn;
         }
      }
      
      private function __fixChangeHandler(param1:String, param2:Object) : void
      {
         model.selectFurn = null;
         model.clickFurn = null;
         setFixUp();
         if(furnitureLayer && !model.inFixUp)
         {
            furnitureLayer.refreshFurniture();
         }
         refresh();
         model.isChange = false;
      }
      
      private function __setBtnHandler(param1:Event) : void
      {
         model.inFixUp = true;
         MsgMan.notifyObserver("ChildEvent.FIX_CHANGE");
      }
      
      private function __moveBtnHandler(param1:Event) : void
      {
         if(model.inFixUp == false || !model.isSelf)
         {
            return;
         }
         if(model.selectFurn == null)
         {
            model.clickFurn.x = StageReferance.stage.mouseX;
            model.clickFurn.y = StageReferance.stage.mouseY;
            model.selectFurn = model.clickFurn;
         }
         if(furnitureLayer && model.clickFurn)
         {
            furnitureLayer.removeFurniture(model.clickFurn);
         }
         model.clickFurn = null;
         MsgMan.notifyObserver("ChildEvent.ADD_OR_REMOVE");
      }
      
      private function __rotationBtnHandler(param1:Event) : void
      {
         if(model.inFixUp == false || !model.isSelf)
         {
            return;
         }
         if(model.clickFurn)
         {
            if(model.clickFurn.canRotation1)
            {
               if(model.clickFurn.canRotation2)
               {
                  if(furnitureLayer)
                  {
                     furnitureLayer.removeFurniture(model.clickFurn);
                     model.clickFurn.setRotation();
                     FurnitureSortHelper.dealWith(model.fixUpList,furnitureLayer.addFurniture,model.clickFurn);
                  }
               }
               else
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("map.campaign.view.house.HouseUIView.noRotation2"));
               }
            }
            else
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("map.campaign.view.house.HouseUIView.noRotation1"));
            }
         }
      }
      
      private function __recoverBtnHandler(param1:Event) : void
      {
         if(model.inFixUp == false || !model.isSelf)
         {
            return;
         }
         if(furnitureLayer && model.clickFurn)
         {
            furnitureLayer.removeFurniture(model.clickFurn);
         }
         model.selectFurn = null;
         model.clickFurn = null;
         if(furnitureLayer)
         {
            furnitureLayer.setFixState();
         }
         MsgMan.notifyObserver("ChildEvent.ADD_OR_REMOVE");
      }
      
      private function setFixUp() : void
      {
         if(walkLayer)
         {
            walkLayer.visible = !model.inFixUp || !model.isSelf;
         }
         if(mainBuidingLayer)
         {
            mainBuidingLayer.visible = !model.inFixUp || !model.isSelf;
         }
         if(_setBtn)
         {
            _setBtn.enable = !model.inFixUp && Boolean(model.isSelf);
         }
         if(_right)
         {
            _right.x = model.opPoint.x;
            _right.y = model.opPoint.y;
            if(_right.y + _right.height > furnitureLayer.globalToLocal(new Point(_store.x,_store.y)).y)
            {
               _right.y = furnitureLayer.globalToLocal(new Point(_store.x,_store.y)).y - _right.height - 5;
            }
            _right.visible = model.inFixUp && Boolean(model.isSelf) && model.clickFurn;
         }
         if(_bonfireBtn)
         {
            _bonfireBtn.visible = !model.inFixUp;
            _bonfireBtn.enable = model.isSelf;
         }
         if(_store)
         {
            _store.visible = model.inFixUp && Boolean(model.isSelf);
         }
         if(_farmInfoView)
         {
            _farmInfoView.visible = !model.inFixUp;
         }
         if(_friendListView)
         {
            _friendListView.visible = !model.inFixUp;
         }
         if(_myHouseBtn)
         {
            _myHouseBtn.visible = !model.inFixUp && !model.isSelf && inHouse;
         }
         if(furnitureLayer)
         {
            furnitureLayer.setFixState();
         }
         if(model.inFixUp)
         {
            ResourcesBar.instance.hide();
            MainToolBar.instance.hide();
            MainToolBar.instance.poptipButtonVisible = false;
            ChatBar.instance.hide();
            FurnitureChatController.getInstance().start();
         }
         else
         {
            if(inHouse)
            {
               ResourcesBar.instance.show();
            }
            MainToolBar.instance.show();
            MainToolBar.instance.poptipButtonVisible = true;
            FurnitureChatController.getInstance().dispose();
            ChatBar.instance.show();
         }
      }
      
      private function __resizeHandler(param1:Event) : void
      {
         _titleSp.y = 5;
         _titleSp.x = (StageReferance.stageWidth - 308) / 2;
         _right.x = model.opPoint.x;
         _right.y = model.opPoint.y;
         _store.x = (StageReferance.stageWidth - _store.bgWidth) / 2;
         _store.y = StageReferance.stageHeight - 170;
         if(_right.y + _right.height > furnitureLayer.globalToLocal(new Point(_store.x,_store.y)).y)
         {
            _right.y = furnitureLayer.globalToLocal(new Point(_store.x,_store.y)).y - _right.height - 5;
         }
         if(_myHouseBtn && _friendListView)
         {
            _friendListView.x = StageReferance.stageWidth - _friendListView.width;
            _friendListView.y = (StageReferance.stageHeight - _friendListView.height) / 4;
            _friendListView.setBack();
            _bonfireBtn.x = _titleSp.x + _titleSp.width + 5;
            _leftTimeText.x = _bonfireBtn.x - 5;
            _leftTimeText.y = _bonfireBtn.y;
            _myHouseBtn.x = StageReferance.stageWidth - _myHouseBtn.width - 30;
            _myHouseBtn.y = _friendListView.y + _friendListView.height - 100;
            if(_farmToolbar && inHome)
            {
               _farmToolbar.x = StageReferance.stageWidth - _farmToolbar.width - 50;
               _farmToolbar.y = _friendListView.y + _friendListView.height + 5;
            }
         }
         if(_cdTime)
         {
            _cdTime.x = (StageReferance.gameStageWidth - _cdTime.bgWidth) / 2;
            _cdTime.y = StageReferance.gameStageHeight * 0.78;
         }
      }
      
      private function __onBonfireClickHandler(param1:MouseEvent) : void
      {
         sendOpenFire();
      }
      
      private function hideFurnitures() : void
      {
         var _loc1_:int = 0;
         if(furnitureLayer)
         {
            _loc1_ = 0;
            while(_loc1_ < model.fixUpList.length)
            {
               if(!isSpecialType(model.fixUpList[_loc1_].templateInfo.Type))
               {
                  furnitureLayer.removeFurniture(model.fixUpList[_loc1_]);
                  _loc1_ -= 1;
               }
               _loc1_++;
            }
         }
         model.selectFurn = null;
         model.clickFurn = null;
         MsgMan.notifyObserver("ChildEvent.ADD_OR_REMOVE");
      }
      
      private function showFurnitures() : void
      {
         MsgMan.notifyObserver("ChildEvent.FIX_CHANGE");
      }
      
      private function isSpecialType(param1:int) : Boolean
      {
         return (param1 == 1 || param1 == 2) && inHouse;
      }
      
      private function sendOpenFire() : void
      {
         var _loc1_:CampaignArmy = CampaignManager.instance.mapModel.selfMemberData;
         var _loc2_:Array = CampaignManager.instance.mapModel.getMapNodesByType(1001);
         if(!_loc2_ || _loc2_.length <= 0)
         {
            return;
         }
         CampaignManager.instance.controller.sendCampaignArrive(_loc1_.id,_loc2_[0].nodeId);
      }
      
      private function get furnitureLayer() : FurnitureLayer
      {
         if(CampaignManager.instance.mapView)
         {
            return CampaignManager.instance.mapView.furnitureLayer;
         }
         return null;
      }
      
      private function get walkLayer() : CampaignWalkLayer
      {
         if(CampaignManager.instance.mapView)
         {
            return CampaignManager.instance.mapView.walkLayer;
         }
         return null;
      }
      
      private function get mainBuidingLayer() : CampaignMainBuidingLayer
      {
         if(CampaignManager.instance.mapView)
         {
            return CampaignManager.instance.mapView.mainBuidingLayer;
         }
         return null;
      }
      
      private function get model() : HomeModel
      {
         return HomeManager.instance.model;
      }
      
      private function get inHome() : Boolean
      {
         return WorldBossHelper.checkInHome(CampaignManager.instance.mapId);
      }
      
      private function get inHouse() : Boolean
      {
         return WorldBossHelper.checkInHouse(CampaignManager.instance.mapId);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_titleBg);
         _titleBg = null;
         ObjectUtils.disposeObject(_titleIcon);
         _titleIcon = null;
         ObjectUtils.disposeObject(_titleTxt);
         _titleTxt = null;
         ObjectUtils.disposeObject(_setBtn);
         _setBtn = null;
         ObjectUtils.disposeObject(_moveBtn);
         _moveBtn = null;
         ObjectUtils.disposeObject(_rotationBtn);
         _rotationBtn = null;
         ObjectUtils.disposeObject(_recoverBtn);
         _recoverBtn = null;
         ObjectUtils.disposeObject(_bonfireBtn);
         _bonfireBtn = null;
         ObjectUtils.disposeAllChildren(_titleSp);
         ObjectUtils.disposeObject(_titleSp);
         _titleSp = null;
         ObjectUtils.disposeAllChildren(_right);
         ObjectUtils.disposeObject(_right);
         _right = null;
         ObjectUtils.disposeObject(_store);
         _store = null;
         if(_friendListView)
         {
            _friendListView.dispose();
         }
         _friendListView = null;
         ObjectUtils.disposeObject(_farmToolbar);
         _farmToolbar = null;
         ObjectUtils.disposeObject(_farmInfoView);
         _farmInfoView = null;
         ObjectUtils.disposeObject(_cdTime);
         _cdTime = null;
         ObjectUtils.disposeObject(_leftTimeText);
         _leftTimeText = null;
         clearInterval(_uint);
         if(parent)
         {
            parent.removeChild(this);
         }
         FarmManager.instance.model.leftTime = -1;
         FarmManager.instance.model.beginLeftTime = -1;
      }
   }
}

