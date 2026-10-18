package gamehall
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import flash.utils.setTimeout;
   import yishi.datas.ComponentGroupType;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.view.tools.QuickenMovieClip;
   
   public class GameHallEastShopAnimationFrame extends Frame implements IManualSize
   {
      
      private var _boxEffectMC:MovieClip;
      
      private var _boxEffectView:QuickenMovieClip;
      
      public function GameHallEastShopAnimationFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _boxEffectMC = ComponentFactory.Instance.creatCustomObject("gamehall.GameHallEastShopAnimationFrame.boxEffectMC");
         _boxEffectView = new QuickenMovieClip(_boxEffectMC);
         _boxEffectView.gotoAndPlay(1);
         _boxEffectView.addFrameScript(_boxEffectView.totalFrames - 1,boxEffectViewPlayComplete);
         _boxEffectView.visible = true;
         addToContent(_boxEffectView);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeViolentMc(_boxEffectMC);
         _boxEffectMC = null;
         ObjectUtils.disposeObject(_boxEffectView);
         _boxEffectView = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
      }
      
      private function boxEffectViewPlayComplete() : void
      {
         _boxEffectView.gotoAndStop(1);
         _boxEffectView.visible = false;
         setTimeout(delayComplete,100);
         FrameControllerManager.instance.openControllerByInfo("gamehall","EAST_SHOP_RESULT");
      }
      
      private function delayComplete() : void
      {
         dispose();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,494,244);
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}

