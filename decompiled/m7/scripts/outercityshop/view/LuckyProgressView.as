package outercityshop.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class LuckyProgressView extends Component
   {
      
      private var _progressBgHbox:HBox;
      
      private var _progressHbox:HBox;
      
      private var _luckyBg:Bitmap;
      
      private var _lucky:Bitmap;
      
      private var _mask:Sprite;
      
      public function LuckyProgressView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         _progressBgHbox = ComponentFactory.Instance.creatComponentByStylename("outercityshop.view.progressBgHbox");
         _progressHbox = ComponentFactory.Instance.creatComponentByStylename("outercityshop.view.progressHbox");
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _luckyBg = ComponentFactory.Instance.creatBitmap("asset.outercityshop.luckyBg");
            _lucky = ComponentFactory.Instance.creatBitmap("asset.outercityshop.lucky");
            _progressBgHbox.addChild(_luckyBg);
            _progressHbox.addChild(_lucky);
            _loc1_++;
         }
         _mask = new Sprite();
         addChild(_progressBgHbox);
         addChild(_progressHbox);
         addChild(_mask);
         creatMask(0,10);
         _progressHbox.mask = _mask;
      }
      
      public function creatMask(param1:int, param2:int) : void
      {
         if(param1 > param2)
         {
            param1 = param2;
         }
         if(_mask)
         {
            _mask.graphics.clear();
            _mask.graphics.beginFill(0,0);
            _mask.graphics.drawRect(0,0,param1 * 85 / param2,20);
            _mask.graphics.endFill();
         }
      }
      
      override public function dispose() : void
      {
         _progressBgHbox.removeAllChild();
         _progressHbox.removeAllChild();
         ObjectUtils.disposeObject(_progressBgHbox);
         _progressBgHbox = null;
         ObjectUtils.disposeObject(_progressBgHbox);
         _progressBgHbox = null;
         ObjectUtils.disposeObject(_luckyBg);
         _luckyBg = null;
         ObjectUtils.disposeObject(_lucky);
         _lucky = null;
         ObjectUtils.disposeObject(_mask);
         _mask = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

