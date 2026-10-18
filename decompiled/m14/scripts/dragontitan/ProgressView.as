package dragontitan
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ProgressView extends Component
   {
      
      private var _progressBg:Bitmap;
      
      private var _progress:Bitmap;
      
      private var _mask:Sprite;
      
      private var _progressNum:FilterFrameText;
      
      public function ProgressView()
      {
         super();
         initView();
         initEvent();
      }
      
      public function initView() : void
      {
         _progressBg = ComponentFactory.Instance.creatBitmap("asset.dragontitan.progressBg");
         _progress = ComponentFactory.Instance.creatBitmap("asset.dragontitan.progress");
         _progressNum = ComponentFactory.Instance.creatComponentByStylename("ProgressView.progressNum");
         _mask = new Sprite();
         addChild(_progressBg);
         _progress.x = 13;
         _progress.y = 8;
         addChild(_progress);
         addChild(_mask);
         creatMask(400,1000);
         _progress.mask = _mask;
         _progressNum.text = "0/10";
         addChild(_progressNum);
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
            _mask.graphics.drawRect(_progress.x,_progress.y,param1 * 222 / param2,25);
            _mask.graphics.endFill();
         }
         _progressNum.text = param1 + "/" + param2;
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseOver",__mouseOverHandler);
         addEventListener("mouseOut",__mouseOutHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__mouseOverHandler);
         removeEventListener("mouseOut",__mouseOutHandler);
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_progressBg);
         _progressBg = null;
         ObjectUtils.disposeObject(_progress);
         _progress = null;
         ObjectUtils.disposeObject(_mask);
         _mask = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

