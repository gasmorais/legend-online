package yishi.utils
{
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Graphics;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import map.internals.interfaces.IBaseMouseEvent;
   import ui.events.UIBarEvent;
   import yishi.keyboard.KeyBoardRegister;
   
   public class MaskUtils extends Sprite implements Disposeable
   {
      
      private static var _instance:MaskUtils;
      
      private var _mask:Sprite;
      
      private var _buffer:Dictionary = new Dictionary(true);
      
      private var _bufferMovie:Dictionary = new Dictionary(true);
      
      private var _bufferTime:Dictionary = new Dictionary(true);
      
      private var _drawBtn:Sprite;
      
      private var _container:Sprite;
      
      private var _drawTarget:DisplayObject;
      
      private var _eventTarget:InteractiveObject;
      
      public function MaskUtils()
      {
         super();
         blendMode = "layer";
         LayerManager.Instance.addToLayer(this,2);
         StageReferance.stage.addEventListener("enterFrame",__loop);
      }
      
      public static function get instance() : MaskUtils
      {
         if(!_instance)
         {
            _instance = new MaskUtils();
         }
         return _instance;
      }
      
      protected function __loop(param1:Event = null) : void
      {
         updateShowMovie();
         if(_drawTarget && _drawTarget.parent && _drawTarget.parent.stage)
         {
            updateDisplay();
         }
      }
      
      public function maskShow(param1:Number = 0.6) : void
      {
         var _loc2_:Graphics = null;
         KeyBoardRegister.instance.keyEnable = false;
         if(_mask != null && _mask.alpha != param1)
         {
            maskHide();
         }
         if(_mask == null)
         {
            _mask = new Sprite();
            _loc2_ = _mask.graphics;
            _loc2_.beginFill(0,param1);
            _loc2_.drawRect(-500,-200,2000,1600);
            _loc2_.endFill();
            addChildAt(_mask,0);
         }
      }
      
      public function maskHide() : void
      {
         if(_mask)
         {
            _mask.graphics.clear();
            removeChild(_mask);
            _mask = null;
         }
      }
      
      public function addShowMovie(param1:DisplayObject, param2:Function = null) : void
      {
         var glowMc:MovieClip;
         var bitampD:BitmapData;
         var bitmap:Bitmap;
         var appearEffect:Object;
         var $dis:DisplayObject = param1;
         var $complete:Function = param2;
         var delayForAppear:* = function(param1:Object):void
         {
            if(_bufferTime[param1] > 0)
            {
               clearTimeout(_bufferTime[param1]);
            }
            _bufferTime[param1] = 0;
            if(_bufferMovie[$dis])
            {
               _bufferMovie[$dis].addChild(appearEffect["play"]());
            }
         };
         var twComplete:* = function(param1:Array):void
         {
            appearEffect["dispose"]();
            if(param1[0])
            {
               param1[0].visible = true;
            }
            if(_buffer[param1[0]] != null)
            {
               _buffer[param1[0]]();
            }
            removeShowMovie(param1[0]);
         };
         _buffer[$dis] = $complete;
         $dis.visible = false;
         _bufferMovie[$dis] = new Sprite();
         addChild(_bufferMovie[$dis]);
         glowMc = ComponentFactory.Instance.creatCustomObject("core.BtnGlowMc");
         glowMc.mouseEnabled = glowMc.mouseChildren = false;
         glowMc.scaleX = glowMc.scaleY = 1.5;
         glowMc.x = -20;
         glowMc.y = -20;
         _bufferMovie[$dis].addChild(glowMc);
         bitampD = new BitmapData($dis.width,$dis.height,true,0);
         bitampD.draw($dis);
         bitmap = new Bitmap(bitampD,"auto",true);
         appearEffect = new NoviceMainToolBtnAppearEffect(bitmap,twComplete,[$dis]);
         _bufferTime[$dis] = setTimeout(delayForAppear,150,$dis);
         dispatchEvent(new UIBarEvent("BUTTON_ADDED",$dis));
      }
      
      private function get NoviceMainToolBtnAppearEffect() : *
      {
         return DisplayLoader.Context.applicationDomain.getDefinition("yishi.utils.NoviceMainToolBtnAppearEffect");
      }
      
      public function updateShowMovie() : void
      {
         var _loc1_:Point = null;
         for(var _loc2_ in _buffer)
         {
            if(_bufferMovie[_loc2_])
            {
               if(_loc2_.parent)
               {
                  _loc1_ = _loc2_.parent.localToGlobal(new Point(_loc2_.x,_loc2_.y));
                  _bufferMovie[_loc2_].x = _loc1_.x;
                  _bufferMovie[_loc2_].y = _loc1_.y;
               }
            }
         }
      }
      
      public function removeShowMovie(param1:Object) : void
      {
         if(_bufferMovie[param1])
         {
            while(_bufferMovie[param1].numChildren > 0)
            {
               _bufferMovie[param1].removeChildAt(0);
            }
            removeChild(_bufferMovie[param1]);
            delete _buffer[param1];
            delete _bufferMovie[param1];
         }
      }
      
      public function drawTarget(param1:DisplayObject, param2:InteractiveObject) : void
      {
         if(!param1 || _drawTarget == param1)
         {
            return;
         }
         removeTargetEvent();
         removeDisplayList();
         _drawTarget = param1;
         _container = new Sprite();
         addChild(_container);
         if(param2)
         {
            _eventTarget = param2;
         }
         addToSp();
         updateDisplay();
      }
      
      private function addToSp() : void
      {
         var _loc4_:Number = NaN;
         var _loc2_:Number = NaN;
         if(_drawTarget is Component)
         {
            _loc4_ = (_drawTarget as Component).displayHeight;
            _loc2_ = (_drawTarget as Component).displayWidth;
         }
         else
         {
            _loc4_ = _drawTarget.height;
            _loc2_ = _drawTarget.width;
         }
         var _loc1_:BitmapData = new BitmapData(_loc2_,_loc4_,true,16711680);
         _loc1_.draw(_drawTarget);
         var _loc3_:Bitmap = new Bitmap(_loc1_);
         _container.addChild(_loc3_);
         _container.blendMode = "erase";
         _container.scaleX = _drawTarget.parent.scaleX;
         _container.scaleY = _drawTarget.parent.scaleY;
         if(_eventTarget)
         {
            _drawBtn = _container;
            addTargetEvent();
         }
      }
      
      private function updateDisplay() : void
      {
         var _loc1_:Point = null;
         _loc1_ = _drawTarget.parent.localToGlobal(getLeftTopPoint(_drawTarget));
         _loc1_ = _container.parent.globalToLocal(_loc1_);
         _container.x = _loc1_.x;
         _container.y = _loc1_.y;
         _container.scaleX = _drawTarget.parent.scaleX;
         _container.scaleY = _drawTarget.parent.scaleY;
      }
      
      private function getLeftTopPoint(param1:DisplayObject) : Point
      {
         var _loc2_:Rectangle = param1.getBounds(param1.parent);
         return new Point(Math.round(_loc2_.x),Math.round(_loc2_.y));
      }
      
      private function addTargetEvent() : void
      {
         _drawBtn["buttonMode"] = true;
         _drawBtn.addEventListener("rollOver",__bitmapMouseEvent);
         _drawBtn.addEventListener("rollOut",__bitmapMouseEvent);
         _drawBtn.addEventListener("mouseOut",__bitmapMouseEvent);
         _drawBtn.addEventListener("mouseOver",__bitmapMouseEvent);
         _drawBtn.addEventListener("mouseDown",__bitmapMouseEvent);
         _drawBtn.addEventListener("mouseUp",__bitmapMouseEvent);
         _drawBtn.addEventListener("click",__bitmapMouseEvent);
      }
      
      protected function __bitmapMouseEvent(param1:MouseEvent) : void
      {
         if(_eventTarget)
         {
            dispatchAllChildEvent(_eventTarget,param1);
         }
      }
      
      private function dispatchAllChildEvent(param1:DisplayObject, param2:MouseEvent) : void
      {
         var _loc3_:DisplayObjectContainer = null;
         var _loc4_:int = 0;
         if(param1 == null)
         {
            return;
         }
         if(param1 is IBaseMouseEvent)
         {
            if(param2.type == "click")
            {
               (param1 as IBaseMouseEvent).mouseClickHandler(param2);
            }
            if(param1.hasEventListener(param2.type))
            {
               param1.dispatchEvent(param2);
            }
            return;
         }
         if(param1.hasEventListener(param2.type))
         {
            param1.dispatchEvent(param2);
            return;
         }
         if(param1 is DisplayObjectContainer)
         {
            _loc3_ = param1 as DisplayObjectContainer;
            _loc4_ = 0;
            while(_loc4_ < _loc3_.numChildren)
            {
               dispatchAllChildEvent(_loc3_.getChildAt(_loc4_),param2);
               _loc4_++;
            }
         }
      }
      
      public function removeTargetEvent() : void
      {
         if(!_drawBtn)
         {
            return;
         }
         _drawBtn.removeEventListener("rollOver",__bitmapMouseEvent);
         _drawBtn.removeEventListener("rollOut",__bitmapMouseEvent);
         _drawBtn.removeEventListener("mouseOut",__bitmapMouseEvent);
         _drawBtn.removeEventListener("mouseOver",__bitmapMouseEvent);
         _drawBtn.removeEventListener("mouseDown",__bitmapMouseEvent);
         _drawBtn.removeEventListener("mouseUp",__bitmapMouseEvent);
         _drawBtn.removeEventListener("click",__bitmapMouseEvent);
         _drawBtn = null;
      }
      
      private function removeDisplayList() : void
      {
         ObjectUtils.disposeObject(_container);
         _container = null;
         _eventTarget = null;
         _drawTarget = null;
         _drawBtn = null;
      }
      
      public function dispose() : void
      {
         battleDispose();
         KeyBoardRegister.instance.keyEnable = true;
      }
      
      public function battleDispose() : void
      {
         if(_drawBtn)
         {
            _drawBtn.dispatchEvent(new MouseEvent("rollOut"));
         }
         removeTargetEvent();
         maskHide();
         for(var _loc1_:String in _buffer)
         {
            if(_bufferMovie[_loc1_])
            {
               while(_bufferMovie[_loc1_].numChildren > 0)
               {
                  _bufferMovie[_loc1_].removeChildAt(0);
               }
               removeChild(_bufferMovie[_loc1_]);
            }
            delete _buffer[_loc1_];
            delete _bufferMovie[_loc1_];
         }
         removeDisplayList();
         StageReferance.stage.removeEventListener("enterFrame",__loop);
         if(parent)
         {
            parent.removeChild(this);
         }
         if(_instance && _instance.parent)
         {
            _instance.parent.removeChild(_instance);
         }
         _instance = null;
      }
      
      public function get isMask() : Boolean
      {
         if(_mask)
         {
            return true;
         }
         return false;
      }
   }
}

