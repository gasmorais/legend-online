package com.map.vehicle.view
{
   import com.map.vehicle.SkillEffectFactory;
   import com.map.vehicle.data.VGlobal;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.media.SoundTransform;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.scene.SceneManager;
   
   public class VehicleSkillMovie extends Sprite implements IEnterFrame, Disposeable
   {
      
      private var _mc:MovieClip;
      
      private var _totalFrame:int = 1;
      
      private var _currentFrame:int = 1;
      
      private var _className:String;
      
      private var _count:int;
      
      private var _curCount:int;
      
      public var type:int = 0;
      
      public function VehicleSkillMovie(param1:String, param2:MovieClip, param3:int = 1)
      {
         super();
         _className = param1;
         _mc = param2;
         _count = param3;
         _mc.gotoAndStop(1);
         if(_mc.hasOwnProperty("type"))
         {
            type = _mc["type"];
         }
         if(stage)
         {
            init();
         }
         else
         {
            addEventListener("addedToStage",__onStage);
         }
         this.mouseChildren = this.mouseEnabled = false;
      }
      
      private function __onStage(param1:Event) : void
      {
         init();
      }
      
      private function init() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
         _mc.gotoAndStop(1);
         _currentFrame = 1;
         _totalFrame = _mc.totalFrames;
         _curCount = 0;
         addChild(_mc);
      }
      
      public function enterFrame() : void
      {
         if(_currentFrame > _totalFrame)
         {
            _curCount = _curCount + 1;
            if(_count > 0 && _curCount >= _count)
            {
               end();
               return;
            }
            _currentFrame = 1;
         }
         _mc.gotoAndStop(_currentFrame);
         _currentFrame = _currentFrame + 1;
      }
      
      public function end() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         if(SceneManager.instance.currentType == "VEHICLE")
         {
            SkillEffectFactory.instance.recycle(_className,this);
         }
         if(parent)
         {
            parent.removeChild(this);
         }
         if(_mc)
         {
            _mc.gotoAndStop(1);
            _totalFrame = _mc.totalFrames;
         }
         _currentFrame = 1;
         _curCount = 0;
         setSoundTransform(VGlobal.volume0);
      }
      
      public function set autoDispose(param1:Boolean) : void
      {
         if(param1)
         {
            _count = 1;
         }
         else
         {
            _count = -1;
         }
      }
      
      public function addMask() : void
      {
      }
      
      public function setSkillWidth(param1:Number) : void
      {
         if(_mc)
         {
            _mc.width = param1;
         }
      }
      
      public function setSoundTransform(param1:SoundTransform) : void
      {
         if(_mc)
         {
            _mc.soundTransform = param1;
         }
         else
         {
            this.soundTransform = param1;
         }
      }
      
      public function dispose() : void
      {
         removeEventListener("addedToStage",__onStage);
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         ObjectUtils.disposeViolentMc(_mc);
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

