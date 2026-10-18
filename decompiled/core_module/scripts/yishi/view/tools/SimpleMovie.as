package yishi.view.tools
{
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   
   public class SimpleMovie extends Sprite implements IEnterFrame
   {
      
      private var _movie:MovieClip;
      
      private var _count:int;
      
      private var _currentCount:int = 0;
      
      private var _totalFrame:int;
      
      private var _curFrame:int = 1;
      
      private var _speed:int;
      
      private var _callBack:Function;
      
      private var _callBackArgs:Array;
      
      private var _frameFun:Function;
      
      private var _isStop:Boolean;
      
      public function SimpleMovie(param1:MovieClip, param2:Function = null, param3:int = 1, param4:int = 1, param5:Function = null, param6:Array = null)
      {
         _movie = param1;
         _count = param3;
         _speed = param4;
         _movie.gotoAndStop(1);
         _callBack = param2;
         _callBackArgs = param6;
         _frameFun = param5;
         _totalFrame = _movie.totalFrames;
         super();
         this.addChild(param1);
         this.mouseEnabled = false;
         this.mouseChildren = false;
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      public function get movie() : MovieClip
      {
         return _movie;
      }
      
      public function enterFrame() : void
      {
         if(_count == 0 || _isStop)
         {
            return;
         }
         if(_currentCount >= _count)
         {
            dispose();
            return;
         }
         if(_frameFun != null)
         {
            _frameFun();
         }
         if(_curFrame >= _totalFrame)
         {
            dispatchEvent(new Event("ONE_COMPLETE"));
            _currentCount = _currentCount + 1;
            if(_movie)
            {
               _movie.gotoAndStop(_totalFrame);
            }
            _curFrame = 1;
         }
         else
         {
            if(_movie)
            {
               _movie.gotoAndStop(_curFrame);
            }
            _curFrame += _speed;
         }
      }
      
      public function play() : void
      {
         _isStop = false;
      }
      
      public function stop() : void
      {
         _isStop = true;
      }
      
      public function gotoAndPlay(param1:int) : void
      {
         if(param1 <= 0)
         {
            return;
         }
         var _loc2_:int = param1 > _totalFrame ? _totalFrame : param1;
         _curFrame = _loc2_;
      }
      
      public function clearCallBack() : void
      {
         _callBack = null;
      }
      
      public function dispose() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         if(_movie)
         {
            _movie.addFrameScript(_movie.totalFrames,null);
            _movie.addFrameScript(1,null);
            _movie.gotoAndStop(1);
         }
         ObjectUtils.disposeViolentMc(_movie);
         ObjectUtils.disposeAllChildren(this);
         _movie = null;
         if(_callBack != null)
         {
            _callBack.apply(null,_callBackArgs);
         }
         _callBack = null;
         _callBackArgs = null;
         _frameFun = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         dispatchEvent(new Event("complete"));
      }
      
      public function get curFrame() : int
      {
         return _curFrame;
      }
   }
}

