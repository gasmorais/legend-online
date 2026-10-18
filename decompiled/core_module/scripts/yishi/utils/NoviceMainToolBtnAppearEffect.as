package yishi.utils
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class NoviceMainToolBtnAppearEffect
   {
      
      private var _content:DisplayObject;
      
      private var _effectMc:MovieClip;
      
      private var _completeHandler:Function;
      
      private var parm:Object;
      
      public function NoviceMainToolBtnAppearEffect(param1:DisplayObject, param2:Function, param3:Object = null)
      {
         super();
         parm = param3;
         _content = param1;
         _completeHandler = param2;
      }
      
      public function play() : MovieClip
      {
         removeEnterFrame();
         if(!_effectMc)
         {
            _effectMc = ComponentFactory.Instance.creatCustomObject("core.toolBtnAppearEffectMC");
            _effectMc.container.addChild(_content);
         }
         _effectMc.addEventListener("enterFrame",onEnterFrame);
         return _effectMc;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(_effectMc.currentFrame == _effectMc.totalFrames)
         {
            removeEnterFrame();
            _completeHandler(parm);
         }
      }
      
      private function removeEnterFrame() : void
      {
         if(_effectMc && _effectMc.hasEventListener("enterFrame"))
         {
            _effectMc.removeEventListener("enterFrame",onEnterFrame);
         }
      }
      
      public function dispose() : void
      {
         removeEnterFrame();
         if(_effectMc && _effectMc.parent)
         {
            _effectMc.parent.removeChild(_effectMc);
         }
         _effectMc = null;
         _content = null;
      }
   }
}

