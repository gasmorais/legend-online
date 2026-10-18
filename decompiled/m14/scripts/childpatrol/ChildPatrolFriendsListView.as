package childpatrol
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ChildPatrolEvent;
   import events.FriendUpdateEvent;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.ChildPatrolManager;
   import mvc.module.childpatrol.ChildPatrolModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FriendManager;
   
   public class ChildPatrolFriendsListView extends Component
   {
      
      private var _back:Image;
      
      private var _pageBack:Bitmap;
      
      private var _titleBack:Image;
      
      private var _title:Bitmap;
      
      private var _list:Array;
      
      private var _vBox:VBox;
      
      private var _buttongroup:SelectedButtonGroup;
      
      private var _itemDic:Dictionary;
      
      private var _pageText:FilterFrameText;
      
      private var _firstBtn:BaseButton;
      
      private var _lastBtn:BaseButton;
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _currentPage:int;
      
      private var _totlePage:int;
      
      private var _currentIndex:int;
      
      private var _pageCapability:int = 11;
      
      private var _itemList:Array;
      
      private var _currentViewLength:int;
      
      private var _currentSelected:ChildPatrolFriendItem;
      
      private var _currentSelectedIndex:int;
      
      private var _showState:Boolean = false;
      
      public function ChildPatrolFriendsListView()
      {
         super();
         initView();
         initFriendList();
         initEvent();
         defaultView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolFriendsListView.FriendListBack");
         _titleBack = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolFriendsListView.FriendListBackAsset");
         _title = ComponentFactory.Instance.creatBitmap("asset.ChildPatrol.FriendListTitleAsset");
         _pageBack = ComponentFactory.Instance.creatBitmap("asset.core.PageNumBack2");
         _pageText = ComponentFactory.Instance.creatComponentByStylename("ChildPatrol.ListPageText");
         _firstBtn = ComponentFactory.Instance.creatComponentByStylename("ChildPatrol.ListFirstBtn");
         _lastBtn = ComponentFactory.Instance.creatComponentByStylename("ChildPatrol.ListLastBtn");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("ChildPatrol.ListPreBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("ChildPatrol.ListNextBtn");
         addChild(_back);
         addChild(_titleBack);
         addChild(_title);
         addChild(_pageBack);
         _pageBack.x = 110;
         addChild(_pageText);
         addChild(_firstBtn);
         addChild(_lastBtn);
         addChild(_preBtn);
         addChild(_nextBtn);
         _itemList = [];
         _firstBtn.tipData = LanguageMgr.GetTranslation("public.firstPage");
         _lastBtn.tipData = LanguageMgr.GetTranslation("public.lastPage");
         _preBtn.tipData = LanguageMgr.GetTranslation("public.prePage");
         _nextBtn.tipData = LanguageMgr.GetTranslation("public.nextPage");
      }
      
      private function initFriendList() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ChildPatrolFriendItem = null;
         _buttongroup = new SelectedButtonGroup();
         _vBox = ComponentFactory.Instance.creatComponentByStylename("ChildPatrol.ListBox");
         addChild(_vBox);
         _loc2_ = 0;
         while(_loc2_ < _pageCapability)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("ChildPatrol.FriendItem");
            _loc1_.data = null;
            _vBox.addChild(_loc1_);
            _itemList.push(_loc1_);
            _buttongroup.addSelectItem(_loc1_);
            _loc2_++;
         }
         _buttongroup.selectIndex = -1;
      }
      
      private function defaultView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ChildPatrolFriendItem = null;
         _currentPage = 1;
         _loc2_ = 0;
         while(_loc2_ < _pageCapability)
         {
            _loc1_ = _itemList[_loc2_] as ChildPatrolFriendItem;
            _loc1_.selected = false;
            _loc2_++;
         }
         _currentSelectedIndex = -1;
         refreshView();
         this.visible = false;
      }
      
      private function getIndexByMasterId(param1:int) : int
      {
         var _loc4_:int = 0;
         var _loc5_:Array = FriendManager.getInstance().friendListByArray;
         _loc5_ = filterByTree(_loc5_);
         var _loc2_:int = int(_loc5_.length);
         var _loc3_:* = -1;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            if((_loc5_[_loc4_] as ThaneInfo).userId == param1)
            {
               _loc3_ = _loc4_;
               break;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      private function clean() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ChildPatrolFriendItem = null;
         _loc2_ = 0;
         while(_loc2_ < _pageCapability)
         {
            _loc1_ = _vBox.getChildAt(_loc2_) as ChildPatrolFriendItem;
            _loc1_.data = null;
            _loc2_++;
         }
      }
      
      private function filterByTree(param1:Array) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:ThaneInfo in param1)
         {
            if(_loc3_.grades >= 70)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      private function refreshView() : void
      {
         var _loc6_:int = 0;
         var _loc2_:ChildPatrolFriendItem = null;
         clean();
         _list = FriendManager.getInstance().friendListByArray;
         _list = filterByTree(_list);
         _currentIndex = (_currentPage - 1) * _pageCapability;
         _totlePage = (_list.length + (_pageCapability - 1)) / _pageCapability || 1;
         refreshPage();
         setPageBtnEnable();
         var _loc5_:int = (_currentPage - 1) * _pageCapability;
         var _loc3_:int = _list.length - _loc5_;
         var _loc4_:int = _loc3_ - _pageCapability > 0 ? _pageCapability : _loc3_;
         var _loc1_:Array = [];
         _currentViewLength = 0;
         _itemDic = new Dictionary();
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc2_ = _vBox.getChildAt(_currentViewLength) as ChildPatrolFriendItem;
            _loc2_.data = _list[_currentIndex + _loc6_] as ThaneInfo;
            _itemDic[_loc2_.data] = _loc2_;
            _loc1_.push(_loc2_.data.userId);
            _currentViewLength = _currentViewLength + 1;
            _loc6_++;
         }
         ChildPatrolManager.instance.reqFriendFarmState(_loc1_);
      }
      
      private function refreshPage() : void
      {
         if(_totlePage == 0)
         {
            _pageText.text = "0/" + _totlePage;
         }
         else
         {
            _pageText.text = _currentPage + "/" + _totlePage;
         }
      }
      
      private function setPageBtnEnable() : void
      {
         _firstBtn.enable = _preBtn.enable = _currentPage > 1;
         _lastBtn.enable = _nextBtn.enable = _currentPage < _totlePage;
      }
      
      private function initEvent() : void
      {
         _firstBtn.addEventListener("click",__firstClickHandler);
         _lastBtn.addEventListener("click",__lastClickHandler);
         _preBtn.addEventListener("click",__preSelectedHandler);
         _nextBtn.addEventListener("click",__nextSelectedHandler);
         _buttongroup.addEventListener("change",__itemSelectedHandler);
         FriendManager.getInstance().addEventListener("FRIEND_UPDATE",__friendUpdateHandler);
         ChildPatrolManager.instance.addEventListener("UPDATE_FRIENDS_STATE_CHILDPATROL",__updateFriendStateList);
      }
      
      private function removeEvent() : void
      {
         _firstBtn.removeEventListener("click",__firstClickHandler);
         _lastBtn.removeEventListener("click",__lastClickHandler);
         _preBtn.removeEventListener("click",__preSelectedHandler);
         _nextBtn.removeEventListener("click",__nextSelectedHandler);
         _buttongroup.removeEventListener("change",__itemSelectedHandler);
         FriendManager.getInstance().removeEventListener("FRIEND_UPDATE",__friendUpdateHandler);
         ChildPatrolManager.instance.removeEventListener("UPDATE_FRIENDS_STATE_CHILDPATROL",__updateFriendStateList);
      }
      
      private function __updateFriendStateList(param1:ChildPatrolEvent) : void
      {
         var _loc6_:int = 0;
         var _loc2_:ChildPatrolFriendItem = null;
         var _loc7_:Array = FriendManager.getInstance().friendListByArray;
         _loc7_ = filterByTree(_loc7_);
         var _loc8_:int = (_currentPage - 1) * _pageCapability;
         var _loc5_:int = (_currentPage - 1) * _pageCapability;
         var _loc3_:int = _loc7_.length - _loc5_;
         var _loc4_:int = _loc3_ - _pageCapability > 0 ? _pageCapability : _loc3_;
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc2_ = _vBox.getChildAt(_loc6_) as ChildPatrolFriendItem;
            _loc2_.data = _loc7_[_loc8_ + _loc6_] as ThaneInfo;
            _loc6_++;
         }
      }
      
      private function __friendUpdateHandler(param1:FriendUpdateEvent) : void
      {
         refreshView();
      }
      
      private function __firstClickHandler(param1:MouseEvent) : void
      {
         if(_totlePage == 1)
         {
            return;
         }
         SoundManager.instance.play("022");
         _currentPage = 1;
         resetSelectView();
      }
      
      private function __lastClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_totlePage == 1)
         {
            return;
         }
         _currentPage = _totlePage;
         resetSelectView();
      }
      
      private function __preSelectedHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         _currentPage = _currentPage - 1;
         if(_currentPage < 1)
         {
            _currentPage = 1;
            return;
         }
         resetSelectView();
      }
      
      private function __nextSelectedHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         _currentPage = _currentPage + 1;
         if(_currentPage > _totlePage)
         {
            _currentPage = _totlePage;
            return;
         }
         resetSelectView();
      }
      
      public function resetSelectView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:ChildPatrolFriendItem = null;
         refreshView();
         _buttongroup.selectIndex = -1;
         _loc1_ = 0;
         while(_loc1_ < _pageCapability)
         {
            _loc2_ = _itemList[_loc1_] as ChildPatrolFriendItem;
            _loc2_.selected = false;
            _loc1_++;
         }
      }
      
      private function __itemSelectedHandler(param1:Event) : void
      {
         _currentSelectedIndex = _buttongroup.selectIndex;
         _currentSelected = _buttongroup.getSelectedItem() as ChildPatrolFriendItem;
         if(!_currentSelected)
         {
            return;
         }
         if(model.curUserId == thane.userId)
         {
            model.setSelfDic();
         }
         ChildPatrolManager.instance.sendChildPatrolOperate(1,_currentSelected.data.userId);
      }
      
      private function set selectedItem(param1:int) : void
      {
         var _loc2_:ChildPatrolFriendItem = _vBox.getChildAt(param1) as ChildPatrolFriendItem;
         if(_loc2_.visible)
         {
            _loc2_.dispatchEvent(new MouseEvent("click"));
         }
      }
      
      public function set showState(param1:Boolean) : void
      {
         if(_showState == param1)
         {
            return;
         }
         _showState = param1;
         if(_showState)
         {
            this.visible = true;
            doShow();
         }
         else
         {
            doHide();
         }
      }
      
      public function get showState() : Boolean
      {
         return _showState;
      }
      
      private function doShow() : void
      {
         TweenMax.killTweensOf(this);
         TweenMax.to(this,0.5,{"x":615});
      }
      
      private function doHide() : void
      {
         TweenMax.killTweensOf(this);
         TweenMax.to(this,0.5,{
            "x":815,
            "onComplete":__onMoveComplete
         });
      }
      
      private function __onMoveComplete() : void
      {
         this.visible = false;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get model() : ChildPatrolModel
      {
         return ChildPatrolManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         TweenMax.killTweensOf(this);
         if(_pageBack)
         {
            ObjectUtils.disposeObject(_pageBack);
         }
         _pageBack = null;
         if(_titleBack)
         {
            ObjectUtils.disposeObject(_titleBack);
         }
         _titleBack = null;
         if(_vBox)
         {
            ObjectUtils.disposeObject(_vBox);
         }
         _vBox = null;
         if(_pageText)
         {
            ObjectUtils.disposeObject(_pageText);
         }
         _pageText = null;
         if(_firstBtn)
         {
            ObjectUtils.disposeObject(_firstBtn);
         }
         _firstBtn = null;
         if(_lastBtn)
         {
            ObjectUtils.disposeObject(_lastBtn);
         }
         _lastBtn = null;
         if(_preBtn)
         {
            ObjectUtils.disposeObject(_preBtn);
         }
         _preBtn = null;
         if(_nextBtn)
         {
            ObjectUtils.disposeObject(_nextBtn);
         }
         _nextBtn = null;
         if(_currentSelected)
         {
            _currentSelected.dispose();
         }
         _currentSelected = null;
         _buttongroup = null;
         _itemDic = null;
         _list = null;
         _itemList = null;
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

