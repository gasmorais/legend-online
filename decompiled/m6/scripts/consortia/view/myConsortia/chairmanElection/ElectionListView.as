package consortia.view.myConsortia.chairmanElection
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import mvc.module.consortia.ConsortiaVotingUserInfo;
   
   public class ElectionListView extends Sprite implements Disposeable
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _title:ElectionListTitle;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _items:Vector.<ElectionListItem> = new Vector.<ElectionListItem>();
      
      private var _group:SelectedButtonGroup;
      
      private var _selectedItem:ElectionListItem;
      
      private var _selecedValue:ConsortiaVotingUserInfo;
      
      private var _dataProvider:Vector.<ConsortiaVotingUserInfo>;
      
      private var _enable:Boolean = true;
      
      public function ElectionListView()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortia.ElectionListBg");
         _title = ComponentFactory.Instance.creatCustomObject("consortia.ElectionListTitle");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("consortia.ElectionScrollPanel");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("consortia.ElectionVbox");
         _group = new SelectedButtonGroup();
         addChild(_bg);
         addChild(_title);
         addChild(_scrollPanel);
         _scrollPanel.beginChanges();
         _scrollPanel.setView(_vBox);
      }
      
      public function dispose() : void
      {
         if(parent)
         {
            parent.removeChild(this);
            ObjectUtils.disposeObject(_bg);
            _bg = null;
            ObjectUtils.disposeObject(_title);
            _title = null;
            ObjectUtils.disposeObject(_scrollPanel);
            _scrollPanel = null;
            ObjectUtils.disposeObject(_vBox);
            _vBox = null;
            ObjectUtils.disposeObject(_items);
            _items = null;
            ObjectUtils.disposeObject(_group);
            _group = null;
            return;
         }
      }
      
      public function get selectedItem() : ElectionListItem
      {
         return selectedIndex >= 0 ? _items[selectedIndex] : null;
      }
      
      public function get selecedValue() : ConsortiaVotingUserInfo
      {
         return selectedItem != null ? selectedItem.data : null;
      }
      
      public function get selectedIndex() : int
      {
         return _group.selectIndex;
      }
      
      public function get dataProvider() : Vector.<ConsortiaVotingUserInfo>
      {
         return _dataProvider;
      }
      
      public function set dataProvider(param1:Vector.<ConsortiaVotingUserInfo>) : void
      {
         _dataProvider = new Vector.<ConsortiaVotingUserInfo>();
         for each(var _loc2_:ElectionListItem in _items)
         {
            _vBox.removeChild(_loc2_);
         }
         _items.splice(0,_items.length);
         _group.removeAllItem();
         for each(var _loc3_:ConsortiaVotingUserInfo in param1)
         {
            if(_loc3_.isVotingman)
            {
               _loc2_ = new ElectionListItem();
               _vBox.addChild(_loc2_);
               _items.push(_loc2_);
               _dataProvider.push(_loc3_);
               _group.addSelectItem(_loc2_.checkBox);
               _loc2_.data = _loc3_;
            }
         }
         _scrollPanel.invalidateViewport();
      }
      
      public function get group() : SelectedButtonGroup
      {
         return _group;
      }
      
      public function set group(param1:SelectedButtonGroup) : void
      {
         _group = param1;
      }
      
      public function get enable() : Boolean
      {
         return _enable;
      }
      
      public function set enable(param1:Boolean) : void
      {
         _enable = param1;
         for each(var _loc2_:ElectionListItem in _items)
         {
            _loc2_.checkBox.enable = enable;
         }
      }
   }
}

