package yishi.view.tools
{
   import battle.BattleManager;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StringUtils;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   
   public class QuickenMovieClip extends Sprite implements IEnterFrame
   {
      
      protected var _mc:MovieClip;
      
      private var _currentFrame:int = 1;
      
      private var _totalFrames:int;
      
      private var _playing:Boolean = true;
      
      private var _scripts:Dictionary;
      
      public var step:int = 1;
      
      public function QuickenMovieClip(param1:MovieClip, param2:Boolean = true)
      {
         _mc = param1;
         _totalFrames = _mc.totalFrames;
         if(_totalFrames <= 1)
         {
            _totalFrames = 2;
         }
         _mc.gotoAndStop(1);
         if(param2)
         {
            addChild(_mc);
         }
         _scripts = new Dictionary(true);
         EnterFrameManager.instance.registeEnterFrame(this);
         play();
         super();
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
         showFrame(getFrameIndex(param1));
         _playing = true;
      }
      
      public function gotoAndStop(param1:Object) : void
      {
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
         var _loc1_:int = 0;
         if(_playing)
         {
            _loc1_ = _currentFrame;
            _currentFrame += step;
            if(_currentFrame > _totalFrames)
            {
               _currentFrame = _totalFrames;
            }
            gotoFrame(_currentFrame);
            while(_loc1_ < _currentFrame)
            {
               _loc1_++;
               executeFrameFunction(_loc1_);
            }
         }
      }
      
      private function showFrame(param1:int) : void
      {
         gotoFrame(param1);
         executeFrameFunction(param1);
      }
      
      private function gotoFrame(param1:int) : void
      {
         _currentFrame = param1;
         if(param1 > _mc.totalFrames)
         {
            param1 = _mc.totalFrames;
         }
         _mc.gotoAndStop(param1);
      }
      
      private function executeFrameFunction(param1:int) : void
      {
         if(!_scripts)
         {
            return;
         }
         var _loc2_:Object = _scripts[param1 - 1];
         if(_loc2_ is Function)
         {
            _loc2_();
         }
         else if(_loc2_ is Array)
         {
            for each(var _loc3_:Function in _loc2_)
            {
               _loc3_();
            }
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
            while(_loc3_ < _mc.currentLabels.length)
            {
               _loc4_ = _mc.currentLabels[_loc3_];
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
         if(param2 == null)
         {
            delete _scripts[param1];
            return;
         }
         if(param1 >= _totalFrames)
         {
            param1 = _totalFrames - 1;
         }
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(_scripts[param1] == null)
         {
            _scripts[param1] = param2;
         }
         else if(_scripts[param1] is Array)
         {
            _scripts[param1].push(param2);
         }
         else
         {
            _scripts[param1] = [_scripts[param1],param2];
         }
         if(param1 <= 0)
         {
            param2();
         }
      }
      
      public function getMC() : MovieClip
      {
         return _mc;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         if(_mc && BattleManager.getInstance().resourceModel)
         {
            BattleManager.getInstance().resourceModel.recyleInstanse(_mc);
         }
         for each(var _loc1_:String in _scripts)
         {
            _scripts[_loc1_] = null;
            delete _scripts[_loc1_];
         }
         _scripts = null;
         _mc = null;
         EnterFrameManager.instance.unRegisteEnterFrame(this);
      }
   }
}

