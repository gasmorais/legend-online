package stargazing.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   
   public class StarWishBallItem extends Component
   {
      
      private var ballImage:ScaleFrameImage;
      
      private var ballMc:MovieClip;
      
      public function StarWishBallItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         ballImage = ComponentFactory.Instance.creatComponentByStylename("StarWishBallItem.ballImage");
         ballMc = ComponentFactory.Instance.creatCustomObject("StarWishBallItem.ballMc");
         addChild(ballImage);
         addChild(ballMc);
         ballImage.setFrame(1);
         ballMc.gotoAndStop(1);
         ballMc.visible = false;
      }
      
      public function setState(param1:int) : void
      {
         ballImage.setFrame(param1);
      }
      
      public function playBallMc() : void
      {
         ballMc.visible = true;
         ballMc.addFrameScript(ballMc.totalFrames - 1,ballMcEnd);
         ballMc.gotoAndPlay(1);
      }
      
      public function ballMcEnd() : void
      {
         ballMc.gotoAndStop(1);
         ballMc.visible = false;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(ballImage);
         ballImage = null;
         ObjectUtils.disposeViolentMc(ballMc);
         ballMc = null;
         super.dispose();
      }
   }
}

