package ui.resourcebar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mvc.module.pet.PetData;
   import yishi.manager.PlayerManager;
   
   public class PetSortList extends Sprite implements Disposeable
   {
      
      private var _bg:DisplayObject;
      
      private var _itemList:Vector.<PetSortItem>;
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _pageSize:int = 6;
      
      private var _pageNumMax:int = 1;
      
      private var _currentPageNum:int;
      
      private var _totalList:Array;
      
      private var _vBox:VBox;
      
      private var _flag:int;
      
      private var _useType:int;
      
      public var itemSelectHandler:Function;
      
      public function PetSortList(param1:int, param2:int = -1)
      {
         super();
         _flag = param1;
         _useType = param2;
         _totalList = petDataList();
         _pageNumMax = Math.ceil(_totalList.length / _pageSize);
         initView();
         initEvents();
         currentPageNum = 1;
         refresh();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("core.commonTipBg");
         _bg.width = 160;
         _bg.height = 240;
         addChild(_bg);
         _vBox = ComponentFactory.Instance.creatComponentByStylename("resourcesBar.PetVBox");
         _itemList = new Vector.<PetSortItem>();
         addChild(_vBox);
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("resourcesBar.PetSortList.PrePageBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("resourcesBar.PetSortList.NextPageBtn");
         addChild(_preBtn);
         addChild(_nextBtn);
      }
      
      private function initEvents() : void
      {
         _preBtn.addEventListener("click",__preBtnClickHandler);
         _nextBtn.addEventListener("click",__nextBtnClickHandler);
      }
      
      private function removeEvents() : void
      {
         if(_preBtn)
         {
            _preBtn.removeEventListener("click",__preBtnClickHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.removeEventListener("click",__nextBtnClickHandler);
         }
      }
      
      private function __preBtnClickHandler(param1:MouseEvent) : void
      {
         currentPageNum = currentPageNum - 1;
         refresh();
      }
      
      private function __nextBtnClickHandler(param1:MouseEvent) : void
      {
         currentPageNum = currentPageNum + 1;
         refresh();
      }
      
      public function refresh() : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:PetSortItem = null;
         _vBox.removeAllChild();
         while(_itemList.length)
         {
            ObjectUtils.disposeObject(_itemList.pop());
         }
         var _loc2_:int = Math.min(_totalList.length - _pageSize * (_currentPageNum - 1),_pageSize);
         _loc3_ = 0;
         while(_loc3_ < _pageSize)
         {
            _loc4_ = (_currentPageNum - 1) * _pageSize + _loc3_;
            if(_totalList && _loc4_ < _totalList.length)
            {
               _loc1_ = new PetSortItem(_flag);
               _loc1_.data = _totalList[_loc4_];
               _itemList.push(_loc1_);
               _vBox.addChild(_loc1_);
               if(_useType == 1)
               {
                  _loc1_.itemClickHandler = itemClickHandler;
               }
            }
            _loc3_++;
         }
      }
      
      private function itemClickHandler(param1:int) : void
      {
         if(itemSelectHandler != null)
         {
            itemSelectHandler(param1);
         }
      }
      
      public function petDataList() : Array
      {
         var _loc4_:int = 0;
         var _loc2_:PetData = null;
         var _loc1_:Array = [];
         var _loc3_:Array = PlayerManager.instance.currentPlayerModel.playerInfo.petList;
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc2_ = _loc3_[_loc4_];
            if(_flag == 1 && !_loc2_.isEnterWar)
            {
               _loc1_.push(_loc2_);
            }
            else if(_flag == 2 && _loc2_.isChildWar != 1)
            {
               _loc1_.push(_loc2_);
            }
            else if(_flag == 3 && !_loc2_.isChildWar != 2)
            {
               _loc1_.push(_loc2_);
            }
            else if(_flag == 4 && _loc2_.template.PetType == _useType)
            {
               _loc1_.push(_loc2_);
            }
            else if(_flag == 5 && !_loc2_.isEnterWar)
            {
               _loc1_.push(_loc2_);
            }
            _loc4_++;
         }
         return _loc1_;
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
      }
      
      public function dispose() : void
      {
         removeEvents();
         itemSelectHandler = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_preBtn);
         _preBtn = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         if(_itemList)
         {
            while(_itemList.length)
            {
               ObjectUtils.disposeObject(_itemList.pop());
            }
         }
         _itemList = null;
         _totalList = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
         dispatchEvent(new Event("dispose"));
      }
   }
}

