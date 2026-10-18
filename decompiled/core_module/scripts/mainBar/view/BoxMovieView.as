package mainBar.view
{
   import com.greensock.TweenMax;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   
   public class BoxMovieView extends Sprite implements Disposeable
   {
      
      private var _downBox:Sprite;
      
      private var _waiteBox:MovieImage;
      
      private var _time:Timer;
      
      public function BoxMovieView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _downBox = ComponentFactory.Instance.creatCustomObject("box.downBoxSprite");
         var _loc1_:Image = ComponentFactory.Instance.creatComponentByStylename("box.DownBoxImg");
         _waiteBox = ComponentFactory.Instance.creatComponentByStylename("box.waiteBox");
         _downBox.addChild(_loc1_);
         _downBox.x = StageReferance.stageWidth / 2;
         addChild(_downBox);
      }
      
      private function gotoDown() : void
      {
         var _loc1_:Point = new Point(StageReferance.stageWidth / 2,StageReferance.stageHeight / 2);
         TweenMax.to(_downBox,0.2,{
            "y":_loc1_.y,
            "onComplete":downComplete
         });
      }
      
      private function downComplete() : void
      {
         if(_downBox && _downBox.parent)
         {
            _downBox.parent.removeChild(_downBox);
         }
         _downBox = null;
         if(_waiteBox)
         {
            _waiteBox.x = StageReferance.stageWidth / 2;
            _waiteBox.y = StageReferance.stageHeight / 2;
            addChild(_waiteBox);
            _waiteBox.movie.gotoAndPlay(1);
            _waiteBox.addEventListener("click",__boxClick);
         }
      }
      
      private function __boxClick(param1:MouseEvent) : void
      {
         _waiteBox.removeEventListener("click",__boxClick);
         FrameControllerManager.instance.openControllerByInfo("box");
         ObjectUtils.disposeObject(this);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,false,false,1);
         KeyBoardRegister.instance.keyEnable = false;
         gotoDown();
      }
      
      public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         if(_downBox)
         {
            ObjectUtils.disposeObject(_downBox);
         }
         _downBox = null;
         if(_waiteBox)
         {
            ObjectUtils.disposeObject(_waiteBox);
         }
         _waiteBox = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

