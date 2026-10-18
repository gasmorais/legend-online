package battle.view.battleresult
{
   import battle.utils.Helpers;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class BaseBattleResultView extends Sprite
   {
      
      protected var mc:MovieClip;
      
      protected var data:Array;
      
      private var _autoCloseTimer:Timer;
      
      private var _disposed:Boolean;
      
      public var autoCloseFun:Function;
      
      private var _hasCallback:Boolean;
      
      public function BaseBattleResultView(param1:MovieClip)
      {
         this.mc = param1;
         super();
         if(param1)
         {
            Helpers.addOneTimeScript(param1,param1.totalFrames - 1,updateStart);
            this.addChild(param1);
         }
      }
      
      public function setData(param1:Array) : void
      {
         this.data = param1;
      }
      
      public function show() : void
      {
         LayerManager.Instance.getLayerByType(3).addChildAt(this,0);
         center();
         addEvent();
      }
      
      private function addEvent() : void
      {
         StageReferance.stage.addEventListener("click",__stageClickHandler,true);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("click",__stageClickHandler,true);
      }
      
      protected function __stageClickHandler(param1:MouseEvent) : void
      {
         StageReferance.stage.removeEventListener("click",__stageClickHandler,true);
         param1.stopPropagation();
         dispose();
      }
      
      private function center() : void
      {
         this.x = (StageReferance.stage.stageWidth - this.width) * 0.5;
         this.y = (StageReferance.stage.stageHeight - this.height) * 0.5;
      }
      
      protected function updateStart() : void
      {
         if(mc)
         {
            mc.gotoAndStop(mc.totalFrames);
            startTimer();
         }
      }
      
      private function startTimer() : void
      {
         _autoCloseTimer = new Timer(1000,1);
         _autoCloseTimer.addEventListener("timerComplete",onTimerComplete);
         _autoCloseTimer.start();
      }
      
      private function onTimerComplete(param1:TimerEvent) : void
      {
         _autoCloseTimer.removeEventListener("timerComplete",onTimerComplete);
         _autoCloseTimer = null;
         tryCallback();
      }
      
      private function tryCallback() : void
      {
         if(autoCloseFun != null && !_hasCallback)
         {
            _hasCallback = true;
            autoCloseFun();
            autoCloseFun = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_autoCloseTimer)
         {
            _autoCloseTimer.removeEventListener("timerComplete",onTimerComplete);
            _autoCloseTimer = null;
         }
         if(this.parent)
         {
            parent.removeChild(this);
         }
         ObjectUtils.cleanFrameScript(mc);
         ObjectUtils.disposeViolentMc(mc);
         if(!_disposed)
         {
            _disposed = true;
            tryCallback();
         }
         mc = null;
         data = null;
      }
   }
}

