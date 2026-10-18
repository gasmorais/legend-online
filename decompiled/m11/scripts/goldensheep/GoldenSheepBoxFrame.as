package goldensheep
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import events.GoldenSheepEvent;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.setTimeout;
   import mvc.module.goldensheep.GoldenSheepModel;
   import yishi.datas.ComponentGroupType;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoldenSheepManager;
   import yishi.view.tools.QuickenMovieClip;
   
   public class GoldenSheepBoxFrame extends Frame implements IManualSize
   {
      
      private var _boxMC:MovieClip;
      
      private var _boxEffectMC:MovieClip;
      
      private var _boxEffectView:QuickenMovieClip;
      
      private var _model:GoldenSheepModel = GoldenSheepManager.instance.model;
      
      public function GoldenSheepBoxFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,680,290);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _boxMC = ComponentFactory.Instance.creatCustomObject("goldensheep.GoldenSheepBoxFrame.boxMC");
         _boxEffectMC = ComponentFactory.Instance.creatCustomObject("goldensheep.GoldenSheepBoxFrame.boxEffectMC");
         _boxEffectView = new QuickenMovieClip(_boxEffectMC);
         _boxMC.buttonMode = true;
         _boxEffectView.gotoAndStop(1);
         _boxEffectView.addFrameScript(_boxEffectView.totalFrames - 1,boxEffectViewPlayComplete);
         _boxEffectView.visible = false;
         addChild(_boxMC);
         addChild(_boxEffectView);
      }
      
      private function boxEffectViewPlayComplete() : void
      {
         _boxEffectView.gotoAndStop(1);
         _boxEffectView.visible = false;
         FrameControllerManager.instance.openControllerByInfo("goldensheep");
         setTimeout(delayComplete,100);
      }
      
      private function delayComplete() : void
      {
         dispose();
      }
      
      private function showResult() : void
      {
         _boxEffectView.visible = true;
         _boxEffectView.gotoAndPlay(1);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeViolentMc(_boxMC);
         _boxMC = null;
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
         _boxMC.addEventListener("click",__boxMCClickHandler);
         _model.addEventListener("STATE_UPDATE",__stateUpdateHandler);
         _model.addEventListener("ANIMATION_UPDATE",__animationUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _boxMC.removeEventListener("click",__boxMCClickHandler);
         _model.removeEventListener("STATE_UPDATE",__stateUpdateHandler);
         _model.removeEventListener("ANIMATION_UPDATE",__animationUpdateHandler);
      }
      
      private function __animationUpdateHandler(param1:GoldenSheepEvent) : void
      {
         showResult();
      }
      
      private function __stateUpdateHandler(param1:GoldenSheepEvent) : void
      {
         if(!_model.needShow)
         {
            dispose();
         }
      }
      
      private function __boxMCClickHandler(param1:MouseEvent) : void
      {
         GoldenSheepManager.instance.openBox();
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
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
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

