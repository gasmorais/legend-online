package child.equip
{
   import bag.events.BagEvent;
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import managers.ChildManager;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildModel;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleDictionary;
   
   public class ChildEquipBagView extends Component
   {
      
      private var _list:SimpleTileList;
      
      private var _bagScroll:ScrollPanel;
      
      private var _defaultCount:int;
      
      private var _rowCount:int;
      
      private var _columnCount:int;
      
      private var _data:Array;
      
      private var _itemList:Vector.<ChildBagCell>;
      
      private var _itemDic:SimpleDictionary;
      
      public function ChildEquipBagView(param1:int, param2:int)
      {
         super();
         _rowCount = param1;
         _columnCount = param2;
         _defaultCount = _rowCount * _columnCount;
         initView();
         addNullItems(_defaultCount);
         refreshView();
         initEvent();
      }
      
      private function initView() : void
      {
         _list = ComponentFactory.Instance.creatCustomObject("pet.SimpleTileList",[_columnCount]);
         _bagScroll = ComponentFactory.Instance.creatComponentByStylename("ChildEquipBagView.panel");
         _itemList = new Vector.<ChildBagCell>();
         _itemDic = new SimpleDictionary(true);
         if(_rowCount == 3)
         {
            _bagScroll.height = 143;
         }
         _bagScroll.setView(_list);
         addChild(_bagScroll);
      }
      
      private function initEvent() : void
      {
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
         MsgMan.addObserver("ChildEvent.HEAD_CHANGE",this,__changeView);
         MsgMan.addObserver("ChildEvent.CHILD_NS_TEMP_SELECT",this,__changeView);
         MsgMan.addObserver("ChildEvent.REFRESH_BAG",this,__changeView);
      }
      
      private function removeEvent() : void
      {
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
         MsgMan.removeObserver("ChildEvent.HEAD_CHANGE",this,__changeView);
         MsgMan.removeObserver("ChildEvent.CHILD_NS_TEMP_SELECT",this,__changeView);
         MsgMan.removeObserver("ChildEvent.REFRESH_BAG",this,__changeView);
      }
      
      private function addNullItems(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:ChildBagCell = null;
         if(param1 <= 0)
         {
            return;
         }
         var _loc2_:int = int(_itemList.length);
         _loc4_ = _loc2_;
         while(_loc4_ < param1 + _loc2_)
         {
            _loc3_ = ComponentFactory.Instance.creatCustomObject("ChildEquipBagView.BagCell");
            _loc3_.pos = -1;
            _loc3_.data = null;
            _loc3_.celltType = "CELL_BOTTOM";
            _list.addChild(_loc3_);
            _itemList.push(_loc3_);
            _loc4_++;
         }
         _list.commitChanges();
         _bagScroll.invalidateViewport();
         _list.beginChanges();
         _list.hSpace = -6;
      }
      
      private function getEmptyIndex() : int
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _itemList.length)
         {
            if(_itemList[_loc1_].data == null)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return -1;
      }
      
      private function __changeView(param1:String, param2:Object) : void
      {
         if(curSelectChild)
         {
            refreshView();
         }
      }
      
      private function refreshData() : void
      {
         var _loc5_:Array = null;
         var _loc4_:Array = null;
         var _loc7_:Array = null;
         var _loc6_:Array = null;
         var _loc3_:GoodsInfo = null;
         var _loc2_:int = 0;
         _data = [];
         var _loc1_:Array = [];
         if(ChildManager.instance.currSelectedPage != "CHILD_EQUIP_PAGE")
         {
            return;
         }
         if(ChildManager.instance.currSelectedView == "CHILDEQUIPUPGRADEVIEW")
         {
            _loc5_ = GoodsManager.instance.getGeneralBagChildEquipList(1,5);
            _loc5_.sort(sortEquip);
            _loc4_ = GoodsManager.instance.getChildEquipListById(curSelectChild.childId,1,5);
            _loc4_.sort(sortEquip);
            _loc7_ = GoodsManager.instance.getGeneralBagGoodsBySonType(227,1);
            _loc7_.sort(sortEquip);
            _loc6_ = GoodsManager.instance.getGeneralBagGoodsBySonType(227,3);
            _loc6_.sort(sortEquip);
         }
         else if(ChildManager.instance.currSelectedView == "CHILDEQUIPREFRESHVIEW")
         {
            _loc5_ = GoodsManager.instance.getGeneralBagChildEquipList();
            _loc5_.sort(sortEquip);
            _loc4_ = GoodsManager.instance.getChildEquipListById(curSelectChild.childId);
            _loc4_.sort(sortEquip);
            _loc7_ = GoodsManager.instance.getGeneralBagGoodsBySonType(227,2);
         }
         else if(ChildManager.instance.currSelectedView == "CHILDEQUIPINSERTVIEW")
         {
            _loc5_ = GoodsManager.instance.getGeneralBagChildEquipList();
            _loc5_.sort(sortEquip);
            _loc4_ = GoodsManager.instance.getChildEquipListById(curSelectChild.childId);
            _loc4_.sort(sortEquip);
            _loc7_ = GoodsManager.instance.getGeneralBagGoodsBySonType(224);
            _loc7_ = _loc7_.concat(GoodsManager.instance.getStoneBagGoodsBySonType(224));
            _loc7_.sort(sortEquip);
         }
         _loc1_ = _loc1_.concat(_loc4_).concat(_loc5_).concat(_loc7_).concat(_loc6_);
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc2_] as GoodsInfo;
            if(_loc3_)
            {
               _data.push(_loc3_);
            }
            _loc2_++;
         }
      }
      
      private function sortEquip(param1:GoodsInfo, param2:GoodsInfo) : int
      {
         if(!param1.isBinds && Boolean(param2.isBinds))
         {
            return -1;
         }
         if(param1.isBinds && !param2.isBinds)
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
         if(param1.templateInfo.NeedGrades > param2.templateInfo.NeedGrades)
         {
            return -1;
         }
         if(param1.templateInfo.NeedGrades < param2.templateInfo.NeedGrades)
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
         return 0;
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc3_:GoodsInfo = null;
         refreshData();
         if(!_bagScroll || !_bagScroll.viewPort)
         {
            return;
         }
         _itemDic.clear();
         _loc2_ = 0;
         while(_loc2_ < _itemList.length)
         {
            _itemList[_loc2_].data = null;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _data.length)
         {
            _loc3_ = _data[_loc2_] as GoodsInfo;
            if(_loc3_)
            {
               if(_itemList.length <= _loc2_)
               {
                  addNullItems(_columnCount);
               }
               _itemList[_loc2_].data = _loc3_;
               _itemList[_loc2_].pos = _loc3_.pos;
               _itemDic.add(_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType,_itemList[_loc2_]);
            }
            _loc2_++;
         }
         _bagScroll.invalidateViewport();
         var _loc1_:IntPoint = new IntPoint(0,0);
         _bagScroll.viewPort.viewPosition = _loc1_;
      }
      
      private function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc2_:ChildBagCell = null;
         var _loc3_:int = 0;
         var _loc4_:GoodsInfo = param1.info;
         if(_loc4_.bagType == 29)
         {
            if(_loc4_.objectId == playerInfo.userId)
            {
               model.hideGoods = _loc4_;
            }
         }
         else if(filterGoods(_loc4_))
         {
            _loc2_ = _itemDic[_loc4_.pos + "_" + _loc4_.objectId + "_" + _loc4_.bagType];
            if(_loc2_)
            {
               _loc2_.data = _loc4_;
            }
            else if(_loc4_.objectId == curSelectChild.childId || _loc4_.objectId <= 0)
            {
               _loc3_ = getEmptyIndex();
               if(_loc3_ == -1)
               {
                  addNullItems(_columnCount);
               }
               _loc3_ = getEmptyIndex();
               if(_loc3_ >= 0)
               {
                  _itemList[_loc3_].data = _loc4_;
                  _itemDic[_loc4_.pos + "_" + _loc4_.objectId + "_" + _loc4_.bagType] = _itemList[_loc3_];
               }
            }
         }
      }
      
      private function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         if(_loc3_.bagType == 29 && _loc3_.objectId == playerInfo.userId)
         {
            model.hideGoods = null;
         }
         var _loc2_:ChildBagCell = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_)
         {
            _loc2_.data = null;
         }
      }
      
      private function filterGoods(param1:GoodsInfo) : Boolean
      {
         if(param1.bagType == 28 || param1.bagType == 30)
         {
            return true;
         }
         if(ChildManager.instance.currSelectedPage == "CHILD_EQUIP_PAGE" && ChildManager.instance.currSelectedView == "CHILDEQUIPREFRESHVIEW")
         {
            if(param1.templateInfo.SonType == 227 && param1.templateInfo.Property1 == 2)
            {
               return true;
            }
         }
         else if(ChildManager.instance.currSelectedPage == "CHILD_EQUIP_PAGE" && ChildManager.instance.currSelectedView == "CHILDEQUIPUPGRADEVIEW")
         {
            if(param1.templateInfo.SonType == 227 && (param1.templateInfo.Property1 == 1 || param1.templateInfo.Property1 == 3))
            {
               return true;
            }
         }
         else if(ChildManager.instance.currSelectedPage == "CHILD_EQUIP_PAGE" && ChildManager.instance.currSelectedView == "CHILDEQUIPINSERTVIEW")
         {
            if(param1.templateInfo.SonType == 224)
            {
               return true;
            }
         }
         return false;
      }
      
      private function get curSelectChild() : ChildData
      {
         return ChildManager.instance.curSelectChild;
      }
      
      private function get model() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         cleanList();
         ObjectUtils.disposeObject(_bagScroll);
         _bagScroll = null;
         ObjectUtils.disposeObject(_list);
         _list = null;
         LogicUtils.disposeDisplayCollection(_itemDic);
         _itemDic = null;
         _data = null;
         super.dispose();
      }
      
      private function cleanList() : void
      {
         if(_itemList)
         {
            while(_itemList.length > 0)
            {
               _itemList.pop().dispose();
            }
            _itemList = null;
         }
      }
   }
}

