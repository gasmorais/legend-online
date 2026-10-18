package stelesys.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import stelesys.item.StelesysBaseBoxItem;
   
   public class StelesysBagView extends Sprite
   {
      
      public static const BAG_SIZE:int = 40;
      
      protected var _bagPanel:ScrollPanel;
      
      protected var _bagList:SimpleTileList;
      
      protected var _itemList:Array = [];
      
      protected var _clsStyle:String;
      
      private var _titleListStyle:String;
      
      private var _panelStyle:String;
      
      private var _stateStyle:String;
      
      protected var _stateTxt:FilterFrameText;
      
      public var titleCol:int;
      
      public function StelesysBagView()
      {
         super();
      }
      
      public function get clsStyle() : String
      {
         return _clsStyle;
      }
      
      public function set clsStyle(param1:String) : void
      {
         _clsStyle = param1;
      }
      
      public function get panelStyle() : String
      {
         return _panelStyle;
      }
      
      public function set panelStyle(param1:String) : void
      {
         _panelStyle = param1;
         _bagPanel = ComponentFactory.Instance.creatComponentByStylename(_panelStyle);
         addChild(_bagPanel);
         _bagPanel.setView(_bagList);
      }
      
      public function get titleListStyle() : String
      {
         return _titleListStyle;
      }
      
      public function set titleListStyle(param1:String) : void
      {
         _titleListStyle = param1;
         _bagList = ComponentFactory.Instance.creatCustomObject(_titleListStyle,[titleCol]);
      }
      
      protected function removeAllChildFromBagList() : void
      {
         var _loc1_:StelesysBaseBoxItem = null;
         while(_bagList.numChildren > 0)
         {
            _loc1_ = _bagList.getChildAt(0) as StelesysBaseBoxItem;
            _loc1_.doRemoveSelf();
         }
      }
      
      public function refreshView(param1:Array) : void
      {
         var _loc2_:StelesysBaseBoxItem = null;
         var _loc5_:int = 0;
         _bagList.beginChanges();
         removeAllChildFromBagList();
         if(param1 == null || param1.length == 0)
         {
            if(_stateTxt)
            {
               _stateTxt.visible = true;
            }
            _bagList.commitChanges();
            _bagPanel.invalidateViewport();
            return;
         }
         var _loc4_:int = int(_itemList.length);
         var _loc3_:int = int(param1.length);
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            if(_loc5_ >= _loc4_)
            {
               _loc2_ = ComponentFactory.Instance.creatCustomObject(_clsStyle);
            }
            else
            {
               _loc2_ = _itemList[_loc5_];
            }
            _loc2_.data = param1[_loc5_];
            _bagList.addChild(_loc2_);
            _loc5_++;
         }
         _bagList.commitChanges();
         _bagPanel.invalidateViewport();
         if(_stateTxt)
         {
            if(_bagList.numChildren == 0)
            {
               _stateTxt.visible = true;
            }
            else
            {
               _stateTxt.visible = false;
            }
         }
      }
      
      public function forbitItemClick() : void
      {
         _bagList.mouseEnabled = _bagList.mouseChildren = false;
      }
      
      public function dispose() : void
      {
         for each(var _loc1_:StelesysBaseBoxItem in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         ObjectUtils.disposeObject(_bagPanel);
         _bagPanel = null;
         ObjectUtils.disposeObject(_bagList);
         _bagList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _itemList = null;
      }
      
      public function get stateStyle() : String
      {
         return _stateStyle;
      }
      
      public function set stateStyle(param1:String) : void
      {
         _stateStyle = param1;
         _stateTxt = ComponentFactory.Instance.creatComponentByStylename(_stateStyle);
         _stateTxt.text = LanguageMgr.GetTranslation("stela.noGoods");
         addChild(_stateTxt);
      }
      
      public function get itemList() : Array
      {
         return _itemList;
      }
      
      public function get bagList() : SimpleTileList
      {
         return _bagList;
      }
   }
}

