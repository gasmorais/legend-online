package outyard
{
   import battle.utils.Int64Utils;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.hugehead.HugeHeadOpenTimeMsg;
   import yishi.utils.DateFormatter;
   
   public class OutyardOpeningItem extends Component
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _title:ScaleFrameImage;
      
      private var _openingValueTxt:FilterFrameText;
      
      public function OutyardOpeningItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("outyard.OpeningItemBg");
         _title = ComponentFactory.Instance.creatComponentByStylename("outyard.OpeningItemTitle");
         _openingValueTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardOpeningItem.openingValueTxt");
         addChild(_bg);
         addChild(_title);
         addChild(_openingValueTxt);
      }
      
      public function set index(param1:int) : void
      {
         if(param1 % 2 == 0)
         {
            _bg.setFrame(1);
         }
         else
         {
            _bg.setFrame(2);
         }
         _title.setFrame(param1 + 1);
      }
      
      public function set data(param1:HugeHeadOpenTimeMsg) : void
      {
         if(!param1)
         {
            _openingValueTxt.text = "--   ~   --";
            return;
         }
         var _loc2_:Date = new Date(Int64Utils.int64ToNumber(param1.startTime));
         var _loc3_:Date = new Date(Int64Utils.int64ToNumber(param1.endTime));
         var _loc4_:String = getIntStrAtLength(_loc2_.getHours(),2) + ":" + getIntStrAtLength(_loc2_.getMinutes(),2);
         var _loc5_:String = getIntStrAtLength(_loc3_.getHours(),2) + ":" + getIntStrAtLength(_loc3_.getMinutes(),2);
         _openingValueTxt.text = _loc4_ + " ~ " + _loc5_;
      }
      
      public function getIntStrAtLength(param1:uint, param2:uint) : String
      {
         return DateFormatter.getIntStrAtLength(param1,param2);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_openingValueTxt);
         _openingValueTxt = null;
         super.dispose();
      }
   }
}

