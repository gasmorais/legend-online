package theseusgodhead.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.TheseusGodheadModel;
   import mvc.module.theseus.TheseusGodheadStoneInfo;
   import theseusgodhead.UI.TheseusGodheadBagItem;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   
   public class TheseusGodheadBagView extends Sprite
   {
      
      public static const REFRESH_BAGLIST:String = "refreshbaglist";
      
      private var _panel:ScrollPanel;
      
      private var _vbox:VBox;
      
      private var _items:Vector.<TheseusGodheadBagItem>;
      
      private var _allGoods:Array;
      
      private var _curPage:int = 1;
      
      private var _pageCount:int = 6;
      
      private var _pageSize:int = 12;
      
      private var _colCount:int = 3;
      
      private var _rowCount:int = 4;
      
      private var _hGap:int = 3;
      
      private var _vGap:int = 3;
      
      private var _itemWidth:Number = 104;
      
      private var _itemHeight:Number = 104;
      
      private var _container:Sprite;
      
      private var _selected:TheseusGodheadBagItem;
      
      private var _selectedGoods:TheseusGodheadStoneInfo;
      
      private var _bagBack:Scale9CornerImage;
      
      private var _rotateBtn:TextButton;
      
      private var _isRotateMode:Boolean = false;
      
      private var _isDecomposeMode:Boolean = false;
      
      private var _rotateCursor:Bitmap;
      
      private var _lastClickedItem:TheseusGodheadBagItem;
      
      public function TheseusGodheadBagView()
      {
         super();
         initView();
         initNotification();
      }
      
      private function initNotification() : void
      {
         NotificationManager.instance.addEventListener("slateAddToDecompose",__onSlateAddToDecompose);
         NotificationManager.instance.addEventListener("slateRemoveFromDecompose",__onSlateRemoveFromDecompose);
         NotificationManager.instance.addEventListener("decomposeModeCancel",__onDecomposeModeCancel);
         NotificationManager.instance.addEventListener("refreshbaglist",refreshView);
      }
      
      private function initView() : void
      {
         _bagBack = ComponentFactory.Instance.creatComponentByStylename("TheseusEquipBagView.BagBack");
         _bagBack.x = 0;
         _bagBack.y = 0;
         _items = new Vector.<TheseusGodheadBagItem>();
         _container = new Sprite();
         addChild(_bagBack);
         addChild(_container);
         refreshView();
      }
      
      private function __rotateBtnClick(param1:MouseEvent) : void
      {
         _isRotateMode = !_isRotateMode;
         model.isRotateMode = _isRotateMode;
         if(_isRotateMode)
         {
            if(_rotateCursor == null)
            {
               _rotateCursor = ComponentFactory.Instance.creatBitmap("TheseusGodHeadbg.rotora");
            }
            if(_rotateCursor)
            {
               Mouse.hide();
               stage.addChild(_rotateCursor);
            }
            stage.addEventListener("click",__stageRotateClick,true);
            stage.addEventListener("mouseMove",__stageMouseMove);
         }
         else
         {
            stage.removeEventListener("click",__stageRotateClick,true);
            stage.removeEventListener("mouseMove",__stageMouseMove);
            if(_rotateCursor && _rotateCursor.parent)
            {
               _rotateCursor.parent.removeChild(_rotateCursor);
            }
            Mouse.show();
            dispatchEvent(new Event("rotateModeChanged"));
         }
      }
      
      private function __stageMouseMove(param1:MouseEvent) : void
      {
         if(_isRotateMode && _rotateCursor)
         {
            _rotateCursor.x = param1.stageX;
            _rotateCursor.y = param1.stageY;
         }
      }
      
      public function get model() : TheseusGodheadModel
      {
         return TheseussoulManager.Instance.modelGodhead;
      }
      
      private function __stageRotateClick(param1:MouseEvent) : void
      {
         if(param1.target && param1.target is TextButton && (param1.target as TextButton).text == LanguageMgr.GetTranslation("theseusgodhead.rotate"))
         {
            return;
         }
         var _loc2_:TheseusGodheadBagItem = param1.target as TheseusGodheadBagItem;
         if(!(_loc2_ && _loc2_.data))
         {
            _isRotateMode = false;
            model.isRotateMode = _isRotateMode;
            stage.removeEventListener("click",__stageRotateClick,true);
            stage.removeEventListener("mouseMove",__stageMouseMove);
            if(_rotateCursor && _rotateCursor.parent)
            {
               _rotateCursor.parent.removeChild(_rotateCursor);
            }
            Mouse.show();
         }
      }
      
      public function setGoods(param1:Array) : void
      {
         _allGoods = param1;
         _allGoods.sortOn(["templateId","stoneId"],[16,16]);
         refreshView();
      }
      
      public function gotoPage(param1:int) : void
      {
         if(param1 < 1)
         {
            param1 = 1;
         }
         if(param1 > _pageCount)
         {
            param1 = _pageCount;
         }
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
      
      private function refreshView(param1:* = null) : void
      {
         var _loc3_:TheseusGodheadBagItem = null;
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TheseusGodheadStoneInfo = null;
         var _loc10_:int = 0;
         var _loc2_:int = 0;
         clear();
         if(!_allGoods)
         {
            _allGoods = [];
         }
         var _loc7_:int = (_curPage - 1) * _pageSize;
         var _loc9_:int = Math.min(_loc7_ + _pageSize,_allGoods.length);
         var _loc4_:int = int(_allGoods.length);
         _loc8_ = 0;
         while(_loc8_ < _pageSize)
         {
            _loc5_ = _loc7_ + _loc8_;
            _loc6_ = null;
            _loc3_ = new TheseusGodheadBagItem();
            if(_loc5_ >= _loc4_)
            {
               _loc3_.data = null;
            }
            else
            {
               _loc6_ = _allGoods[_loc5_] as TheseusGodheadStoneInfo;
               _loc3_.data = _loc6_;
               _loc3_.bagPos = _loc5_;
            }
            if(_loc6_)
            {
               _loc3_.addEventListener("click",__itemClick);
            }
            _loc10_ = _loc8_ / _colCount;
            _loc2_ = _loc8_ % _colCount;
            _loc3_.x = _loc2_ * (_itemWidth + _hGap) + 5;
            _loc3_.y = _loc10_ * (_itemHeight + _vGap) + 5;
            if(_container)
            {
               _container.addChild(_loc3_);
               _items.push(_loc3_);
            }
            _loc8_++;
         }
      }
      
      public function get selectedGoods() : TheseusGodheadStoneInfo
      {
         return _selectedGoods;
      }
      
      public function toggleRotateMode() : void
      {
         __rotateBtnClick(null);
      }
      
      public function toggleDecomposeMode() : void
      {
         _isDecomposeMode = !_isDecomposeMode;
         trace("TheseusGodheadBagView: toggleDecomposeMode, _isDecomposeMode=" + _isDecomposeMode);
         if(!_isDecomposeMode)
         {
            clearSelection();
         }
      }
      
      public function get isDecomposeMode() : Boolean
      {
         return _isDecomposeMode;
      }
      
      private function __itemClick(param1:MouseEvent) : void
      {
         var _loc2_:TheseusGodheadBagItem = param1.currentTarget as TheseusGodheadBagItem;
         if(!_loc2_)
         {
            return;
         }
         trace("TheseusGodheadBagView: __itemClick, _isDecomposeMode=" + _isDecomposeMode + ", item.data=" + _loc2_.data);
         if(_isDecomposeMode)
         {
            _lastClickedItem = _loc2_;
            dispatchEvent(new Event("change"));
            return;
         }
         selectItem(_loc2_);
         dispatchEvent(new Event("change"));
      }
      
      public function get lastClickedItem() : TheseusGodheadBagItem
      {
         return _lastClickedItem;
      }
      
      private function selectItem(param1:TheseusGodheadBagItem) : void
      {
         if(_selected)
         {
            _selected.selected = false;
         }
         _selected = param1;
         _selected.selected = true;
         _selectedGoods = param1.data;
      }
      
      public function clearSelection() : void
      {
         if(_selected)
         {
            _selected.selected = false;
            _selected = null;
         }
         _selectedGoods = null;
      }
      
      private function clear() : void
      {
         _selected = null;
         _selectedGoods = null;
         for each(var _loc1_:TheseusGodheadBagItem in _items)
         {
            if(_loc1_.data)
            {
               _loc1_.removeEventListener("click",__itemClick);
               _loc1_.removeEventListener("dragStart",__itemDragStart,true);
            }
            _loc1_.dispose();
         }
         _items.length = 0;
         if(_container)
         {
            ObjectUtils.disposeAllChildren(_container);
         }
      }
      
      private function __itemDragStart(param1:Event) : void
      {
         dispatchEvent(param1);
      }
      
      private function __onSlateAddToDecompose(param1:NotificationEvent) : void
      {
         var _loc4_:int = int(param1.data.stoneId);
         var _loc3_:int = int(model.DecomposeList.indexOf(_loc4_));
         if(_loc3_ != -1)
         {
            return;
         }
         model.DecomposeList.push(_loc4_);
         for each(var _loc2_:TheseusGodheadBagItem in _items)
         {
            if(_loc2_.data && _loc2_.data.stoneId == _loc4_)
            {
               _loc2_.inDecomposeList = true;
               return;
            }
         }
      }
      
      private function __onSlateRemoveFromDecompose(param1:NotificationEvent) : void
      {
         var _loc4_:int = int(param1.data);
         var _loc3_:int = int(model.DecomposeList.indexOf(_loc4_));
         if(_loc3_ != -1)
         {
            model.DecomposeList.splice(_loc3_,1);
         }
         for each(var _loc2_:TheseusGodheadBagItem in _items)
         {
            if(_loc2_.data && _loc2_.data.stoneId == _loc4_)
            {
               _loc2_.inDecomposeList = false;
               return;
            }
         }
      }
      
      private function __onDecomposeModeCancel(param1:NotificationEvent) : void
      {
         var _loc3_:int = 0;
         model.DecomposeList = [];
         for each(var _loc2_:TheseusGodheadBagItem in _items)
         {
            if(_loc2_.inDecomposeList)
            {
               _loc2_.inDecomposeList = false;
            }
         }
      }
      
      public function dispose() : void
      {
         clear();
         NotificationManager.instance.removeEventListener("slateAddToDecompose",__onSlateAddToDecompose);
         NotificationManager.instance.removeEventListener("slateRemoveFromDecompose",__onSlateRemoveFromDecompose);
         NotificationManager.instance.removeEventListener("decomposeModeCancel",__onDecomposeModeCancel);
         NotificationManager.instance.removeEventListener("refreshbaglist",refreshView);
         if(_isRotateMode && stage)
         {
            stage.removeEventListener("click",__stageRotateClick,true);
            stage.removeEventListener("mouseMove",__stageMouseMove);
            if(_rotateCursor && _rotateCursor.parent)
            {
               _rotateCursor.parent.removeChild(_rotateCursor);
            }
            Mouse.show();
         }
         ObjectUtils.disposeObject(_panel);
         _panel = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         ObjectUtils.disposeObject(_container);
         _container = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

