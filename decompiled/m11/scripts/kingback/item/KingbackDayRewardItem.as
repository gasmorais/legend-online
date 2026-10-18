package kingback.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import mvc.module.kingback.KingbackInfo;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class KingbackDayRewardItem extends Sprite
   {
      
      public var _dayRewardBg:Bitmap;
      
      public var _dayRewardTitle:Bitmap;
      
      public var _dayRewardBox:HBox;
      
      public var _xDayTxt:FilterFrameText;
      
      private var _data:KingbackInfo;
      
      private var _items:Array = [];
      
      public function KingbackDayRewardItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _dayRewardBg = ComponentFactory.Instance.creatBitmap("asset.kingback.dayRewardBg");
         _dayRewardTitle = ComponentFactory.Instance.creatBitmap("asset.kingback.dayRewardTitle");
         _dayRewardBox = ComponentFactory.Instance.creatCustomObject("ui.kingback.dayRewardBox");
         _xDayTxt = ComponentFactory.Instance.creatComponentByStylename("ui.kingback.xDayTxt");
         addChild(_dayRewardBg);
         addChild(_dayRewardTitle);
         addChild(_dayRewardBox);
         addChild(_xDayTxt);
      }
      
      private function initData() : void
      {
         var _loc2_:BaseItemView = null;
         var _loc5_:GoodsInfo = null;
         var _loc6_:Array = null;
         var _loc4_:int = 0;
         var _loc3_:Array = _data.tempInfo.getRewardList();
         var _loc1_:int = int(_loc3_ ? _loc3_.length : 0);
         ObjectUtils.removeChildAllChildrenFromStage(_dayRewardBox);
         _dayRewardBox.beginChanges();
         _loc4_ = 0;
         while(_loc4_ < _loc1_)
         {
            _loc6_ = _loc3_[_loc4_];
            _loc5_ = new GoodsInfo();
            _loc5_.templateId = _loc6_[0];
            _loc5_.count = _loc6_[1];
            _loc2_ = _items[_loc4_];
            if(_loc2_ == null)
            {
               _loc2_ = ComponentFactory.Instance.creatCustomObject("ui.kingback.baseItemView");
            }
            _loc2_.data = _loc5_;
            _items[_loc4_] = _loc2_;
            _dayRewardBox.addChild(_loc2_);
            _loc4_++;
         }
         _dayRewardBox.commitChanges();
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_dayRewardBg);
         _dayRewardBg = null;
         ObjectUtils.disposeObject(_dayRewardTitle);
         _dayRewardTitle = null;
         ObjectUtils.disposeObject(_dayRewardBox);
         _dayRewardBox = null;
         ObjectUtils.disposeObject(_xDayTxt);
         _xDayTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         LogicUtils.disposeDisplayCollection(_items);
         _items = null;
         _data = null;
      }
      
      public function set data(param1:KingbackInfo) : void
      {
         _data = param1;
         _xDayTxt.text = "" + _data.tempInfo.Topic;
         initData();
      }
   }
}

