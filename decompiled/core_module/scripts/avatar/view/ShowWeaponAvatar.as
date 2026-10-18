package avatar.view
{
   import avatar.load.ShowAvatarLoader;
   import com.greensock.TweenMax;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.NotificationManager;
   
   public class ShowWeaponAvatar extends ShowAvatarLoader
   {
      
      private var showEffect:Boolean;
      
      public function ShowWeaponAvatar(param1:Function)
      {
         super(param1);
         stop();
         initEvent();
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("WEAPON_CHANGE",__infoUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("WEAPON_CHANGE",__infoUpdateHandler);
      }
      
      private function __infoUpdateHandler(param1:NotificationEvent) : void
      {
         showEffect = true;
      }
      
      override protected function initContain() : void
      {
         _contain = ComponentFactory.Instance.creatCustomObject("core.ShowAvatarEffect");
         addChild(_contain);
      }
      
      override protected function __iconLoadComplete(param1:LoaderInfo, param2:Object) : void
      {
         if(_path != param1.args || !_contain)
         {
            return;
         }
         clean();
         removeChilder(_contain["contain"]);
         if(param2 is MovieClip)
         {
            _view = param2 as MovieClip;
            _contain["contain"].addChild(_view);
            _contain.gotoAndStop(1);
            if(_loadComplete != null)
            {
               _loadComplete();
            }
         }
         if(showEffect)
         {
            _contain.gotoAndPlay(1);
            showEffect = false;
            play();
         }
         stop();
      }
      
      private function removeChilder(param1:Sprite) : void
      {
         while(param1.numChildren > 0)
         {
            param1.removeChildAt(0);
         }
      }
      
      private function play() : void
      {
         TweenMax.to(_contain,0.5,{
            "dropShadowFilter":{
               "angle":45,
               "blurX":5,
               "blurY":5,
               "strength":5,
               "quality":2,
               "distance":5,
               "color":16777215
            },
            "glowFilter":{
               "color":13369344,
               "blurX":18,
               "blurY":18,
               "strength":0.8,
               "quality":1
            },
            "glowFilter":{
               "color":16777215,
               "blurX":18,
               "blurY":18,
               "strength":10,
               "quality":2
            },
            "colorMatrixFilter":{
               "contrast":1,
               "brightness":2.2,
               "saturation":1,
               "hue":0
            },
            "onComplete":onFlowComplete
         });
      }
      
      private function onFlowComplete() : void
      {
         TweenMax.to(_contain,0.4,{
            "dropShadowFilter":{
               "angle":45,
               "blurX":6,
               "blurY":6,
               "strength":0.1,
               "quality":1,
               "distance":0,
               "color":16777215
            },
            "glowFilter":{
               "color":6803736,
               "alpha":1,
               "blurX":15,
               "blurY":15,
               "strength":0.1,
               "quality":1
            },
            "colorMatrixFilter":{
               "contrast":1,
               "brightness":1,
               "saturation":1,
               "hue":0
            },
            "onComplete":stop,
            "delay":0.3
         });
      }
      
      private function stop() : void
      {
         if(!_contain)
         {
            return;
         }
         TweenMax.killTweensOf(_contain);
         _contain.filters = null;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _contain && TweenMax.killTweensOf(_contain);
         super.dispose();
      }
   }
}

