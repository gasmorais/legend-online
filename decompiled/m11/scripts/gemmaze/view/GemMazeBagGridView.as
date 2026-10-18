package gemmaze.view
{
   import bag.events.BagEvent;
   import bag.view.BaseBagListView;
   import cell.view.gemmazebag.GemMazeBagCell;
   import com.pickgliss.ui.ComponentFactory;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.GoodsManager;
   import yishi.view.community.BaseItemView;
   
   public class GemMazeBagGridView extends BaseBagListView
   {
      
      private static const COLUMN_NUM:int = 3;
      
      private static const ROW_NUM:int = 19;
      
      private static const ROW_NUM_PLUS:int = 19;
      
      private static const PAGE_COUNT:int = 1;
      
      private var rowNum:int = 19;
      
      private var columnNum:int = 3;
      
      public function GemMazeBagGridView()
      {
         if(GoodsManager.instance.getMazeBagList().getList().length > 3 * 19)
         {
         }
         bagType = 24;
         super(columnNum,rowNum,1);
         _list.vSpace = 1;
         _list.hSpace = 1;
         this.sort(true);
      }
      
      private function updateScrollPanel() : void
      {
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
      }
      
      override protected function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         var _loc2_:BaseItemView = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_)
         {
            _loc2_.data = null;
         }
      }
      
      override protected function creatItem(param1:Boolean = false, param2:int = -1) : BaseItemView
      {
         var _loc3_:GemMazeBagCell = ComponentFactory.Instance.creatCustomObject("gemmaze.BagCell");
         _loc3_.bagType = bagType;
         _loc3_.objectId = 0;
         _loc3_.lock = false;
         return _loc3_;
      }
      
      override public function refreshData() : void
      {
         _data = GoodsManager.instance.getMazeBagList();
         super.refreshView();
      }
      
      override public function sort(param1:Boolean, param2:int = 0) : void
      {
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         refreshData();
         if(!_data)
         {
            return;
         }
         var _loc4_:Array = [];
         var _loc5_:Array = [];
         var _loc3_:Array = [];
         _loc3_ = _loc3_.concat(_data.getList());
         sortByType = param2;
         _loc3_.sort(sortFun);
         var _loc7_:Boolean = false;
         _loc6_ = 0;
         while(_loc6_ < _loc3_.length)
         {
            _loc8_ = int(GoodsInfo(_loc3_[_loc6_]).pos);
            if(_loc8_ != _loc6_)
            {
               _loc7_ = true;
            }
            _loc4_.push(_loc8_);
            _loc5_.push(_loc6_);
            _loc6_++;
         }
         if(_loc7_ || param1)
         {
            GoodsManager.instance.fixBagItem(_loc4_,_loc5_,bagType,param1);
         }
      }
   }
}

