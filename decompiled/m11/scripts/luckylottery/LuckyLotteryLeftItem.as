package luckylottery
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import mvc.module.luckylottery.LuckyLotteryGoodsInfo;
   
   public class LuckyLotteryLeftItem extends Component
   {
      
      private var _bg:Image;
      
      private var _typeScaleFrameImg:ScaleFrameImage;
      
      private var _hbox:HBox;
      
      private var _dataArray:Array;
      
      private var _type:int;
      
      public function LuckyLotteryLeftItem()
      {
         super();
         initView();
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
         _typeScaleFrameImg.setFrame(_type);
      }
      
      public function set dataArray(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:LuckyLotteryGoodsItem = null;
         var _loc4_:int = 0;
         _dataArray = param1;
         if(_hbox)
         {
            _hbox.removeAllChild();
         }
         if(_dataArray)
         {
            _dataArray.sort(sortByIndex);
            _loc3_ = int(_dataArray.length);
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc2_ = new LuckyLotteryGoodsItem();
               _loc2_.data = _dataArray[_loc4_] as LuckyLotteryGoodsInfo;
               _hbox.addChild(_loc2_);
               _loc4_++;
            }
         }
      }
      
      private function sortByIndex(param1:LuckyLotteryGoodsInfo, param2:LuckyLotteryGoodsInfo) : int
      {
         if(param1.index < param2.index)
         {
            return -1;
         }
         if(param1.index == param2.index)
         {
            return 0;
         }
         if(param1.index > param2.index)
         {
            return 1;
         }
         return 0;
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("LuckyLotteryLeftItem.bg");
         _typeScaleFrameImg = ComponentFactory.Instance.creatComponentByStylename("LuckyLotteryLeftItem.typeScaleFrameImg");
         _hbox = ComponentFactory.Instance.creatComponentByStylename("LuckyLotteryLeftItem.hbox");
         addChild(_bg);
         addChild(_typeScaleFrameImg);
         addChild(_hbox);
      }
      
      override public function dispose() : void
      {
         if(_typeScaleFrameImg)
         {
            ObjectUtils.disposeObject(_typeScaleFrameImg);
         }
         _typeScaleFrameImg = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_hbox)
         {
            ObjectUtils.disposeObject(_hbox);
         }
         _hbox = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

