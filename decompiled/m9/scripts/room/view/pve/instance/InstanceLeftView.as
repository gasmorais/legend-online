package room.view.pve.instance
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.InstanceEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import mvc.module.selectcampaign.CampaignAreaInfo;
   import mvc.module.selectcampaign.CampaignChapterInfo;
   import mvc.module.selectcampaign.CampaignLandInfo;
   import yishi.datas.VersionSwitch;
   import yishi.datas.VersionSwitchInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.manager.ArmyManager;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseItemView;
   
   public class InstanceLeftView extends Sprite implements Disposeable
   {
      
      private var _back:Scale9CornerImage;
      
      private var _bg:Bitmap;
      
      private var _tabOneBtn:SelectedButton;
      
      private var _tabTwoBtn:SelectedButton;
      
      private var _tabThreeBtn:SelectedButton;
      
      private var _tabCloseImg:MutipleImage;
      
      private var _group:SelectedButtonGroup;
      
      private var _pointList:Vector.<Point>;
      
      private var _hBox:HBox;
      
      private var _itemList:Vector.<InstanceItem>;
      
      private var _fallGoodsItem:Vector.<BaseItemView>;
      
      private var _currentItem:InstanceItem;
      
      private var _district:int = -1;
      
      private var _landInfo:CampaignLandInfo;
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _pageTxt:FilterFrameText;
      
      private var _pageBg:Image;
      
      private var _pageSize:int = 5;
      
      private var _currentPageNum:int;
      
      private var _pageNumMax:int = 2;
      
      private var _formatStr:String = "{0} / {1}";
      
      private var cardInfo1:Array;
      
      private var cardInfo2:Array;
      
      private var cardInfo3:Array;
      
      private var cardInfo4:Array;
      
      private var mutiInfo:Array;
      
      private var activeInfo:Array;
      
      private var weeklyInfo:Array;
      
      private var currentInfo:Array;
      
      private var itemContiner:Component;
      
      private var cardIdArr1:Array = [101,102,103,104];
      
      private var cardIdArr2:Array = [105,106,107,108,109];
      
      private var cardIdArr3:Array = [110,111,112,113,114];
      
      private var cardIdArr4:Array = [115,116,117];
      
      public function InstanceLeftView()
      {
         super();
         initView();
         initEvents();
         currentPageNum = 1;
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("room.InstanceSelectBack");
         _bg = ComponentFactory.Instance.creatBitmap("asset.room.InstanceLeftBG");
         _tabOneBtn = ComponentFactory.Instance.creatComponentByStylename("room.LeftInstance.TabOneBtn");
         _tabTwoBtn = ComponentFactory.Instance.creatComponentByStylename("room.LeftInstance.TabTwoBtn");
         _tabThreeBtn = ComponentFactory.Instance.creatComponentByStylename("room.LeftInstance.TabThreeBtn");
         _tabCloseImg = ComponentFactory.Instance.creatComponentByStylename("room.leftTabCloseBtn.unSelect");
         _group = new SelectedButtonGroup();
         _hBox = ComponentFactory.Instance.creatComponentByStylename("room.InstanceGoodsBox");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("room.PrePageBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("room.NextPageBtn");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("room.PageBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("room.PageText");
         itemContiner = new Component();
         addChild(_back);
         addChild(_bg);
         addChild(_tabOneBtn);
         addChild(_tabTwoBtn);
         addChild(_tabThreeBtn);
         addChild(_hBox);
         _group.addSelectItem(_tabOneBtn);
         _group.addSelectItem(_tabTwoBtn);
         _group.addSelectItem(_tabThreeBtn);
         _itemList = new Vector.<InstanceItem>();
         getPointList();
         _fallGoodsItem = new Vector.<BaseItemView>();
         addChild(itemContiner);
         addChild(_pageBg);
         addChild(_preBtn);
         addChild(_nextBtn);
         addChild(_pageTxt);
      }
      
      private function initEvents() : void
      {
         _group.addEventListener("change",__selectTabHandler);
         _preBtn.addEventListener("click",__preBtnClickHandler);
         _nextBtn.addEventListener("click",__nextBtnClickHandler);
      }
      
      private function removeEvents() : void
      {
         _group.removeEventListener("change",__selectTabHandler);
         _preBtn.removeEventListener("click",__preBtnClickHandler);
         _nextBtn.removeEventListener("click",__nextBtnClickHandler);
      }
      
      private function __preBtnClickHandler(param1:MouseEvent) : void
      {
         currentPageNum = currentPageNum - 1;
         refreshListView();
      }
      
      private function __nextBtnClickHandler(param1:MouseEvent) : void
      {
         currentPageNum = currentPageNum + 1;
         refreshListView();
      }
      
      private function refreshListView() : void
      {
         _removeItemEvents();
         if(_currentItem)
         {
            _currentItem.selected = false;
         }
         createItem();
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
         if(_preBtn)
         {
            _preBtn.enable = currentPageNum > 1;
         }
         if(_nextBtn)
         {
            _nextBtn.enable = currentPageNum < _pageNumMax;
         }
         if(_pageTxt)
         {
            _pageTxt.text = StringHelper.format(_formatStr,_currentPageNum,_pageNumMax);
         }
      }
      
      private function getPointList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Point = null;
         _pointList = new Vector.<Point>();
         _loc1_ = 1;
         while(_loc1_ <= 9)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("room.selectInstanceItem_" + _loc1_);
            _pointList.push(_loc2_);
            _loc1_++;
         }
      }
      
      private function _appendItem(param1:int = 5) : void
      {
         var _loc3_:int = 0;
         var _loc2_:InstanceItem = null;
         _itemList = new Vector.<InstanceItem>();
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            _loc2_ = new InstanceItem();
            _itemList.push(_loc2_);
            itemContiner.addChild(_loc2_);
            if(param1 == 5)
            {
               _loc2_.x = _pointList[_loc3_].x;
               _loc2_.y = _pointList[_loc3_].y;
            }
            else
            {
               _loc2_.x = _pointList[_loc3_ + 5].x;
               _loc2_.y = _pointList[_loc3_ + 5].y;
            }
            _loc3_++;
         }
      }
      
      private function createItem() : void
      {
         var _loc4_:CampaignAreaInfo = null;
         var _loc2_:int = 0;
         if(itemContiner)
         {
            ObjectUtils.disposeAllChildren(itemContiner);
            _currentItem = null;
         }
         currentInfo = [];
         if(_district == 0)
         {
            _pageNumMax = 4;
            getCurrentInfoByCurrentPage();
         }
         else if(_district == 1)
         {
            if(!VersionSwitch.DUO_MIAO && !VersionSwitch.YUAN_SHU)
            {
               _pageNumMax = 1;
            }
            else
            {
               _pageNumMax = 2;
            }
            _appendItem();
            getCurrentActiveInfoByPage();
         }
         else if(_district == 2)
         {
            if(!VersionSwitch.DEEP_PRISON)
            {
               _pageNumMax = 1;
            }
            else
            {
               _pageNumMax = 2;
            }
            _appendItem();
            getCurrentWeekInfoByPage();
         }
         var _loc1_:int = int(_itemList.length);
         var _loc3_:int = 0;
         _loc2_ = 0;
         for(; _loc2_ < _loc1_; _loc2_++)
         {
            if(_loc2_ < currentInfo.length)
            {
               _loc4_ = currentInfo[_loc2_] as CampaignAreaInfo;
            }
            else
            {
               _loc4_ = null;
            }
            if(_tabTwoBtn.selected && _loc4_)
            {
               if(_tabTwoBtn.enable)
               {
                  if(!VersionSwitch.RANDOM_BOSS && _loc4_.areaId == 304)
                  {
                     continue;
                  }
               }
               _itemList[_loc2_].dungeonId = _district;
               _itemList[_loc3_].areaInfo = _loc4_;
               if(_loc4_)
               {
                  _itemList[_loc3_].addEventListener("instance_click",_itemClick);
               }
               _loc3_++;
            }
            else if(!(!VersionSwitchInfo.WEEK_CAMPAIGN && _loc4_ && _loc4_.areaId == 402))
            {
               if(!(!VersionSwitch.DEEP_PRISON && _loc4_ && _loc4_.areaId == 405))
               {
                  _itemList[_loc2_].dungeonId = _district;
                  _itemList[_loc2_].areaInfo = _loc4_;
                  if(_loc4_)
                  {
                     _itemList[_loc2_].addEventListener("instance_click",_itemClick);
                  }
               }
            }
         }
      }
      
      private function getCurrentActiveInfoByPage() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         currentInfo = [];
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = _loc2_ + (currentPageNum - 1) * 5;
            if(_loc1_ < activeInfo.length)
            {
               currentInfo.push(activeInfo[_loc1_]);
            }
            _loc2_++;
         }
         _appendItem(5);
      }
      
      private function getCurrentWeekInfoByPage() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         currentInfo = [];
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = _loc2_ + (currentPageNum - 1) * 5;
            if(_loc1_ < weeklyInfo.length)
            {
               currentInfo.push(weeklyInfo[_loc1_]);
            }
            _loc2_++;
         }
         _appendItem(5);
      }
      
      private function getCurrentInfoByCurrentPage() : void
      {
         var _loc1_:Array = null;
         if(thane.grades < 40)
         {
            _loc1_ = [1,2,3,4];
            currentInfo = mutiInfo[currentPageNum - 1];
            if(currentPageNum == 1)
            {
               _appendItem(4);
            }
            else
            {
               _appendItem(5);
            }
         }
         else if(thane.grades >= 40 && thane.grades < 65)
         {
            _loc1_ = [2,1,3,4];
            currentInfo = mutiInfo[_loc1_[currentPageNum - 1] - 1];
            if(currentPageNum == 2)
            {
               _appendItem(4);
            }
            else
            {
               _appendItem(5);
            }
         }
         else if(thane.grades >= 65 && !thane.isChangeJob)
         {
            _loc1_ = [3,2,1,4];
            currentInfo = mutiInfo[_loc1_[currentPageNum - 1] - 1];
            if(currentPageNum == 3)
            {
               _appendItem(4);
            }
            else
            {
               _appendItem(5);
            }
         }
         else if(thane.isChangeJob)
         {
            _loc1_ = [4,3,2,1];
            currentInfo = mutiInfo[_loc1_[currentPageNum - 1] - 1];
            if(currentPageNum == 4)
            {
               _appendItem(4);
            }
            else
            {
               _appendItem(5);
            }
         }
      }
      
      private function _itemClick(param1:Event) : void
      {
         SoundManager.instance.play("022");
         stopInstanceItem();
         if(_currentItem)
         {
            _currentItem.selected = false;
         }
         _currentItem = param1.currentTarget as InstanceItem;
         _currentItem.selected = true;
         var _loc2_:InstanceEvent = new InstanceEvent("select_instance");
         _loc2_.selectedAreaInfo = _currentItem.areaInfo;
         dispatchEvent(_loc2_);
      }
      
      private function removeInstanceItems() : void
      {
         var _loc1_:InstanceItem = null;
         while(_itemList.length > 0)
         {
            _loc1_ = _itemList.pop();
            if(_loc1_.hasEventListener("instance_click"))
            {
               _loc1_.removeEventListener("instance_click",_itemClick);
            }
            _loc1_.dispose();
            _loc1_ = null;
         }
      }
      
      private function _removeItemEvents() : void
      {
         for each(var _loc1_:InstanceItem in _itemList)
         {
            _loc1_.isOpen = false;
            if(_loc1_.hasEventListener("instance_click"))
            {
               _loc1_.removeEventListener("instance_click",_itemClick);
            }
         }
      }
      
      private function __selectTabHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         stopInstanceItem();
         district = _group.selectIndex;
         currentPageNum = 1;
         _pageBg.visible = true;
         _preBtn.visible = true;
         _nextBtn.visible = true;
         _pageTxt.visible = true;
         refreshListView();
         var _loc2_:InstanceEvent = new InstanceEvent("select_instance");
         _loc2_.selectedAreaInfo = null;
         dispatchEvent(_loc2_);
      }
      
      private function set district(param1:int) : void
      {
         if(_district == param1)
         {
            return;
         }
         _district = param1;
         if(_currentItem)
         {
            _currentItem.selected = false;
         }
         _removeItemEvents();
         setCardsInfo();
         createItem();
      }
      
      public function set landInfo(param1:CampaignLandInfo) : void
      {
         _landInfo = param1;
         _tabOneBtn.enable = param1.getChapterById(1) || param1.getChapterById(2);
         _group.selectIndex = 0;
      }
      
      private function setCardsInfo() : void
      {
         var _loc4_:int = 0;
         mutiInfo = [];
         cardInfo1 = [];
         cardInfo2 = [];
         cardInfo3 = [];
         cardInfo4 = [];
         cardInfo4 = [];
         activeInfo = [];
         weeklyInfo = [];
         var _loc3_:CampaignChapterInfo = _landInfo.getChapterById(1);
         var _loc5_:Array = _loc3_.areaDic.getList();
         _loc4_ = 0;
         while(_loc4_ < _loc5_.length)
         {
            if(checkInCardByPage(CampaignAreaInfo(_loc5_[_loc4_]),1))
            {
               cardInfo1.push(_loc5_[_loc4_]);
               cardInfo1.sortOn("areaId");
            }
            else if(checkInCardByPage(CampaignAreaInfo(_loc5_[_loc4_]),2))
            {
               cardInfo2.push(_loc5_[_loc4_]);
               cardInfo2.sortOn("areaId");
            }
            else if(checkInCardByPage(CampaignAreaInfo(_loc5_[_loc4_]),3))
            {
               cardInfo3.push(_loc5_[_loc4_]);
               cardInfo3.sortOn("areaId");
            }
            else if(checkInCardByPage(CampaignAreaInfo(_loc5_[_loc4_]),4))
            {
               cardInfo4.push(_loc5_[_loc4_]);
               cardInfo4.sortOn("areaId");
            }
            _loc4_++;
         }
         mutiInfo = [cardInfo1,cardInfo2,cardInfo3,cardInfo4];
         var _loc1_:CampaignChapterInfo = _landInfo.getChapterById(3);
         activeInfo = _loc1_.areaDic.getList();
         activeInfo.sortOn("areaId");
         var _loc2_:CampaignChapterInfo = _landInfo.getChapterById(4);
         weeklyInfo = _loc2_.areaDic.getList();
         weeklyInfo.sortOn("areaId");
      }
      
      private function checkInCardByPage(param1:CampaignAreaInfo, param2:int) : Boolean
      {
         for each(var _loc3_:CampaignTemplate in param1.getMapList())
         {
            if((this["cardIdArr" + param2] as Array).indexOf(_loc3_.AreaId) != -1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function palyInstanceItem(param1:int = -1) : void
      {
         if(param1 > _itemList.length)
         {
            return;
         }
         if(param1 < 0)
         {
            for each(var _loc2_:InstanceItem in _itemList)
            {
               _loc2_.playShine();
            }
         }
         else
         {
            _itemList[param1].playShine();
         }
      }
      
      public function stopInstanceItem(param1:int = -1) : void
      {
         if(param1 > _itemList.length)
         {
            return;
         }
         if(param1 < 0)
         {
            for each(var _loc2_:InstanceItem in _itemList)
            {
               _loc2_.stopShine(false);
            }
         }
         else
         {
            _itemList[param1].stopShine(false);
         }
      }
      
      public function getInstanceItem(param1:int) : InstanceItem
      {
         if(param1 < _itemList.length)
         {
            return _itemList[param1];
         }
         return null;
      }
      
      public function onlyOpenOneItemInNovice() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 1;
         while(_loc1_ < _itemList.length)
         {
            _itemList[_loc1_].isOpen = false;
            _loc1_++;
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function dispose() : void
      {
         removeEvents();
         removeInstanceItems();
         _pointList = null;
         _fallGoodsItem = null;
         _itemList = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_tabOneBtn)
         {
            ObjectUtils.disposeObject(_tabOneBtn);
         }
         _tabOneBtn = null;
         if(_tabTwoBtn)
         {
            ObjectUtils.disposeObject(_tabTwoBtn);
         }
         _tabTwoBtn = null;
         if(_tabThreeBtn)
         {
            ObjectUtils.disposeObject(_tabThreeBtn);
         }
         _tabThreeBtn = null;
         if(_tabCloseImg)
         {
            ObjectUtils.disposeObject(_tabCloseImg);
         }
         _tabCloseImg = null;
         if(_hBox)
         {
            ObjectUtils.disposeObject(_hBox);
         }
         _hBox = null;
         if(_group)
         {
            _group.dispose();
         }
         _group = null;
         if(_pageBg)
         {
            _pageBg.dispose();
         }
         _pageBg = null;
         if(_preBtn)
         {
            _preBtn.dispose();
         }
         _preBtn = null;
         if(_nextBtn)
         {
            _nextBtn.dispose();
         }
         _nextBtn = null;
         if(_pageTxt)
         {
            _pageTxt.dispose();
         }
         _pageTxt = null;
         _currentItem = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

