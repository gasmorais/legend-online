package yishi.scene
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Linear;
   import com.greensock.easing.Quint;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.clearInterval;
   import flash.utils.clearTimeout;
   import flash.utils.setInterval;
   import flash.utils.setTimeout;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.NotificationManager;
   
   public class SceneSwitchAninmation extends Sprite implements IEnterFrame, ISceneSwitchAnimation
   {
      
      private var _callBack:Function;
      
      private var _curScene:BaseSceneView;
      
      private var _nextScene:BaseSceneView;
      
      private var _tempCurrentBitmap:Bitmap;
      
      private var _timeId1:int;
      
      private var _runTween:Boolean;
      
      private var _count:int;
      
      private var _clearTimeId:int = 0;
      
      public function SceneSwitchAninmation(param1:Function)
      {
         _callBack = param1;
         super();
      }
      
      public function set nextScene(param1:BaseSceneView) : void
      {
         _nextScene = param1;
      }
      
      public function set curScene(param1:BaseSceneView) : void
      {
         _curScene = param1;
      }
      
      public function start() : void
      {
         LayerManager.Instance.clearnGameDynamic();
         LayerManager.Instance.clearnStageDynamic();
         LayerManager.Instance.addToLayer(this,2,false,false,2);
         this.graphics.beginFill(0);
         this.graphics.drawRect(-200,-200,StageReferance.stage.stageWidth + 400,StageReferance.stage.stageHeight + 400);
         this.graphics.endFill();
         this.alpha = 0;
         _count = 0;
         _runTween = false;
         _timeId1 = setInterval(tweenImp,1000);
         TweenLite.to(this,0.5,{
            "alpha":1,
            "onComplete":tweenImp,
            "ease":Linear.easeNone
         });
      }
      
      public function enterFrame() : void
      {
      }
      
      private function tweenImp() : void
      {
         TweenLite.killTweensOf(this);
         if(_timeId1 > 0)
         {
            clearInterval(_timeId1);
         }
         _timeId1 = 0;
         if(_runTween)
         {
            return;
         }
         _runTween = true;
         this.alpha = 1;
         NotificationManager.instance.addEventListener("SCENE_SWITCH_CALL",__sceneSwitchCallHandler);
         if(_callBack != null)
         {
            _callBack();
         }
         _callBack = null;
      }
      
      private function __sceneSwitchCallHandler(param1:Event) : void
      {
         upDateNextRend();
         NotificationManager.instance.removeEventListener("SCENE_SWITCH_CALL",__sceneSwitchCallHandler);
      }
      
      public function upDateNextRend() : void
      {
         if(stage)
         {
            stage.invalidate();
            addEventListener("render",__onScreenRend);
         }
      }
      
      private function __onScreenRend(param1:Event) : void
      {
         removeEventListener("render",__onScreenRend);
         _clearTimeId = setTimeout(stop,1200);
         TweenLite.to(this,0.8,{
            "alpha":0,
            "onComplete":stop,
            "ease":Quint.easeOut
         });
      }
      
      public function stop() : void
      {
         if(_clearTimeId > 0)
         {
            clearTimeout(_clearTimeId);
         }
         _clearTimeId = 0;
         this.alpha = 0;
         this.graphics.clear();
         TweenLite.killTweensOf(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         _nextScene = null;
         _curScene = null;
         _callBack = null;
      }
   }
}

