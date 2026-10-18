package theseus.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import managers.TheseussoulManager;
   import mvc.module.theseus.WarFrameItemInfo;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BaseWarItem;
   
   public class TheseusBagView extends Sprite
   {
      
      protected var _listPanel:SimpleTileList;
      
      protected var _itemList:Vector.<BaseWarItem>;
      
      protected var _itemDic:SimpleDictionary;
      
      protected var _data:SimpleDictionary;
      
      protected var _curPage:int = 1;
      
      protected var _pageCount:int = 1;
      
      protected var _column:int;
      
      protected var _itemCount:int;
      
      protected var bagType:int = 0;
      
      public function TheseusBagView(param1:int = 7, param2:int = 7, param3:int = 1)
      {
         super();
         _pageCount = param3;
         _column = param1;
         init(param1,param2);
         updateView();
      }
      
      protected function init(param1:int, param2:int) : void
      {
         var _loc4_:* = 0;
         var _loc3_:BaseWarItem = null;
         _listPanel = ComponentFactory.Instance.creatCustomObject(listStylename,[param1]);
         _itemCount = param1 * param2;
         _itemList = new Vector.<BaseWarItem>();
         _itemDic = new SimpleDictionary(true);
         addChild(_listPanel);
         _listPanel.beginChanges();
         _loc4_ = 0;
         while(_loc4_ < _itemCount)
         {
            _loc3_ = creatItem(false,_loc4_);
            _listPanel.addChild(_loc3_);
            _itemList.push(_loc3_);
            _loc4_++;
         }
         _listPanel.commitChanges();
      }
      
      protected function get listStylename() : String
      {
         return "ui.newTreasureBagView.SimpleTileList";
      }
      
      protected function creatItem(param1:Boolean = false, param2:int = -1) : BaseWarItem
      {
         var _loc3_:BaseWarItem = ComponentFactory.Instance.creatCustomObject(itemClassName);
         _loc3_.bagType = 0;
         _loc3_.objectId = 0;
         return _loc3_;
      }
      
      protected function get itemClassName() : String
      {
         return "theseus.BagItemView";
      }
      
      public function updateView() : void
      {
         refreshData();
         refreshView();
      }
      
      protected function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:BaseWarItem = null;
         _itemDic.clear();
         if(_curPage > _pageCount)
         {
            _curPage %= _pageCount;
         }
         if(_curPage == 0)
         {
            _curPage = 1;
         }
         clearBagItemData();
         for each(var _loc3_:WarFrameItemInfo in _data)
         {
            _loc2_ = _loc3_.pos - (_curPage - 1) * _itemCount;
            if(_loc2_ >= 0)
            {
               if(_loc2_ < _itemList.length)
               {
                  _loc1_ = _itemList[_loc2_] as BaseWarItem;
                  _loc1_.data = _loc3_;
               }
            }
         }
      }
      
      protected function clearBagItemData() : void
      {
         var _loc3_:int = 0;
         var _loc1_:BaseWarItem = null;
         var _loc4_:int = (curPage - 1) * _itemCount;
         var _loc2_:int = int(_itemList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _itemList[_loc3_] as BaseWarItem;
            _loc1_.data = null;
            _loc1_.pos = _loc3_ + _loc4_;
            _itemDic.add(_loc1_.pos + "_0_" + bagType,_loc1_);
            _loc3_++;
         }
      }
      
      public function gotoPage(param1:int) : void
      {
         if(_curPage == param1)
         {
            return;
         }
         _curPage = param1;
         refreshView();
      }
      
      public function get curPage() : int
      {
         return _curPage;
      }
      
      public function get pageCount() : int
      {
         return _pageCount;
      }
      
      public function refreshData() : void
      {
         var _loc1_:SimpleDictionary = TheseussoulManager.Instance.model.armorBagDic;
         var _loc2_:SimpleDictionary = new SimpleDictionary();
         for each(var _loc3_:WarFrameItemInfo in _loc1_)
         {
            if(!_loc3_.isEquip)
            {
               _loc2_.add(_loc3_.id,_loc3_);
            }
         }
         _data = _loc2_;
      }
      
      public function dispose() : void
      {
         if(_listPanel)
         {
            ObjectUtils.disposeObject(_listPanel);
         }
         _listPanel = null;
         for each(var _loc1_:BaseWarItem in _itemList)
         {
            _loc1_.dispose();
         }
         _itemList = null;
         _itemDic = null;
         _data = null;
      }
   }
}

