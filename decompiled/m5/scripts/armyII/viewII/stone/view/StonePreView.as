package armyII.viewII.stone.view
{
   import armyII.viewII.stone.item.StoneDesCell;
   import armyII.viewII.stone.item.StonePreGroupItem;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import utils.LogicUtils;
   import yishi.manager.TempleteManager;
   
   public class StonePreView extends Sprite
   {
      
      private var _bg:MutipleImage;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _vbox:VBox;
      
      private var _itemList:Array = [];
      
      private var _hbox:HBox;
      
      public function StonePreView()
      {
         super();
         initView();
         refreshView();
      }
      
      private function initView() : void
      {
         var _loc1_:StoneDesCell = null;
         var _loc2_:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("ui.army.previewBg");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("ui.army.opspanel3");
         _hbox = ComponentFactory.Instance.creatComponentByStylename("army.runeDes.hbox");
         _vbox = new VBox();
         _vbox.spacing = 5;
         addChild(_bg);
         addChild(_hbox);
         addChild(_scrollPanel);
         _scrollPanel.setView(_vbox);
         _hbox.beginChanges();
         _loc2_ = 1;
         while(_loc2_ < 6)
         {
            _loc1_ = new StoneDesCell();
            _loc1_.xing = _loc2_;
            _hbox.addChild(_loc1_);
            _loc2_++;
         }
         _hbox.commitChanges();
      }
      
      public function refreshView() : void
      {
         var _loc1_:StonePreGroupItem = null;
         var _loc3_:int = 0;
         var _loc4_:Array = TempleteManager.instance.runeHoleInfoCate.getGroupList(4);
         var _loc2_:int = int(_loc4_.length);
         _vbox.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = new StonePreGroupItem();
            _loc1_.temp = _loc4_[_loc3_];
            _itemList.push(_loc1_);
            _vbox.addChild(_loc1_);
            _loc3_++;
         }
         _vbox.commitChanges();
         _scrollPanel.invalidateViewport();
      }
      
      public function dispose() : void
      {
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

