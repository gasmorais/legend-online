package yishi.view.tools
{
   import com.pickgliss.bitmapEngin.cache.CacheFrame;
   import com.pickgliss.bitmapEngin.creater.BitmapMovieClipDataCreater;
   import com.pickgliss.bitmapEngin.mode.BitmapMovieClipData;
   import com.pickgliss.utils.StringUtils;
   import flash.display.Bitmap;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   
   public class SimpleBitmapMovieClip extends Sprite implements IEnterFrame
   {
      
      private static var _bitmapMovieClips:Vector.<SimpleBitmapMovieClip> = new Vector.<SimpleBitmapMovieClip>();
      
      private static var _dataCache:Dictionary = new Dictionary();
      
      private var _currentFrame:int = 1;
      
      private var _totalFrames:int;
      
      public var data:BitmapMovieClipData;
      
      private var _playing:Boolean = true;
      
      private var _bitmap:Bitmap;
      
      private var _scripts:Dictionary;
      
      private var _autoClear:Boolean;
      
      public function SimpleBitmapMovieClip(param1:MovieClip, param2:String, param3:Boolean = false, param4:Boolean = true)
      {
         super();
         _totalFrames = param1.totalFrames;
         data = createBitmapMovieClipData(param1,param2,param3);
         _autoClear = param4;
         _bitmap = new Bitmap();
         this.addChild(_bitmap);
         _scripts = new Dictionary();
         EnterFrameManager.instance.registeEnterFrame(this);
         _bitmapMovieClips.push(this);
      }
      
      private static function createBitmapMovieClipData(param1:MovieClip, param2:String, param3:Boolean) : BitmapMovieClipData
      {
         var _loc4_:BitmapMovieClipData = _dataCache[param2];
         if(!_loc4_)
         {
            _loc4_ = BitmapMovieClipDataCreater.create(param1,param2,param3);
            _dataCache[param2] = _loc4_;
         }
         return _loc4_;
      }
      
      public static function disposeBitmapMovieClip(param1:String) : void
      {
         var _loc2_:BitmapMovieClipData = _dataCache[param1];
         if(_loc2_)
         {
            delete _dataCache[param1];
            _loc2_.dispose();
         }
      }
      
      public static function disposeAllCache() : void
      {
         var _loc1_:BitmapMovieClipData = null;
         for(var _loc2_:String in _dataCache)
         {
            _loc1_ = _dataCache[_loc2_];
            if(_loc1_)
            {
               delete _dataCache[_loc2_];
               _loc1_.dispose();
               _loc1_ = null;
            }
         }
      }
      
      public function play() : void
      {
         _playing = true;
      }
      
      public function stop() : void
      {
         _playing = false;
      }
      
      public function gotoAndPlay(param1:Object) : void
      {
         if(!data.inited)
         {
            return;
         }
         showFrame(getFrameIndex(param1));
         _playing = true;
      }
      
      public function gotoAndStop(param1:Object) : void
      {
         if(!data.inited)
         {
            return;
         }
         showFrame(getFrameIndex(param1));
         _playing = false;
      }
      
      public function get totalFrames() : int
      {
         return _totalFrames;
      }
      
      public function get currentFrame() : int
      {
         return _currentFrame;
      }
      
      public function enterFrame() : void
      {
         if(!data.inited)
         {
            return;
         }
         if(_playing)
         {
            if(_currentFrame >= _totalFrames)
            {
               _currentFrame = 1;
            }
            else
            {
               _currentFrame = _currentFrame + 1;
            }
            showFrame(_currentFrame);
         }
      }
      
      private function showFrame(param1:int) : void
      {
         var _loc2_:CacheFrame = data.frames[param1 - 1];
         _bitmap.bitmapData = _loc2_.bitmapData;
         _bitmap.x = -_loc2_.registerX;
         _bitmap.y = -_loc2_.registerY;
         var _loc3_:Function = _scripts[param1] as Function;
         if(_loc3_ != null)
         {
            _loc3_();
         }
      }
      
      private function getFrameIndex(param1:*) : int
      {
         var _loc4_:FrameLabel = null;
         var _loc3_:int = 0;
         var _loc2_:int = 1;
         if(StringUtils.isNumeric(param1))
         {
            _loc2_ = param1;
         }
         else
         {
            _loc3_ = 0;
            while(_loc3_ < data.labels.length)
            {
               _loc4_ = data.labels[_loc3_];
               if(_loc4_.name == param1)
               {
                  _loc2_ = _loc4_.frame;
               }
               _loc3_++;
            }
         }
         return _loc2_;
      }
      
      public function addFrameScript(param1:int, param2:Function) : void
      {
         _scripts[param1] = param2;
      }
      
      public function dispose() : void
      {
         var _loc1_:Boolean = false;
         if(!data)
         {
            return;
         }
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         for each(var _loc2_:SimpleBitmapMovieClip in _bitmapMovieClips)
         {
            if(_loc2_.data.id == this.data.id && _loc2_ != this)
            {
               _loc1_ = true;
               break;
            }
         }
         var _loc3_:int = _bitmapMovieClips.indexOf(this);
         if(_loc3_ >= 0)
         {
            _bitmapMovieClips.splice(_loc3_,1);
         }
         if(!_loc1_ && _autoClear)
         {
            delete _dataCache[this.data.id];
            data.dispose();
         }
         data = null;
         if(_bitmap)
         {
            _bitmap.bitmapData = null;
         }
         for(var _loc4_:String in _scripts)
         {
            _scripts[_loc4_] = null;
         }
         _scripts = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

