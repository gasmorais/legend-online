package finaldefense.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import managers.FinalDefenseManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class FinalDefenseBoxRewardView extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _btn:IconButton;
      
      private var _boxId:int;
      
      private var _itemArr:Array;
      
      public function FinalDefenseBoxRewardView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _itemArr = [];
         _bg = ComponentFactory.Instance.creatBitmap("asset.finaldefense.boxrewardBg");
         _btn = ComponentFactory.Instance.creatComponentByStylename("finaldefens.getRewardBtn");
         addChild(_bg);
         addChild(_btn);
      }
      
      private function addEvent() : void
      {
         _btn.addEventListener("click",onBtnClick);
      }
      
      private function removeEvent() : void
      {
         _btn.removeEventListener("click",onBtnClick);
      }
      
      private function onBtnClick(param1:MouseEvent) : void
      {
         FinalDefenseManager.ins.getBox(_boxId);
      }
      
      public function set boxId(param1:int) : void
      {
         _boxId = param1;
         updateView();
      }
      
      public function updateView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:BaseItemView = null;
         var _loc4_:GoodsInfo = null;
         var _loc1_:Array = FinalDefenseManager.ins.model.dropDict[_boxId];
         if(_loc1_ == null)
         {
            return;
         }
         _loc3_ = 0;
         while(_loc3_ < _itemArr.length)
         {
            if(_itemArr[_loc3_] != null && _itemArr[_loc3_].parent != null)
            {
               _itemArr[_loc3_].parent.removeChild(_itemArr[_loc3_]);
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = _itemArr[_loc3_];
            if(_loc2_ == null)
            {
               _loc2_ = ComponentFactory.Instance.creatCustomObject("finaldefense.exploreRewardView" + _loc3_);
               _itemArr[_loc3_] = _loc2_;
            }
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = _loc1_[_loc3_].tempId;
            _loc4_.count = _loc1_[_loc3_].count;
            _loc2_.data = _loc4_;
            addChild(_loc2_);
            _loc3_++;
         }
      }
      
      override public function get width() : Number
      {
         return _bg.width;
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         if(_itemArr != null)
         {
            _loc1_ = 0;
            while(_loc1_ < _itemArr.length)
            {
               ObjectUtils.disposeObject(_itemArr[_loc1_]);
               _itemArr[_loc1_] = null;
               _loc1_++;
            }
            _itemArr = null;
         }
         super.dispose();
      }
   }
}

