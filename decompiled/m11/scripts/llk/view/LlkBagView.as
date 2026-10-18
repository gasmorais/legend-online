package llk.view
{
   import bag.events.BagEvent;
   import cell.view.gemmazebag.GemMazeBagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.Sprite;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.GoodsManager;
   
   public class LlkBagView extends Sprite implements Disposeable
   {
      
      private var _panel:ScrollPanel;
      
      private var _hBox:HBox;
      
      private var _itemList:Vector.<GemMazeBagCell>;
      
      private var _maxCount:int = 30;
      
      public function LlkBagView()
      {
         super();
         initView();
         addNullItems();
         refreshBag();
         initEvent();
      }
      
      private function initView() : void
      {
         _panel = ComponentFactory.Instance.creatComponentByStylename("LlkBagView.panel");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("LlkBagView.HBox");
         _itemList = new Vector.<GemMazeBagCell>();
         _panel.setView(_hBox);
         addChild(_panel);
      }
      
      private function addNullItems() : void
      {
         var _loc2_:int = 0;
         var _loc1_:GemMazeBagCell = null;
         _loc2_ = 0;
         while(_loc2_ < _maxCount)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("LlkBagItem.BagCell");
            _loc1_.pos = _loc2_;
            _loc1_.bagType = 27;
            _loc1_.lock = false;
            _loc1_.data = null;
            _hBox.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
         _panel.invalidateViewport();
      }
      
      private function refreshBag() : void
      {
         var _loc3_:int = 0;
         var _loc2_:GemMazeBagCell = null;
         var _loc1_:Array = goodsList;
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            if(!(_loc1_[_loc3_].pos >= _maxCount || _loc1_[_loc3_].pos < 0))
            {
               _loc2_ = _itemList[_loc1_[_loc3_].pos];
               if(_loc2_)
               {
                  _loc2_.data = _loc1_[_loc3_];
               }
            }
            _loc3_++;
         }
      }
      
      public function tidy() : void
      {
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:Array = goodsList;
         var _loc3_:Array = [];
         var _loc4_:Array = [];
         var _loc2_:Array = [];
         _loc2_ = _loc2_.concat(_loc1_);
         _loc2_.sort(sortFun);
         var _loc6_:Boolean = false;
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc7_ = int(GoodsInfo(_loc2_[_loc5_]).pos);
            if(_loc7_ != _loc5_)
            {
               _loc6_ = true;
            }
            _loc3_.push(_loc7_);
            _loc4_.push(_loc5_);
            _loc5_++;
         }
         if(_loc6_)
         {
            GoodsManager.instance.fixBagItem(_loc3_,_loc4_,27,true);
         }
      }
      
      private function sortFun(param1:GoodsInfo, param2:GoodsInfo) : Number
      {
         var _loc3_:int = int(param1.templateInfo.SonType);
         var _loc4_:int = int(param2.templateInfo.SonType);
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         if(param1.templateId < param2.templateId)
         {
            return 1;
         }
         if(param1.templateId > param2.templateId)
         {
            return -1;
         }
         if(param1.strengthenGrade < param2.strengthenGrade)
         {
            return 1;
         }
         if(param1.strengthenGrade > param2.strengthenGrade)
         {
            return -1;
         }
         if(!param1.isBinds && Boolean(param2.isBinds))
         {
            return -1;
         }
         if(param1.isBinds && !param2.isBinds)
         {
            return 1;
         }
         return 0;
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
      
      private function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc2_:GemMazeBagCell = null;
         var _loc3_:GoodsInfo = param1.info;
         if(_loc3_)
         {
            if(_loc3_.bagType != 27 || _loc3_.pos >= _maxCount || _loc3_.pos < 0)
            {
               return;
            }
            _loc2_ = _itemList[_loc3_.pos];
            if(_loc2_)
            {
               _loc2_.data = _loc3_;
            }
         }
      }
      
      private function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         var _loc2_:GemMazeBagCell = null;
         var _loc3_:GoodsInfo = param1.info;
         if(_loc3_)
         {
            if(_loc3_.bagType != 27 || _loc3_.pos >= _maxCount || _loc3_.pos < 0)
            {
               return;
            }
            _loc2_ = _itemList[_loc3_.pos];
            if(_loc2_)
            {
               _loc2_.data = null;
            }
         }
      }
      
      private function get goodsList() : Array
      {
         return GoodsManager.instance.getGoodsByBagType(27);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_itemList)
         {
            while(_itemList.length > 0)
            {
               _itemList.pop().dispose();
            }
            _itemList = null;
         }
         if(_hBox)
         {
            _hBox.dispose();
         }
         _hBox = null;
         if(_panel)
         {
            _panel.dispose();
         }
         _panel = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

