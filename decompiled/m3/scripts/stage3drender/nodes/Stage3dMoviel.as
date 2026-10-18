package stage3drender.nodes
{
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import stage3drender.Global;
   import starling.animation.IAnimatable;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.textures.Texture;
   
   public class Stage3dMoviel extends starling.display.Sprite implements IAnimatable
   {
      
      private var _toRendertar:DisplayObject;
      
      private var _totalFrame:int = 0;
      
      private var _frameTextures:Vector.<Texture>;
      
      private var _key:String;
      
      private var _img:Image;
      
      private var _pos:Point;
      
      private var _preFrame:int = -1;
      
      private var _currentFrame:int = 0;
      
      private var _stepFrame:int = 0;
      
      private var _step:int = 0;
      
      public function Stage3dMoviel()
      {
         super();
      }
      
      public function get frameTextures() : Vector.<Texture>
      {
         return _frameTextures;
      }
      
      override public function dispose() : void
      {
         _frameTextures = null;
         if(_img)
         {
            _img.removeFromParent();
         }
         _toRendertar = null;
         super.dispose();
      }
      
      public function setFrameTextures(param1:Vector.<Texture>, param2:String) : void
      {
         _frameTextures = param1;
         _totalFrame = _frameTextures.length;
         _pos = Global.avatarPartPostion[param2];
         _stepFrame = Global.stage3dMovieStep[param2];
      }
      
      public function setContent(param1:DisplayObject, param2:String) : void
      {
         var _loc4_:Texture = null;
         var _loc5_:BitmapData = null;
         var _loc3_:Rectangle = null;
         var _loc11_:Matrix = null;
         var _loc6_:MovieClip = null;
         var _loc10_:BitmapData = null;
         var _loc8_:int = 0;
         var _loc9_:Object = null;
         _key = param2;
         _toRendertar = param1;
         _frameTextures = Global.avatarTextureDic[_key];
         var _loc7_:flash.display.Sprite = new flash.display.Sprite();
         if(!_frameTextures)
         {
            _frameTextures = new Vector.<Texture>();
            Global.avatarTextureDic[_key] = _frameTextures;
            if(_toRendertar is MovieClip && _toRendertar["numChildren"] == 1)
            {
               _loc6_ = _toRendertar["getChildAt"](0) as MovieClip;
               _loc3_ = _loc6_.getBounds(_loc7_);
               if(!_pos)
               {
                  _pos = new Point(_loc3_.x,_loc3_.y);
                  Global.avatarPartPostion[_key] = _pos;
               }
               _loc6_.x = 0;
               _loc6_.y = 0;
               _loc7_.addChild(_loc6_);
               _totalFrame = _loc6_.totalFrames;
               _loc8_ = 0;
               for(; _loc8_ < _totalFrame; _loc8_++)
               {
                  _loc3_ = _loc6_.getBounds(_loc7_);
                  _loc6_.gotoAndStop(_loc8_);
                  _loc11_ = new Matrix(1,0,0,1,-_loc3_.x,-_loc3_.y);
                  _loc5_ = new BitmapData(_loc6_.width,_loc6_.height,true,0);
                  _loc5_.draw(_loc6_,_loc11_);
                  if(_loc10_)
                  {
                     _loc9_ = _loc10_.compare(_loc5_);
                     if(_loc9_ == 0)
                     {
                        continue;
                     }
                     ObjectUtils.disposeObject(_loc9_);
                  }
                  ObjectUtils.disposeObject(_loc10_);
                  _loc10_ = _loc5_;
                  _loc4_ = Texture.fromBitmapData(_loc5_);
                  _frameTextures.push(_loc4_);
               }
               _stepFrame = _totalFrame / _frameTextures.length;
               _totalFrame = _frameTextures.length;
               ObjectUtils.disposeObject(_loc10_);
            }
            else
            {
               _loc7_.addChild(_toRendertar);
               _loc3_ = _toRendertar.getBounds(_loc7_);
               if(!_pos)
               {
                  _pos = new Point(_loc3_.x,_loc3_.y);
                  Global.avatarPartPostion[_key] = _pos;
               }
               _loc11_ = new Matrix(1,0,0,1,-_loc3_.x,-_loc3_.y);
               _loc5_ = new BitmapData(_loc3_.width,_loc3_.height,true,0);
               _loc5_.draw(_toRendertar,_loc11_);
               _loc4_ = Texture.fromBitmapData(_loc5_);
               _loc5_.dispose();
               _loc5_ = null;
               _frameTextures.push(_loc4_);
               _totalFrame = 1;
               _stepFrame = 1;
            }
            Global.stage3dMovieStep[_key] = _stepFrame;
         }
         else
         {
            _totalFrame = _frameTextures.length;
            _pos = Global.avatarPartPostion[_key];
            _stepFrame = Global.stage3dMovieStep[_key];
         }
         ObjectUtils.disposeViolentMc(_toRendertar as DisplayObjectContainer);
         _toRendertar = null;
      }
      
      public function advanceTime(param1:Number) : void
      {
         _step = _step + 1;
         if(_step % _stepFrame != 0)
         {
            return;
         }
         var _loc2_:Dictionary = Global.avatarPartPostion;
         if(_pos && _frameTextures && _frameTextures[_currentFrame] && _preFrame != _currentFrame)
         {
            if(_img)
            {
               _img.texture = _frameTextures[_currentFrame];
               _img.readjustSize();
            }
            else
            {
               _img = new Image(_frameTextures[_currentFrame]);
               _img.x = _pos.x;
               _img.y = _pos.y;
               addChild(_img);
            }
            _preFrame = _currentFrame;
            _currentFrame = _currentFrame + 1;
            _currentFrame %= _totalFrame;
         }
      }
   }
}

