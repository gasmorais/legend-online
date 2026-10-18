package monster.view
{
   import bag.events.BagEvent;
   import bag.view.ItemSellView;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import monster.MonsterAccessoriesSellHelp;
   import monster.cell.MonsterAccessoriesBagCell;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   
   public class MonsterAccessoriesBagView extends Component
   {
      
      private static const MAX_ROW_NUM:int = 60;
      
      private static const ROW_NUM:int = 10;
      
      private static const COL_NUM:int = 5;
      
      private var _propBtn:SelectedIconButton;
      
      private var _accessoriesBtn:SelectedIconButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _list:SimpleTileList;
      
      private var _bagScroll:ScrollPanel;
      
      private var _bagList:Vector.<MonsterAccessoriesBagCell>;
      
      private var _sellBtn:TextButton;
      
      private var _sellView:ItemSellView;
      
      private var _sellBg:Image;
      
      private var _bagData:Array;
      
      public function MonsterAccessoriesBagView()
      {
         super();
         initView();
         initEvent();
         refreshData();
         refreshView();
      }
      
      private function initView() : void
      {
         _propBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterAccessoriesView.propBtn");
         _accessoriesBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterAccessoriesView.accessoriesBtn");
         _list = ComponentFactory.Instance.creatCustomObject("MonsterAccessoriesView.SimpleTileList",[5]);
         _bagScroll = ComponentFactory.Instance.creatComponentByStylename("MonsterAccessoriesView.ScrollPanel");
         _sellBg = ComponentFactory.Instance.creatComponentByStylename("MonsterAccessoriesView.sellBg");
         _sellBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterAccessoriesView.sellBtn");
         _sellBtn.text = LanguageMgr.GetTranslation("armyII.ArmyFrameII.sell");
         addChild(_propBtn);
         addChild(_accessoriesBtn);
         addChild(_bagScroll);
         addChild(_sellBg);
         addChild(_sellBtn);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_accessoriesBtn);
         _btnGroup.addSelectItem(_propBtn);
         _btnGroup.selectIndex = 0;
         _bagScroll.setView(_list);
         initBagView();
      }
      
      private function initEvent() : void
      {
         _btnGroup.addEventListener("change",__btnGroupChangeHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
         _sellBtn.addEventListener("click",__sellBtnHandler);
         MonsterAccessoriesSellHelp.Ins.addEventListener("SELL_GOODS",__openSellViewHandler);
         if(_sellView)
         {
            _sellView.addEventListener("dispose",__disposeHandler1);
         }
      }
      
      private function removeEvent() : void
      {
         _btnGroup.removeEventListener("change",__btnGroupChangeHandler);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
         _sellBtn.removeEventListener("click",__sellBtnHandler);
         MonsterAccessoriesSellHelp.Ins.removeEventListener("SELL_GOODS",__openSellViewHandler);
         if(_sellView)
         {
            _sellView.removeEventListener("dispose",__disposeHandler1);
         }
      }
      
      private function __btnGroupChangeHandler(param1:Event) : void
      {
         refreshData();
         refreshView();
         NotificationManager.instance.sendNotification("FILTER_GOODS");
      }
      
      private function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc2_:GoodsInfo = param1.info;
         if(_loc2_.bagType == 0)
         {
            return;
         }
         refreshData();
         refreshView();
      }
      
      private function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         var _loc2_:GoodsInfo = param1.info;
         if(_loc2_.bagType == 0)
         {
            return;
         }
         refreshData();
         refreshView();
      }
      
      private function __sellBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         param1.stopPropagation();
         param1.stopImmediatePropagation();
         MonsterAccessoriesSellHelp.Ins.onSellButtonClickHandler(this);
      }
      
      private function __openSellViewHandler(param1:*) : void
      {
         if(!_sellView)
         {
            _sellView = ComponentFactory.Instance.creatComponentByStylename("army.ItemSellView");
            _sellView.addEventListener("dispose",__disposeHandler1);
            _sellView.y = -47;
            addChild(_sellView);
         }
         _sellView.addSellGoods(param1.info);
      }
      
      private function __disposeHandler1(param1:Event) : void
      {
         if(_sellView)
         {
            _sellView.removeEventListener("dispose",__disposeHandler1);
         }
         _sellView = null;
      }
      
      private function refreshView() : void
      {
         var _loc1_:MonsterAccessoriesBagCell = null;
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
         for each(var _loc1_:MonsterAccessoriesBagCell in _bagList)
         {
            _loc1_.data = null;
         }
      }
      
      private function initBagView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MonsterAccessoriesBagCell = null;
         _bagList = new Vector.<MonsterAccessoriesBagCell>();
         _list.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < 10 * 5)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("MonsterAccessoriesView.BagCell");
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
         var _loc1_:MonsterAccessoriesBagCell = null;
         _list.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("MonsterAccessoriesView.BagCell");
            _list.addChild(_loc1_);
            _bagList.push(_loc1_);
            _loc2_++;
         }
         _list.commitChanges();
         _bagScroll.invalidateViewport();
      }
      
      private function refreshData() : void
      {
         switch(int(_btnGroup.selectIndex))
         {
            case 0:
               _bagData = GoodsManager.instance.getMonsterAccessoriesBagList();
               break;
            case 1:
               _bagData = GoodsManager.instance.getMonsterPropBagList();
         }
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
         ObjectUtils.disposeObject(_bagScroll);
         _bagScroll = null;
         ObjectUtils.disposeObject(_list);
         _list = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         ObjectUtils.disposeObject(_sellBtn);
         _sellBtn = null;
         ObjectUtils.disposeObject(_sellView);
         _sellView = null;
         ObjectUtils.disposeObject(_sellBg);
         _sellBg = null;
         LogicUtils.disposeDisplayCollection(_bagList);
         _bagList = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

