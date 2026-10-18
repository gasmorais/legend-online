package lordtrial
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class LordTrialRightVBoxItem extends Sprite implements Disposeable
   {
      
      private var _bufferTypeImg:ScaleFrameImage;
      
      private var _bufferDescTxt:FilterFrameText;
      
      public function LordTrialRightVBoxItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bufferTypeImg = ComponentFactory.Instance.creatComponentByStylename("rightView.vboxTypeImg");
         _bufferDescTxt = ComponentFactory.Instance.creatComponentByStylename("rightView.vboxDescTxt");
         addChild(_bufferTypeImg);
         addChild(_bufferDescTxt);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_bufferTypeImg);
         _bufferTypeImg = null;
         ObjectUtils.disposeObject(_bufferDescTxt);
         _bufferDescTxt = null;
      }
      
      public function setTypeImg(param1:int = 1) : void
      {
         _bufferTypeImg.setFrame(param1);
      }
      
      public function setDesc(param1:String) : void
      {
         _bufferDescTxt.text = param1;
         _bufferDescTxt.height = _bufferDescTxt.textHeight + 5;
      }
      
      public function dispose() : void
      {
         uninitView();
      }
   }
}

