package water.view
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.FriendUpdateEvent;
   import farm.FarmManager;
   import farm.FarmModel;
   import farm.data.FriendFarmStateInfo;
   import farm.event.FarmEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import home.HomeSender;
   import manager.LanguageMgr;
   import managers.HomeManager;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FriendManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   
   public class FarmFriendListView extends Sprite implements Disposeable
   {
      
      private var _titleBack:Bitmap;
      
      private var _back:Bitmap;
      
      private var _pageBack:Bitmap;
      
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
      
      private var _currentSelected:FarmFriendItem;
      
      private var _currentSelectedIndex:int;
      
      private var _type:int;
      
      public function FarmFriendListView()
      {
         super();
         _itemList = [];
         init();
         initFriendList();
         initEvent();
         defaultView();
      }
      
      private function get model() : FarmModel
      {
         return FarmManager.instance.model;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function init() : void
      {
         _titleBack = ComponentFactory.Instance.creatBitmap("asset.farm.FarmFriendListView.titleback");
         _back = ComponentFactory.Instance.creatBitmap("asset.farm.FarmFriendListView.back");
         _pageBack = ComponentFactory.Instance.creatBitmap("asset.core.PageNumBack2");
         addChild(_back);
         addChild(_titleBack);
         addChild(_pageBack);
         _pageText = ComponentFactory.Instance.creatComponentByStylename("water.ListPageText");
         addChild(_pageText);
         _firstBtn = ComponentFactory.Instance.creatComponentByStylename("water.ListFirstBtn");
         _lastBtn = ComponentFactory.Instance.creatComponentByStylename("water.ListLastBtn");
         addChild(_firstBtn);
         _firstBtn.tipData = LanguageMgr.GetTranslation("public.firstPage");
         addChild(_lastBtn);
         _lastBtn.tipData = LanguageMgr.GetTranslation("public.lastPage");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("water.ListPreBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("water.ListNextBtn");
         addChild(_preBtn);
         _preBtn.tipData = LanguageMgr.GetTranslation("public.prePage");
         addChild(_nextBtn);
         _nextBtn.tipData = LanguageMgr.GetTranslation("public.nextPage");
      }
      
      private function initFriendList() : void
      {
         var _loc2_:int = 0;
         var _loc1_:FarmFriendItem = null;
         _buttongroup = new SelectedButtonGroup();
         _vBox = ComponentFactory.Instance.creatComponentByStylename("water.ListBox");
         addChild(_vBox);
         _loc2_ = 0;
         while(_loc2_ < _pageCapability)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("water.FarmFriendItem");
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
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:FarmFriendItem = null;
         if(PlayerManager.instance.currentPlayerModel.userInfo.userId == model.masterId)
         {
            _currentPage = 1;
         }
         else
         {
            _loc2_ = getIndexByMasterId(model.masterId);
            _loc4_ = (_loc2_ + 1) % _pageCapability == 0 ? (_loc2_ + 1) / _pageCapability : (_loc2_ + 1) / _pageCapability + 1;
            _currentPage = _loc4_ = Math.max(1,_loc4_);
            _loc3_ = 0;
            while(_loc3_ < _pageCapability)
            {
               _loc1_ = _itemList[_loc3_] as FarmFriendItem;
               if(_loc3_ == _loc2_ % _pageCapability)
               {
                  _buttongroup.lastSelectedButton = _vBox.getChildAt(_loc3_) as ISelectable;
                  _loc1_.selected = true;
               }
               else
               {
                  _loc1_.selected = false;
               }
               _loc3_++;
            }
         }
         _currentSelectedIndex = -1;
         refreshView();
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
         var _loc1_:FarmFriendItem = null;
         _loc2_ = 0;
         while(_loc2_ < _pageCapability)
         {
            _loc1_ = _vBox.getChildAt(_loc2_) as FarmFriendItem;
            _loc1_.data = null;
            _loc2_++;
         }
      }
      
      private function filterByTree(param1:Array) : Array
      {
         var _loc4_:* = null;
         var _loc2_:Array = [];
         for each(var _loc3_:ThaneInfo in param1)
         {
            if(_loc3_.grades >= 12 && getFlag(_loc3_.userId))
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      private function getFlag(param1:int) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:FriendFarmStateInfo = FarmManager.instance.model.getFarmStateInfo(param1);
         if(_loc3_ && _loc3_.isShow)
         {
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      private function refreshView() : void
      {
         var _loc6_:int = 0;
         var _loc2_:FarmFriendItem = null;
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
            _loc2_ = _vBox.getChildAt(_currentViewLength) as FarmFriendItem;
            _loc2_.data = _list[_currentIndex + _loc6_] as ThaneInfo;
            _itemDic[_loc2_.data] = _loc2_;
            _loc1_.push(_loc2_.data.userId);
            _currentViewLength = _currentViewLength + 1;
            if(FarmManager.instance.model.curSelectedUserInfo == null && _loc2_.selected == true)
            {
            }
            if(FarmManager.instance.model.masterId != FarmManager.instance.model.thane.userId)
            {
               FarmManager.instance.model.curSelectedUserInfo = FriendManager.getInstance().friendListByArray[getIndexByMasterId(FarmManager.instance.model.masterId)];
            }
            _loc6_++;
         }
         FarmManager.instance.reqFriendFarmState(_loc1_);
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
         model.addEventListener("SELECTED_CHANGE",__selectedUserChangeHandler);
         FriendManager.getInstance().addEventListener("FRIEND_UPDATE",__friendUpdateHandler);
         NotificationManager.instance.addEventListener("PRE_SELECTED",__preSelectedHandler);
         NotificationManager.instance.addEventListener("NEXT_SELECTED",__nextSelectedHandler);
         PlayerManager.instance.currentPlayerModel.addEventListener("SYSTIME_UPGRADE_SECOND",__timeUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         _firstBtn.removeEventListener("click",__firstClickHandler);
         _lastBtn.removeEventListener("click",__lastClickHandler);
         _preBtn.removeEventListener("click",__preSelectedHandler);
         _nextBtn.removeEventListener("click",__nextSelectedHandler);
         _buttongroup.removeEventListener("change",__itemSelectedHandler);
         model.removeEventListener("SELECTED_CHANGE",__selectedUserChangeHandler);
         FriendManager.getInstance().removeEventListener("FRIEND_UPDATE",__friendUpdateHandler);
         NotificationManager.instance.removeEventListener("PRE_SELECTED",__preSelectedHandler);
         NotificationManager.instance.removeEventListener("NEXT_SELECTED",__nextSelectedHandler);
         PlayerManager.instance.currentPlayerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__timeUpdateHandler);
      }
      
      private function __timeUpdateHandler(param1:PlayerEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:FarmFriendItem = null;
         if(_itemList == null)
         {
            return;
         }
         _loc3_ = 0;
         while(_loc3_ < _itemList.length)
         {
            _loc2_ = _itemList[_loc3_];
            if(_loc2_ != null)
            {
               _loc2_.refreshView();
            }
            _loc3_++;
         }
      }
      
      private function __firstClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:FarmFriendItem = null;
         if(_totlePage == 1)
         {
            return;
         }
         SoundManager.instance.play("022");
         _currentPage = 1;
         refreshView();
         _buttongroup.selectIndex = -1;
         _loc2_ = 0;
         while(_loc2_ < _pageCapability)
         {
            _loc3_ = _itemList[_loc2_] as FarmFriendItem;
            _loc3_.selected = false;
            _loc2_++;
         }
      }
      
      private function __lastClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:FarmFriendItem = null;
         SoundManager.instance.play("022");
         if(_totlePage == 1)
         {
            return;
         }
         _currentPage = _totlePage;
         refreshView();
         _buttongroup.selectIndex = -1;
         _loc2_ = 0;
         while(_loc2_ < _pageCapability)
         {
            _loc3_ = _itemList[_loc2_] as FarmFriendItem;
            _loc3_.selected = false;
            _loc2_++;
         }
      }
      
      private function __preSelectedHandler(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:FarmFriendItem = null;
         SoundManager.instance.play("022");
         _currentPage = _currentPage - 1;
         if(_currentPage < 1)
         {
            _currentPage = 1;
            return;
         }
         refreshView();
         _buttongroup.selectIndex = -1;
         _loc2_ = 0;
         while(_loc2_ < _pageCapability)
         {
            _loc3_ = _itemList[_loc2_] as FarmFriendItem;
            _loc3_.selected = false;
            _loc2_++;
         }
      }
      
      private function __nextSelectedHandler(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:FarmFriendItem = null;
         SoundManager.instance.play("022");
         _currentPage = _currentPage + 1;
         if(_currentPage > _totlePage)
         {
            _currentPage = _totlePage;
            return;
         }
         refreshView();
         _buttongroup.selectIndex = -1;
         _loc2_ = 0;
         while(_loc2_ < _pageCapability)
         {
            _loc3_ = _itemList[_loc2_] as FarmFriendItem;
            _loc3_.selected = false;
            _loc2_++;
         }
      }
      
      private function __friendUpdateHandler(param1:FriendUpdateEvent) : void
      {
         var _loc2_:ThaneInfo = null;
         if(_currentSelected)
         {
            _loc2_ = _currentSelected.data;
            refreshView();
            if(_loc2_ && _itemDic[_loc2_])
            {
               _itemDic[_loc2_].dispatchEvent(new MouseEvent("click"));
            }
            else
            {
               model.curSelectedUserInfo = thane;
            }
         }
         else
         {
            refreshView();
         }
      }
      
      private function __itemSelectedHandler(param1:Event) : void
      {
         _currentSelectedIndex = _buttongroup.selectIndex;
         _currentSelected = _buttongroup.getSelectedItem() as FarmFriendItem;
         if(!_currentSelected)
         {
            return;
         }
         model.curSelectedUserInfo = _currentSelected.data;
         FarmManager.instance.model.defaultSelectedUserInfo();
         if(model.curSelectedUserInfo.userId != HomeManager.instance.model.masterId && type == 1)
         {
            HomeSender.enterHouse(_currentSelected.data.userId);
         }
      }
      
      private function __selectedUserChangeHandler(param1:FarmEvent) : void
      {
         if(param1.dataII && (param1.dataII as ThaneInfo).userId == thane.userId)
         {
            _buttongroup.selectIndex = -1;
         }
      }
      
      private function set selectedItem(param1:int) : void
      {
         var _loc2_:FarmFriendItem = _vBox.getChildAt(param1) as FarmFriendItem;
         if(_loc2_.visible)
         {
            _loc2_.dispatchEvent(new MouseEvent("click"));
         }
      }
      
      public function setBack() : void
      {
         if(type == 1)
         {
            _back.visible = false;
         }
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:FarmFriendItem = null;
         _type = param1;
         _loc3_ = 0;
         while(_loc3_ < _itemList.length)
         {
            _loc2_ = _itemList[_loc3_];
            if(_loc2_ != null)
            {
               _loc2_.viewType = _type;
            }
            _loc3_++;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_titleBack)
         {
            ObjectUtils.disposeObject(_titleBack);
         }
         _titleBack = null;
         if(_back)
         {
            ObjectUtils.disposeObject(_back);
         }
         _back = null;
         if(_pageBack)
         {
            ObjectUtils.disposeObject(_pageBack);
         }
         _pageBack = null;
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
         _itemList = null;
         TweenMax.killTweensOf(this);
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         if(_currentSelected)
         {
            _currentSelected.dispose();
         }
         _currentSelected = null;
         _buttongroup = null;
         _itemDic = null;
      }
   }
}

