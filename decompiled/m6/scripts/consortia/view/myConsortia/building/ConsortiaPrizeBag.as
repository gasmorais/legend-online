package consortia.view.myConsortia.building
{
   import bag.events.BagEvent;
   import bag.view.BaseBagListView;
   import cell.view.consortiabag.ConsortiaPrizeCell;
   import com.pickgliss.ui.ComponentFactory;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.ViewTempDataManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BaseItemView;
   
   public class ConsortiaPrizeBag extends BaseBagListView
   {
      
      private var _cModel:ConsortiaModel;
      
      public function ConsortiaPrizeBag(param1:int = 7, param2:int = 9, param3:int = 1)
      {
         bagType = 8;
         super(param1,param2,param3);
      }
      
      override public function get itemList() : Vector.<BaseItemView>
      {
         return _itemList;
      }
      
      override public function refreshData() : void
      {
         var _loc2_:GoodsInfo = null;
         var _loc3_:SimpleDictionary = new SimpleDictionary(true);
         for(var _loc1_:String in ConsortiaManager.instance.model.prizeList)
         {
            _loc3_.add(_loc1_,ConsortiaManager.instance.model.prizeList[_loc1_]);
         }
         if(_loc3_.keys.length == 0)
         {
            _loc2_ = new GoodsInfo();
            _loc2_.templateId = 2060044;
            _loc2_.count = 0;
            _loc2_.bagType = 8;
            _loc2_.pos = 0;
            _loc3_.add(_loc2_.pos,_loc2_);
         }
         _data = _loc3_;
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
      
      override protected function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         var _loc2_:BaseItemView = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_)
         {
            _loc2_.data = _loc3_;
         }
      }
      
      override protected function creatItem(param1:Boolean = false, param2:int = -1) : BaseItemView
      {
         var _loc3_:BaseItemView = ComponentFactory.Instance.creatCustomObject("consortia.ConsortiaPrizeCell");
         _loc3_.bagType = bagType;
         _loc3_.objectId = 0;
         return _loc3_;
      }
      
      override protected function init(param1:int, param2:int) : void
      {
         var _loc4_:* = 0;
         var _loc3_:ConsortiaPrizeCell = null;
         _cModel = FrameControllerManager.instance.consortiaController.model;
         _itemCount = param1 * param2;
         _itemList = new Vector.<BaseItemView>();
         _itemDic = new SimpleDictionary();
         _list = ComponentFactory.Instance.creatCustomObject("consortia.SimpleTileList",[param1]);
         addChild(_list);
         _list.beginChanges();
         _loc4_ = 0;
         while(_loc4_ < _itemCount)
         {
            _loc3_ = ConsortiaPrizeCell(creatItem());
            _list.addChild(_loc3_);
            _itemList.push(_loc3_);
            _loc4_++;
         }
         _list.commitChanges();
      }
      
      override protected function uninit() : void
      {
         ViewTempDataManager.getInstance().castleViewdata.heroUIViewData.curBagType = -1;
         _cModel = null;
         super.uninit();
      }
   }
}

