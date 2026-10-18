package map.campaign.view.ui.airgarden
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mainBar.effects.MainToolBtnGlowEffect;
   import manager.LanguageMgr;
   import managers.AirGardenManager;
   import mvc.module.airgarden.AirGardenModel;
   import utils.LogicUtils;
   import yishi.SwitchPageHelp;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.utils.MsgMan;
   import yishi.utils.StringHelper;
   
   public class AirGardenCampaignRightView extends Component
   {
      
      private var _rightBack:MutipleImage;
      
      private var _friendBtn:SelectedIconButton;
      
      private var _serverBtn:SelectedIconButton;
      
      private var _titleBack:Bitmap;
      
      private var _rankText:FilterFrameText;
      
      private var _nameText:FilterFrameText;
      
      private var _upText:FilterFrameText;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _itemBox:VBox;
      
      private var itemList:Vector.<AirGardenCampaignRightItem>;
      
      private var _pageBack:Image;
      
      private var _pageText:FilterFrameText;
      
      private var _firstBtn:BaseButton;
      
      private var _lastBtn:BaseButton;
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _myGardenBtn:IconButton;
      
      private var _smallMapBtn:IconButton;
      
      private var pageCount:int = 10;
      
      private var _pageNumMax:int = 1;
      
      private var _currentPageNum:int;
      
      private var _formatStr:String = "{0} / {1}";
      
      private var _smallMapFrame:AirGardenCampaignSmallMapFrame;
      
      private var _mapEffect:MainToolBtnGlowEffect;
      
      public function AirGardenCampaignRightView()
      {
         super();
         initView();
         initListView();
         addEvent();
         _btnGroup.selectIndex = 0;
         AirGardenManager.instance.requestAirGarden(2);
         __updateCampainDetailHandler(null,null);
      }
      
      private function initView() : void
      {
         _rightBack = ComponentFactory.Instance.creatComponentByStylename("AirGardenCampaignRightView.rightBack");
         _friendBtn = ComponentFactory.Instance.creatComponentByStylename("AirGardenCampaignRightView.friendBtn");
         _serverBtn = ComponentFactory.Instance.creatComponentByStylename("AirGardenCampaignRightView.serverBtn");
         _titleBack = ComponentFactory.Instance.creatBitmap("asset.AirGardenCampaignRightView.titleBack");
         _rankText = ComponentFactory.Instance.creatComponentByStylename("AirGardenCampaignRightView.rankText");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("AirGardenCampaignRightView.nameText");
         _upText = ComponentFactory.Instance.creatComponentByStylename("AirGardenCampaignRightView.upText");
         _itemBox = ComponentFactory.Instance.creatComponentByStylename("AirGardenCampaignRightView.itemBox");
         _pageBack = ComponentFactory.Instance.creatComponentByStylename("AirGardenCampaignRightView.PageNumBack");
         _pageText = ComponentFactory.Instance.creatComponentByStylename("AirGardenCampaignRightView.ListPageText");
         _firstBtn = ComponentFactory.Instance.creatComponentByStylename("AirGardenCampaignRightView.ListFirstBtn");
         _lastBtn = ComponentFactory.Instance.creatComponentByStylename("AirGardenCampaignRightView.ListLastBtn");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("AirGardenCampaignRightView.ListPreBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("AirGardenCampaignRightView.ListNextBtn");
         _smallMapBtn = ComponentFactory.Instance.creatComponentByStylename("AirGardenCampaignRightView.smallMapBtn");
         _myGardenBtn = ComponentFactory.Instance.creatComponentByStylename("AirGardenCampaignRightView.myGardenBtn");
         addChild(_rightBack);
         addChild(_friendBtn);
         addChild(_serverBtn);
         addChild(_titleBack);
         addChild(_rankText);
         addChild(_nameText);
         addChild(_upText);
         addChild(_itemBox);
         addChild(_firstBtn);
         addChild(_preBtn);
         addChild(_pageBack);
         addChild(_pageText);
         addChild(_nextBtn);
         addChild(_lastBtn);
         addChild(_myGardenBtn);
         addChild(_smallMapBtn);
         _rankText.text = LanguageMgr.GetTranslation("colosseum.view.HeroRankFrame.rank");
         _nameText.text = LanguageMgr.GetTranslation("Auction.ResultListTitle2");
         _upText.text = LanguageMgr.GetTranslation("AirGardenCampaignRightView.upText.text");
         _firstBtn.tipData = LanguageMgr.GetTranslation("public.firstPage");
         _lastBtn.tipData = LanguageMgr.GetTranslation("public.lastPage");
         _preBtn.tipData = LanguageMgr.GetTranslation("public.prePage");
         _nextBtn.tipData = LanguageMgr.GetTranslation("public.nextPage");
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_friendBtn);
         _btnGroup.addSelectItem(_serverBtn);
         _mapEffect = new MainToolBtnGlowEffect(_smallMapBtn);
         _mapEffect.stop();
         this.mouseEnabled = false;
      }
      
      private function initListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:AirGardenCampaignRightItem = null;
         itemList = new Vector.<AirGardenCampaignRightItem>();
         _loc2_ = 0;
         while(_loc2_ < pageCount)
         {
            _loc1_ = new AirGardenCampaignRightItem(_loc2_ + 1);
            _loc1_.pageNum = 1;
            _itemBox.addChild(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         _firstBtn.addEventListener("click",__firstClickHandler);
         _lastBtn.addEventListener("click",__lastClickHandler);
         _preBtn.addEventListener("click",__preSelectedHandler);
         _nextBtn.addEventListener("click",__nextSelectedHandler);
         _btnGroup.addEventListener("change",__changeListHandler);
         _myGardenBtn.addEventListener("click",__myGardenClickHandler);
         _smallMapBtn.addEventListener("click",__smallMapClickHandler);
         MsgMan.addObserver("PARTY_LIST_UPDATE",this,__updateListHandler);
         MsgMan.addObserver("CAMPAIGN_DETAIL_UPDATE",this,__updateCampainDetailHandler);
      }
      
      private function removeEvent() : void
      {
         if(_firstBtn)
         {
            _firstBtn.removeEventListener("click",__firstClickHandler);
         }
         if(_lastBtn)
         {
            _lastBtn.removeEventListener("click",__lastClickHandler);
         }
         if(_preBtn)
         {
            _preBtn.removeEventListener("click",__preSelectedHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.removeEventListener("click",__nextSelectedHandler);
         }
         if(_btnGroup)
         {
            _btnGroup.removeEventListener("change",__changeListHandler);
         }
         if(_myGardenBtn)
         {
            _myGardenBtn.removeEventListener("click",__myGardenClickHandler);
         }
         if(_smallMapBtn)
         {
            _smallMapBtn.removeEventListener("click",__smallMapClickHandler);
         }
         MsgMan.removeObserver("PARTY_LIST_UPDATE",this,__updateListHandler);
         MsgMan.removeObserver("CAMPAIGN_DETAIL_UPDATE",this,__updateCampainDetailHandler);
      }
      
      private function __updateCampainDetailHandler(param1:String, param2:Object) : void
      {
         if(model.campaignInfo.masterUserId == thane.userId && Boolean(model.hasFreeBed))
         {
            _mapEffect.play();
         }
         else
         {
            _mapEffect.stop();
         }
      }
      
      private function __updateListHandler(param1:String, param2:Object) : void
      {
         _pageNumMax = Math.ceil(tabShowList.length / pageCount);
         if(_pageNumMax <= 0)
         {
            _pageNumMax = 1;
         }
         currentPageNum = 1;
         refreshView();
      }
      
      private function __changeListHandler(param1:Event) : void
      {
         _pageNumMax = Math.ceil(tabShowList.length / pageCount);
         if(_pageNumMax <= 0)
         {
            _pageNumMax = 1;
         }
         currentPageNum = 1;
         refreshView();
      }
      
      private function __myGardenClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         SwitchPageHelp.enterAirGardenCampaign(thane.userId);
      }
      
      private function __smallMapClickHandler(param1:MouseEvent) : void
      {
         if(_smallMapFrame != null && _smallMapFrame.parent != null)
         {
            _smallMapFrame.dispose();
            _smallMapFrame = null;
         }
         else
         {
            _smallMapFrame = ComponentFactory.Instance.createComponentGroupByStylename("airGarden.AirGardenCampaignSmallMapFrame");
            _smallMapFrame.show();
         }
         _mapEffect.stop();
      }
      
      private function __firstClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         currentPageNum = 1;
         refreshView();
      }
      
      private function __lastClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         currentPageNum = _pageNumMax;
         refreshView();
      }
      
      private function __preSelectedHandler(param1:MouseEvent) : void
      {
         currentPageNum = currentPageNum - 1;
         refreshView();
      }
      
      private function __nextSelectedHandler(param1:MouseEvent) : void
      {
         currentPageNum = currentPageNum + 1;
         refreshView();
      }
      
      public function get currentPageNum() : int
      {
         return _currentPageNum;
      }
      
      public function set currentPageNum(param1:int) : void
      {
         if(param1 < 1)
         {
            return;
         }
         if(param1 > _pageNumMax)
         {
            return;
         }
         _currentPageNum = param1;
         updatePageInfo();
      }
      
      private function updatePageInfo() : void
      {
         if(_firstBtn)
         {
            _firstBtn.enable = currentPageNum > 1;
         }
         if(_preBtn)
         {
            _preBtn.enable = currentPageNum > 1;
         }
         if(_lastBtn)
         {
            _lastBtn.enable = currentPageNum < _pageNumMax;
         }
         if(_nextBtn)
         {
            _nextBtn.enable = currentPageNum < _pageNumMax;
         }
         if(_pageText)
         {
            _pageText.text = StringHelper.format(_formatStr,_currentPageNum,_pageNumMax);
         }
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:AirGardenCampaignRightItem = null;
         var _loc3_:Array = currentList;
         _loc2_ = 0;
         while(_loc2_ < pageCount)
         {
            _loc1_ = itemList[_loc2_];
            _loc1_.pageNum = currentPageNum;
            _loc1_.data = _loc3_[_loc2_];
            _loc2_++;
         }
         _myGardenBtn.visible = model.campaignInfo.masterUserId != thane.userId;
      }
      
      private function get currentList() : Array
      {
         var _loc2_:* = null;
         var _loc1_:int = (currentPageNum - 1) * pageCount;
         var _loc3_:int = Math.min(_loc1_ + pageCount,tabShowList.length);
         return tabShowList.slice(_loc1_,_loc3_);
      }
      
      private function get tabShowList() : Array
      {
         return _btnGroup.selectIndex == 0 ? model.friendPartyList : model.serverPartyList;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,4,false,false);
      }
      
      private function get model() : AirGardenModel
      {
         return AirGardenManager.instance.model;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_rightBack);
         _rightBack = null;
         ObjectUtils.disposeObject(_friendBtn);
         _friendBtn = null;
         ObjectUtils.disposeObject(_serverBtn);
         _serverBtn = null;
         ObjectUtils.disposeObject(_titleBack);
         _titleBack = null;
         ObjectUtils.disposeObject(_rankText);
         _rankText = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_upText);
         _upText = null;
         ObjectUtils.disposeObject(_itemBox);
         _itemBox = null;
         ObjectUtils.disposeObject(_pageBack);
         _pageBack = null;
         ObjectUtils.disposeObject(_pageText);
         _pageText = null;
         ObjectUtils.disposeObject(_firstBtn);
         _firstBtn = null;
         ObjectUtils.disposeObject(_lastBtn);
         _lastBtn = null;
         ObjectUtils.disposeObject(_preBtn);
         _preBtn = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         ObjectUtils.disposeObject(_smallMapFrame);
         _smallMapFrame = null;
         _mapEffect.dispose();
         _mapEffect = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         super.dispose();
      }
   }
}

