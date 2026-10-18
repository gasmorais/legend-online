package navigation
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.NavigationManager;
   import mvc.module.navigation.NavigationBoatInfo;
   import mvc.module.navigation.NavigationModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.FriendManager;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class NavigationInviteFrame extends Frame
   {
      
      private var _inviteText:FilterFrameText;
      
      private var _helpText:FilterFrameText;
      
      private var _alertImage:Bitmap;
      
      private var _back:ScaleBitmapImage;
      
      private var _inviteBtn:IconButton;
      
      private var _vbox:VBox;
      
      private var _itemList:Vector.<NavigationInviteItem>;
      
      private var _lastPageBtn:BaseButton;
      
      private var _nextPageBtn:BaseButton;
      
      private var _pageBg:Image;
      
      private var _pageTxt:FilterFrameText;
      
      private var _pageCount:int = 7;
      
      private var _pageNumMax:int = 1;
      
      private var _currentPageNum:int;
      
      private var _formatStr:String = "{0} / {1}";
      
      private var _maxInviteCount:int;
      
      private var _maxHelpCount:int;
      
      private var _boatInfo:NavigationBoatInfo;
      
      private var userList:Array = [];
      
      private var allOnline:Array = [];
      
      private var isSelect:Boolean = false;
      
      public function NavigationInviteFrame()
      {
         super();
         _maxInviteCount = ConfigInfoManager.instance.getNavigationBoatUpgradeInviteNum();
         _maxHelpCount = ConfigInfoManager.instance.getNavigationBoatUpgradeAssistNum();
         initView();
         initListView();
         initData();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _inviteText = ComponentFactory.Instance.creatComponentByStylename("NavigationInviteFrame.inviteText");
         _helpText = ComponentFactory.Instance.creatComponentByStylename("NavigationInviteFrame.helpText");
         _alertImage = ComponentFactory.Instance.creatBitmap("asset.NavigationInviteFrame.alertImage");
         _back = ComponentFactory.Instance.creatComponentByStylename("NavigationInviteFrame.back");
         _inviteBtn = ComponentFactory.Instance.creatComponentByStylename("NavigationInviteFrame.inviteBtn");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("NavigationInviteFrame.lookPageBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("NavigationInviteFrame.lookPageTextStyle");
         _lastPageBtn = ComponentFactory.Instance.creatComponentByStylename("NavigationInviteFrame.lookLastPageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("NavigationInviteFrame.lookNextPageBtn");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("NavigationInviteFrame.vbox");
         addToContent(_inviteText);
         addToContent(_helpText);
         addToContent(_alertImage);
         addToContent(_back);
         addToContent(_lastPageBtn);
         addToContent(_nextPageBtn);
         addToContent(_pageBg);
         addToContent(_pageTxt);
         addToContent(_vbox);
         addToContent(_inviteBtn);
      }
      
      private function initData() : void
      {
         var _loc3_:ThaneInfo = null;
         var _loc1_:int = 0;
         var _loc2_:Array = FriendManager.getInstance().friendListByArray;
         _loc1_ = 0;
         while(_loc1_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc1_];
            if(_loc3_.isOnline && _loc3_.grades >= 80)
            {
               allOnline.push(_loc3_);
            }
            _loc1_++;
         }
         _pageNumMax = int(Math.ceil(allOnline.length / _pageCount)) <= 0 ? 1 : int(Math.ceil(allOnline.length / _pageCount));
         currentPageNum = 1;
      }
      
      private function initListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:NavigationInviteItem = null;
         _itemList = new Vector.<NavigationInviteItem>();
         _loc2_ = 0;
         while(_loc2_ < _pageCount)
         {
            _loc1_ = new NavigationInviteItem();
            _vbox.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _lastPageBtn.addEventListener("click",__onLastPageHandler);
         _nextPageBtn.addEventListener("click",__onNextPageHandler);
         _inviteBtn.addEventListener("click",__inviteClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_lastPageBtn)
         {
            _lastPageBtn.removeEventListener("click",__onLastPageHandler);
         }
         if(_nextPageBtn)
         {
            _nextPageBtn.removeEventListener("click",__onNextPageHandler);
         }
         if(_inviteBtn)
         {
            _inviteBtn.removeEventListener("click",__inviteClickHandler);
         }
      }
      
      private function __inviteClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         SoundManager.instance.play("022");
         var _loc4_:Boolean = false;
         _loc3_ = 0;
         while(_loc3_ < _pageCount)
         {
            if(_itemList[_loc3_].data != null && _itemList[_loc3_].selected)
            {
               userList.push(ThaneInfo(_itemList[_loc3_].data).userId);
               _itemList[_loc3_].invide();
            }
            _loc3_++;
         }
         if(_itemList[0].data != null)
         {
            _loc4_ = true;
         }
         if(userList.length == 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("farm.invideFarme.noonlineFirend");
            if(_loc4_)
            {
               _loc2_ = LanguageMgr.GetTranslation("farm.invideFarme.noonSelectedFirend");
            }
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(model.hasInviteNum >= _maxInviteCount)
         {
            _loc2_ = LanguageMgr.GetTranslation("NavigationInviteFrame.invite.isFullAlert");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         NavigationManager.instance.sendNavigationOperate(4,_boatInfo.boatId,"",0,0,userList);
         dispose();
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:NavigationInviteItem = null;
         var _loc4_:int = _maxInviteCount - model.hasInviteNum;
         var _loc3_:int = _maxHelpCount - model.hasAssistNum;
         _inviteText.text = LanguageMgr.GetTranslation("NavigationInviteFrame.inviteText.text",_loc4_,_maxInviteCount);
         _helpText.text = LanguageMgr.GetTranslation("NavigationInviteFrame.helpText.text",_loc3_,_maxHelpCount);
         _loc2_ = 0;
         while(_loc2_ < _pageCount)
         {
            _loc1_ = _itemList[_loc2_];
            if(!_loc1_)
            {
               _loc1_ = new NavigationInviteItem();
               _itemList[_loc2_] = _loc1_;
            }
            if(_loc2_ >= allOnline.length)
            {
               _loc1_.data = null;
               _loc1_.visible = false;
            }
            else
            {
               _loc1_.data = _loc2_ < currentList.length ? currentList[_loc2_] : null;
               _loc1_.selected = false;
            }
            _loc2_++;
         }
      }
      
      private function __onLastPageHandler(param1:MouseEvent) : void
      {
         currentPageNum = currentPageNum - 1;
         refreshView();
      }
      
      private function __onNextPageHandler(param1:MouseEvent) : void
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
         if(_lastPageBtn)
         {
            _lastPageBtn.enable = currentPageNum > 1;
         }
         if(_nextPageBtn)
         {
            _nextPageBtn.enable = currentPageNum < _pageNumMax;
         }
         if(_pageTxt)
         {
            _pageTxt.text = StringHelper.format(_formatStr,_currentPageNum,_pageNumMax);
         }
      }
      
      private function get currentList() : Array
      {
         var _loc2_:* = null;
         var _loc1_:int = (currentPageNum - 1) * _pageCount;
         var _loc3_:int = Math.min(_loc1_ + _pageCount,allOnline.length);
         return allOnline.slice(_loc1_,_loc3_);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show(param1:NavigationBoatInfo = null) : void
      {
         _boatInfo = param1;
         titleText = LanguageMgr.GetTranslation("navigation.NavigationInviteFrame.titleText");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get model() : NavigationModel
      {
         return NavigationManager.instance.model;
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_inviteText);
         _inviteText = null;
         ObjectUtils.disposeObject(_helpText);
         _helpText = null;
         ObjectUtils.disposeObject(_alertImage);
         _alertImage = null;
         ObjectUtils.disposeObject(_inviteBtn);
         _inviteBtn = null;
         ObjectUtils.disposeObject(_lastPageBtn);
         _lastPageBtn = null;
         ObjectUtils.disposeObject(_nextPageBtn);
         _nextPageBtn = null;
         ObjectUtils.disposeObject(_pageBg);
         _pageBg = null;
         ObjectUtils.disposeObject(_pageTxt);
         _pageTxt = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         if(_itemList)
         {
            for(var _loc1_:String in _itemList)
            {
               ObjectUtils.disposeObject(_itemList[_loc1_]);
               _itemList[_loc1_] = null;
            }
            _itemList = null;
         }
         super.dispose();
      }
   }
}

