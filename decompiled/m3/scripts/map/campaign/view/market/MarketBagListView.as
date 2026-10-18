package map.campaign.view.market
{
   import bag.events.BagEvent;
   import cell.mediator.marketbag.MarketItemCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Component;
   import flash.utils.Dictionary;
   import logging.LoggerSys;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.GoodsManager;
   import yishi.view.community.BaseItemView;
   
   public class MarketBagListView extends Component
   {
      
      private var _list:SimpleTileList;
      
      private var _itemDic:Dictionary;
      
      private var _itemList:Vector.<BaseItemView>;
      
      private var _data:Vector.<GoodsInfo>;
      
      private var _defaultNum:int = 63;
      
      private var _page:int;
      
      public function MarketBagListView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _data = new Vector.<GoodsInfo>();
         _itemDic = new Dictionary();
         _itemList = new Vector.<BaseItemView>();
         _list = ComponentFactory.Instance.creatCustomObject("MarketBagListView.SimpleTileList",[7]);
         addChild(_list);
         initList();
      }
      
      private function unitView() : void
      {
         if(_list)
         {
            _list.dispose();
         }
         _list = null;
         _itemList = null;
         _data = null;
      }
      
      private function initList() : void
      {
         var _loc4_:* = null;
         var _loc3_:int = 0;
         var _loc2_:MarketItemCell = null;
         var _loc1_:Array = GoodsManager.instance.getGeneralBagList().getList();
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            if(_loc1_[_loc3_].isBinds == false)
            {
               _data.push(_loc1_[_loc3_]);
            }
            _loc3_++;
         }
         _list.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < _defaultNum * 4)
         {
            if(_loc3_ < _defaultNum)
            {
               _loc2_ = ComponentFactory.Instance.creatCustomObject("MarketBagListView.cell");
               _loc2_.pos = -1;
               _loc2_.lock = false;
               _loc2_.celltType = "BAG_TYPE";
               _list.addChild(_loc2_);
               _itemList.push(_loc2_);
            }
            if(_data.length <= _loc3_)
            {
               _data.push(null);
            }
            _loc3_++;
         }
         _list.commitChanges();
         gotoPage(0);
      }
      
      public function gotoPage(param1:int) : void
      {
         var _loc3_:GoodsInfo = null;
         var _loc2_:int = 0;
         if(param1 >= 4 || param1 < 0)
         {
            return;
         }
         _page = param1;
         for(var _loc4_:String in _itemDic)
         {
            delete _itemDic[_loc4_];
         }
         _loc2_ = 0;
         while(_loc2_ < _defaultNum)
         {
            _loc3_ = _data[_page * _defaultNum + _loc2_];
            _itemList[_loc2_].data = _loc3_;
            if(_loc3_)
            {
               _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType] = _itemList[_loc2_];
            }
            _loc2_++;
         }
      }
      
      private function initEvent() : void
      {
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
      }
      
      private function removeEvent() : void
      {
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
      }
      
      private function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:GoodsInfo = param1.info;
         if(_loc3_.bagType != 1 || Boolean(_loc3_.isBinds))
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < _data.length)
         {
            if(_data[_loc2_] && _data[_loc2_].id == _loc3_.id)
            {
               _data[_loc2_] = null;
               if(_loc2_ >= _page * _defaultNum && _loc2_ < (_page + 1) * _defaultNum)
               {
                  _itemList[_loc2_ - _page * _defaultNum].data = null;
                  _itemList[_loc2_ - _page * _defaultNum].setNormalFilter();
               }
               break;
            }
            _loc2_++;
         }
         delete _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
      }
      
      private function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         if(_loc3_.bagType != 1 || Boolean(_loc3_.isBinds))
         {
            return;
         }
         var _loc2_:BaseItemView = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_ && _loc2_.data)
         {
            _loc2_.data = _loc3_;
         }
         else
         {
            addItem(_loc3_);
         }
         cleanBagItemFilter();
      }
      
      private function addItem(param1:GoodsInfo) : void
      {
         var _loc2_:int = 0;
         if(!param1.isBinds && _data)
         {
            _loc2_ = findBagEmputyIndex(param1);
            if(_loc2_ >= 0)
            {
               _data[_loc2_] = param1;
               if(_loc2_ >= _page * _defaultNum && _loc2_ < (_page + 1) * _defaultNum)
               {
                  _itemList[_loc2_ - _page * _defaultNum].bagType = param1.bagType;
                  _itemList[_loc2_ - _page * _defaultNum].pos = param1.pos;
                  _itemList[_loc2_ - _page * _defaultNum].data = param1;
                  _itemDic[param1.pos + "_" + param1.objectId + "_" + param1.bagType] = _itemList[_loc2_ - _page * _defaultNum];
               }
            }
            else
            {
               LoggerSys.info(LanguageMgr.GetTranslation("market.logger.msg03",param1.templateInfo.TemplateName));
            }
         }
      }
      
      private function findBagEmputyIndex(param1:GoodsInfo) : int
      {
         var _loc2_:int = 0;
         if(_data)
         {
            _loc2_ = 0;
            while(_loc2_ < _data.length)
            {
               if(_data[_loc2_] && _data[_loc2_].id == param1.id)
               {
                  return _loc2_;
               }
               _loc2_++;
            }
            _loc2_ = 0;
            while(_loc2_ < _data.length)
            {
               if(_data[_loc2_] == null)
               {
                  return _loc2_;
               }
               _loc2_++;
            }
         }
         return -1;
      }
      
      private function cleanBagItemFilter() : void
      {
         for each(var _loc1_:BaseItemView in _itemList)
         {
            if(_loc1_ && !_loc1_.isNormalFilter)
            {
               _loc1_.setNormalFilter();
            }
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unitView();
         super.dispose();
      }
   }
}

