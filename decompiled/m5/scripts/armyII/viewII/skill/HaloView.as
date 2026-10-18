package armyII.viewII.skill
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import flash.display.MovieClip;
   
   public class HaloView extends Component
   {
      
      private var _rotateMc:MovieClip;
      
      private var _brightenMc:MovieClip;
      
      public function HaloView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _rotateMc = ComponentFactory.Instance.creat("asset.changeJob.haloRotateMc");
         _brightenMc = ComponentFactory.Instance.creat("asset.changeJob.haloBrightenMc");
         _rotateMc.mouseChildren = _rotateMc.mouseEnabled = false;
         _brightenMc.mouseChildren = _rotateMc.mouseEnabled = false;
         _rotateMc.visible = false;
         _brightenMc.visible = false;
         _rotateMc.gotoAndStop(1);
         _brightenMc.gotoAndStop(1);
         addChild(_rotateMc);
         addChild(_brightenMc);
      }
      
      public function brighten() : void
      {
         _rotateMc.gotoAndStop(1);
         _rotateMc.visible = false;
         _brightenMc.visible = true;
         _brightenMc.gotoAndPlay(1);
      }
      
      public function darken() : void
      {
         _rotateMc.gotoAndStop(1);
         _rotateMc.visible = false;
         _brightenMc.visible = true;
         _brightenMc.gotoAndStop(1);
      }
      
      public function rotate() : void
      {
         _rotateMc.visible = true;
         _rotateMc.gotoAndPlay(1);
         _brightenMc.gotoAndStop(1);
         _brightenMc.visible = false;
      }
      
      private function initEvent() : void
      {
      }
   }
}

