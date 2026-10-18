package yishi.view.frame
{
   import com.pickgliss.loader.LoaderSavingManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class CacheTipFrame extends Frame
   {
      
      private var _tipImg:MovieClip;
      
      private var _backView:Shape;
      
      private var _timer:Timer;
      
      public function CacheTipFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _tipImg = ComponentFactory.Instance.creatCustomObject("asset.loading.CacheMcAsset") as MovieClip;
         _tipImg.x = -1;
         _tipImg.y = -20;
         _backView = new Shape();
         _backView.graphics.beginFill(0,0.4);
         _backView.graphics.drawRect(0,0,1500,900);
         _backView.graphics.endFill();
         addToContent(_tipImg);
      }
      
      private function addEvent() : void
      {
         LoaderSavingManager.eventDispatcher.addEventListener("SharedObject.Flush.Failed",_soCloseHandler);
         LoaderSavingManager.eventDispatcher.addEventListener("SharedObject.Flush.Success",_soCloseHandler);
      }
      
      private function removeEvent() : void
      {
         LoaderSavingManager.eventDispatcher.removeEventListener("SharedObject.Flush.Failed",_soCloseHandler);
         LoaderSavingManager.eventDispatcher.removeEventListener("SharedObject.Flush.Success",_soCloseHandler);
      }
      
      private function _soCloseHandler(param1:Event) : void
      {
         dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(_backView,2,true,true);
         LayerManager.Instance.addToLayer(this,1,true,true);
         clearTime();
         _timer = new Timer(10000);
         _timer.addEventListener("timer",__timerHandler);
         _timer.start();
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         if(_timer)
         {
            _timer.reset();
         }
         LoaderSavingManager.checkCloseShardObject();
      }
      
      private function clearTime() : void
      {
         if(_timer)
         {
            _timer.removeEventListener("timer",__timerHandler);
            _timer.stop();
         }
         _timer = null;
      }
      
      override public function dispose() : void
      {
         clearTime();
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _tipImg = null;
         if(_backView)
         {
            _backView.graphics.clear();
            if(_backView.parent)
            {
               _backView.parent.removeChild(_backView);
            }
         }
         _backView = null;
         super.dispose();
      }
   }
}

