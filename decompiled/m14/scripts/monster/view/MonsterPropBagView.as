package monster.view
{
   import bag.events.BagEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import monster.cell.MonsterPropBagCell;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.GoodsManager;
   
   public class MonsterPropBagView extends Component
   {
      
      private static const MAX_ROW_NUM:int = 60;
      
      private static const ROW_NUM:int = 10;
      
      private static const COL_NUM:int = 5;
      
      private var _propBtn:SelectedIconButton;
      
      private var _accessoriesBtn:SelectedIconButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _list:SimpleTileList;
      
      private var _bagScroll:ScrollPanel;
      
      private var _bagList:Vector.<MonsterPropBagCell>;
      
      private var _sprite:Sprite;
      
      private var _back:Bitmap;
      
      private var _bagData:Array;
      
      public function MonsterPropBagView()
      {
         super();
         initView();
         initEvent();
         refreshData();
         refreshView();
      }
      
      private function initView() : void
      {
         _propBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterPropBagView.propertyBtn");
         _accessoriesBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterPropBagVew.accessoriesBtn");
         _list = ComponentFactory.Instance.creatCustomObject("MonsterPropBagView.SimpleTileList",[5]);
         _bagScroll = ComponentFactory.Instance.creatComponentByStylename("MonsterPropBagView.ScrollPanel");
         _back = ComponentFactory.Instance.creatBitmap("asset.MonsterPropBagView.back");
         _sprite = new Sprite();
         addChild(_propBtn);
         addChild(_accessoriesBtn);
         addChild(_sprite);
         _sprite.visible = false;
         _sprite.addChild(_back);
         _sprite.addChild(_bagScroll);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_propBtn);
         _btnGroup.addSelectItem(_accessoriesBtn);
         _btnGroup.selectIndex = 0;
         _bagScroll.setView(_list);
         initBagView();
      }
      
      private function initEvent() : void
      {
         _btnGroup.addEventListener("change",__btnGroupChangeHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
      }
      
      private function removeEvent() : void
      {
         _btnGroup.removeEventListener("change",__btnGroupChangeHandler);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
      }
      
      private function __btnGroupChangeHandler(param1:Event) : void
      {
         _sprite.visible = _btnGroup.selectIndex == 1;
      }
      
      private function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc2_:GoodsInfo = param1.info;
         if(_loc2_.bagType == 37)
         {
            return;
         }
         refreshData();
         refreshView();
      }
      
      private function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         var _loc2_:GoodsInfo = param1.info;
         if(_loc2_.bagType == 37)
         {
            return;
         }
         refreshData();
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc1_:MonsterPropBagCell = null;
         var _loc3_:GoodsInfo = null;
         var _loc2_:int = 0;
         clearGoods();
         _loc2_ = 0;
         while(_loc2_ < _bagData.length)
         {
            if(_loc2_ >= 60 * 5)
            {
               break;
            }
            if(_loc2_ >= _bagList.length)
            {
               addItem();
            }
            _loc1_ = _bagList[_loc2_];
            _loc3_ = _bagData[_loc2_];
            _loc1_.data = _loc3_;
            _loc2_++;
         }
      }
      
      private function clearGoods() : void
      {
         for each(var _loc1_:MonsterPropBagCell in _bagList)
         {
            _loc1_.data = null;
         }
      }
      
      private function initBagView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MonsterPropBagCell = null;
         _bagList = new Vector.<MonsterPropBagCell>();
         _list.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < 10 * 5)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("MonsterPropBagView.BagCell");
            _list.addChild(_loc1_);
            _bagList.push(_loc1_);
            _loc2_++;
         }
         _list.commitChanges();
         _bagScroll.invalidateViewport();
      }
      
      private function addItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MonsterPropBagCell = null;
         _list.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("MonsterPropBagView.BagCell");
            _list.addChild(_loc1_);
            _bagList.push(_loc1_);
            _loc2_++;
         }
         _list.commitChanges();
         _bagScroll.invalidateViewport();
      }
      
      private function refreshData() : void
      {
         _bagData = GoodsManager.instance.getMonsterBagList();
         _bagData.sort(sortByTpye);
      }
      
      private function sortByTpye(param1:GoodsInfo, param2:GoodsInfo) : int
      {
         if(param1.isNew && !param2.isNew)
         {
            return -1;
         }
         if(!param1.isNew && Boolean(param2.isNew))
         {
            return 1;
         }
         if(param1.objectId != 0 && param2.objectId == 0)
         {
            return -1;
         }
         if(param1.objectId == 0 && param2.objectId != 0)
         {
            return 1;
         }
         if(param1.templateInfo.Profile > param2.templateInfo.Profile)
         {
            return -1;
         }
         if(param1.templateInfo.Profile < param2.templateInfo.Profile)
         {
            return 1;
         }
         if(param1.strengthenGrade > param2.strengthenGrade)
         {
            return -1;
         }
         if(param1.strengthenGrade < param2.strengthenGrade)
         {
            return 1;
         }
         return param1.templateId > param2.templateId ? -1 : 1;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_propBtn);
         _propBtn = null;
         ObjectUtils.disposeObject(_accessoriesBtn);
         _accessoriesBtn = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         ObjectUtils.disposeObject(_list);
         _list = null;
         ObjectUtils.disposeObject(_bagScroll);
         _bagScroll = null;
         ObjectUtils.disposeObject(_sprite);
         _sprite = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         LogicUtils.disposeDisplayCollection(_bagList);
         _bagList = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get btnGroup() : SelectedButtonGroup
      {
         return _btnGroup;
      }
   }
}

