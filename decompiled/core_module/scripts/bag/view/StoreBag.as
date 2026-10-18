package bag.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.GoodsManager;
   import yishi.view.community.BaseItemView;
   
   public class StoreBag extends BaseBagListView
   {
      
      public var type:int = 0;
      
      public function StoreBag(param1:int = 7, param2:int = 7, param3:int = 1, param4:int = 0)
      {
         bagType = 34;
         type = param4;
         super(param1,param2,param3);
         _list.vSpace = -6;
         _list.hSpace = -7;
      }
      
      override public function refreshData() : void
      {
         _data = GoodsManager.instance.getStroeBagList();
      }
      
      override protected function creatItem(param1:Boolean = false, param2:int = -1) : BaseItemView
      {
         var _loc3_:* = undefined;
         if(type == 0)
         {
            _loc3_ = ComponentFactory.Instance.creatCustomObject("army.HeroBagItemView");
         }
         else
         {
            _loc3_ = ComponentFactory.Instance.creatCustomObject("consortia.ConsortiaBagCell");
         }
         _loc3_.bagType = bagType;
         _loc3_.objectId = 0;
         _loc3_.lock = false;
         return _loc3_;
      }
      
      override public function sort(param1:Boolean, param2:int = 0) : void
      {
         var _loc5_:GoodsInfo = null;
         var _loc11_:int = 0;
         var _loc9_:int = 0;
         var _loc3_:int = 0;
         refreshData();
         if(!_data)
         {
            return;
         }
         var _loc7_:Array = [];
         var _loc14_:Array = [];
         var _loc13_:Array = [];
         var _loc4_:Array = [];
         var _loc10_:int = 0;
         var _loc8_:int = 0;
         var _loc12_:Array = [];
         _loc12_ = _loc12_.concat(_data.getList());
         var _loc6_:GoodsInfo = GoodsManager.instance.goodsListByPos["0_0_1"];
         if(_loc6_ && _loc6_.templateInfo.SonType == 298)
         {
            _loc5_ = _loc12_.splice(_loc12_.indexOf(_loc6_),1)[0];
         }
         sortByType = param2;
         _loc12_.sort(sortFun);
         if(_loc5_)
         {
            _loc12_.unshift(_loc5_);
         }
         var _loc15_:Boolean = false;
         _loc9_ = 0;
         while(_loc9_ < _loc12_.length)
         {
            _loc11_ = int(GoodsInfo(_loc12_[_loc9_]).pos);
            _loc3_ = int(GoodsInfo(_loc12_[_loc9_]).templateInfo.SonType);
            if(_loc11_ != _loc9_)
            {
               _loc15_ = true;
            }
            if(_loc3_ == 205 || _loc3_ == 224 || _loc3_ == 228 || _loc3_ == 312 || _loc3_ == 329)
            {
               _loc13_.push(_loc11_);
            }
            else
            {
               _loc7_.push(_loc11_);
               _loc14_.push(_loc10_);
               _loc10_++;
            }
            _loc9_++;
         }
         _loc9_ = 0;
         while(_loc9_ < _loc13_.length)
         {
            _loc4_.push(_loc7_.length + _loc9_);
            _loc9_++;
         }
         _loc7_ = _loc7_.concat(_loc13_);
         _loc14_ = _loc14_.concat(_loc4_);
         if(_loc15_ || param1)
         {
            GoodsManager.instance.fixBagItem(_loc7_,_loc14_,bagType,param1);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

