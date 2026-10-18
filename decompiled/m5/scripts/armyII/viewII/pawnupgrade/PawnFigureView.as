package armyII.viewII.pawnupgrade
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.ModuleLoader;
   import com.pickgliss.loader.data.LoaderInfo;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.media.SoundTransform;
   import flash.utils.Timer;
   import yishi.datas.templates.PawnTemplate;
   import yishi.manager.PathManager;
   import yishi.utils.SimpleDictionary;
   
   public class PawnFigureView extends Sprite
   {
      
      private var _data:PawnTemplate;
      
      private var _contain:Sprite;
      
      private var _movie:MovieClip;
      
      private var _labelsDic:SimpleDictionary;
      
      private var _labels:Array;
      
      private var _playArr:Array = ["Stand"];
      
      private var _stopFrame:int = 10;
      
      private var _currentStopFrame:int = 0;
      
      private var _timer:Timer;
      
      private var _currentLabelIndex:int;
      
      public function PawnFigureView()
      {
         super();
         _labelsDic = new SimpleDictionary(true);
         _labels = [];
      }
      
      private function clean() : void
      {
         if(_timer)
         {
            LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__onComplete);
            _timer.stop();
            _timer.removeEventListener("timerComplete",__timeCompleteHandler);
            _timer = null;
         }
         if(_movie)
         {
            _movie.stop();
            if(_movie.parent)
            {
               _movie.parent.removeChild(_movie);
            }
            _movie = null;
         }
      }
      
      public function set data(param1:PawnTemplate) : void
      {
         var _loc2_:String = null;
         if(_data != param1)
         {
            clean();
            _data = param1;
            if(!_data)
            {
               return;
            }
            _loc2_ = PathManager.solveRolePath(_data.Swf);
            LoaderManagerII.instance.load(_loc2_,3,8,__onComplete,null,null,_data.Swf);
         }
      }
      
      private function __onComplete(param1:LoaderInfo, param2:Object) : void
      {
         var _loc4_:FrameLabel = null;
         var _loc7_:int = 0;
         if(param1.args != _data.Swf)
         {
            return;
         }
         var _loc6_:String = PathManager.solveRoleClassPath(_data.Swf);
         var _loc3_:Class = ModuleLoader.getDefinition(_loc6_);
         _movie = new _loc3_() as MovieClip;
         var _loc5_:SoundTransform = new SoundTransform();
         _loc5_.volume = 0;
         _movie.soundTransform = _loc5_;
         _labelsDic.clear();
         _labels = _movie.currentLabels;
         _loc7_ = 0;
         while(_loc7_ < _labels.length)
         {
            if(_loc7_ != 0)
            {
               _loc4_ = _labels[_loc7_ - 1] as FrameLabel;
               _labelsDic.add(_loc4_.name,int(_labels[_loc7_].frame) - _loc4_.frame - 1);
            }
            _loc7_++;
         }
         _currentLabelIndex = 0;
         playerMoive();
         _movie.x = -_movie["pos_leg"].x;
         _movie.y = -_movie["pos_leg"].y;
         addChild(_movie);
      }
      
      private function playerMoive() : void
      {
         if(!_movie)
         {
            return;
         }
         _currentLabelIndex %= _playArr.length;
         var _loc1_:String = _playArr[_currentLabelIndex];
         if(_loc1_ == "Stop" && !_timer)
         {
            _movie.gotoAndStop(getTagFinalFrame(_playArr[_currentLabelIndex - 1]));
            _timer = new Timer(40,1);
            _timer.addEventListener("timerComplete",__timeCompleteHandler);
            _timer.start();
            return;
         }
         _currentLabelIndex = _currentLabelIndex + 1;
         var _loc2_:int = getTagFinalFrame(_loc1_);
         _movie.addFrameScript(_loc2_,playerMoive);
         _movie.gotoAndPlay(_loc1_);
      }
      
      private function __timeCompleteHandler(param1:TimerEvent) : void
      {
         _timer.stop();
         _timer.removeEventListener("timerComplete",__timeCompleteHandler);
         _timer = null;
         _currentLabelIndex = _currentLabelIndex + 1;
         playerMoive();
      }
      
      private function getTagFinalFrame(param1:String) : int
      {
         var _loc3_:FrameLabel = null;
         for each(var _loc4_:FrameLabel in _labels)
         {
            if(_loc4_.name == param1)
            {
               _loc3_ = _loc4_;
            }
         }
         var _loc2_:int = int(_labelsDic[param1]);
         if(_loc3_)
         {
            return _loc3_.frame + _loc2_ - 1;
         }
         return _loc2_;
      }
   }
}

