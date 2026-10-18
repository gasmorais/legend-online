package yishi.view.tools
{
   import battle.utils.DelayCalling;
   import battle.utils.Helpers;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yzhkof.debug.log;
   
   public class ActionMovie extends Sprite implements IEnterFrame
   {
      
      public static const STOP:String = "STOP";
      
      public static const REPEAT:String = "REPEAT";
      
      public static const GOTO:String = "GOTO";
      
      public static const WAIT_AND_GOTO:String = "WAIT_AND_GOTO";
      
      private var _movie:MovieClip;
      
      private var _labesDic:Dictionary;
      
      private var _currentMaxFrame:int;
      
      private var _currentFrame:int;
      
      private var _defaultAction:String;
      
      public var errorCallBack:Function;
      
      private var _delayCall:DelayCalling;
      
      private var _callBack:Function;
      
      private var _labels:Array;
      
      private var _currentType:String;
      
      public function ActionMovie()
      {
         super();
         _labesDic = new Dictionary(true);
         this.mouseChildren = this.mouseEnabled = false;
         this.scrollRect = null;
      }
      
      public function get currentLabels() : String
      {
         if(_movie)
         {
            return _movie.currentLabel;
         }
         return "";
      }
      
      public function set defaultAction(param1:String) : void
      {
         _defaultAction = param1;
      }
      
      public function set movie(param1:MovieClip) : void
      {
         if(_movie)
         {
            clearFrameScript(_movie);
         }
         _movie = param1;
         initMovie();
      }
      
      private function clearFrameScript(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 1;
         while(_loc2_ <= param1.totalFrames)
         {
            param1.addFrameScript(_loc2_,null);
            _loc2_++;
         }
      }
      
      public function get movie() : MovieClip
      {
         return _movie;
      }
      
      public function stop() : void
      {
         var _loc1_:int = 0;
         if(_movie)
         {
            _loc1_ = 0;
            while(_loc1_ < _movie.numChildren)
            {
               if(_movie.getChildAt(_loc1_) is MovieClip)
               {
                  (_movie.getChildAt(_loc1_) as MovieClip).stop();
               }
               _loc1_++;
            }
         }
      }
      
      public function playe() : void
      {
         var _loc1_:int = 0;
         if(_movie)
         {
            _loc1_ = 0;
            while(_loc1_ < _movie.numChildren)
            {
               if(_movie.getChildAt(_loc1_) is MovieClip)
               {
                  (_movie.getChildAt(_loc1_) as MovieClip).play();
               }
               _loc1_++;
            }
         }
      }
      
      private function initMovie() : void
      {
         var _loc1_:FrameLabel = null;
         var _loc2_:int = 0;
         if(!_movie)
         {
            return;
         }
         addChild(_movie);
         _labels = _movie.currentLabels;
         _loc2_ = 0;
         while(_loc2_ < _labels.length)
         {
            if(_loc2_ != 0)
            {
               _loc1_ = _labels[_loc2_ - 1] as FrameLabel;
               _labesDic[_loc1_.name] = int(_labels[_loc2_].frame) - _loc1_.frame;
            }
            _loc2_++;
         }
         _loc1_ = _labels[_labels.length - 1] as FrameLabel;
         if(_loc1_ == null)
         {
            if(errorCallBack != null)
            {
               errorCallBack();
            }
         }
         if(_loc1_)
         {
            _labesDic[_loc1_.name] = _movie.totalFrames + 1 - _loc1_.frame;
         }
         _loc1_ = null;
         _movie.mouseChildren = _movie.mouseEnabled = false;
      }
      
      public function actionAndPlay(param1:String, param2:String = null, param3:String = null, param4:int = 5, param5:Boolean = false) : void
      {
         var type:String = param1;
         var repeatType:String = param2;
         var nextType:String = param3;
         var waitFrame:int = param4;
         var isStop:Boolean = param5;
         if(_labesDic == null || !_movie)
         {
            return;
         }
         if(_currentType && _currentType != type)
         {
            _movie.addFrameScript(getTagFinalFrame(_currentType) - 1,function():void
            {
            });
         }
         _currentType = type;
         _delayCall && _delayCall.cancel();
         _currentMaxFrame = int(_labesDic[type]);
         _currentFrame = 0;
         EnterFrameManager.instance.registeEnterFrame(this);
         repeatType = repeatType || getDefaultRepeatType(type);
         nextType = nextType || "Stand";
         try
         {
            _movie.gotoAndPlay(type);
            switch(repeatType)
            {
               case "STOP":
                  if(_labesDic[type] <= 1)
                  {
                     _movie.gotoAndStop(type);
                  }
                  else
                  {
                     Helpers.addOneTimeScript(_movie,getTagFinalFrame(type) - 1,function():void
                     {
                        if(_movie)
                        {
                           _movie.stop();
                        }
                     });
                  }
                  break;
               case "WAIT_AND_GOTO":
                  Helpers.addOneTimeScript(_movie,getTagFinalFrame(type) - 1,function():void
                  {
                     if(!_movie)
                     {
                        return;
                     }
                     _movie.stop();
                     _delayCall = Helpers.delayCall(function():void
                     {
                        actionAndPlay(nextType);
                     },waitFrame);
                  });
                  break;
               case "GOTO":
                  Helpers.addOneTimeScript(_movie,getTagFinalFrame(type) - 1,function():void
                  {
                     actionAndPlay(nextType);
                  });
                  break;
               case "REPEAT":
                  if(isStop)
                  {
                     if(_movie)
                     {
                        _movie.gotoAndStop(type);
                     }
                  }
                  else
                  {
                     _movie.addFrameScript(getTagFinalFrame(type) - 1,function():void
                     {
                        actionAndPlay(type,"REPEAT");
                     });
                  }
            }
         }
         catch(error:Error)
         {
            log({},"bofang:" + error.message);
         }
      }
      
      private function getDefaultRepeatType(param1:String) : String
      {
         switch(param1)
         {
            case "Stand":
            case "Walk":
            case "Ready":
               break;
            case "Victory":
            case "Failed":
               return "STOP";
            default:
               return "WAIT_AND_GOTO";
         }
         return "REPEAT";
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
         var _loc2_:int = int(_labesDic[param1]);
         if(_loc3_)
         {
            return _loc3_.frame + _loc2_ - 1;
         }
         return _loc2_;
      }
      
      public function enterFrame() : void
      {
         if(_currentFrame >= _currentMaxFrame)
         {
            if(_callBack != null)
            {
               _callBack(this);
               _callBack = null;
            }
            EnterFrameManager.instance.unRegisteEnterFrame(this);
         }
         _currentFrame = _currentFrame + 1;
      }
      
      public function getTagFrame(param1:String) : int
      {
         return _labesDic[param1] as int;
      }
      
      public function get endPoint() : Point
      {
         var _loc1_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc2_:int = 0;
         if(_movie)
         {
            if(_movie.hasOwnProperty("getPosMovie"))
            {
               _loc1_ = _movie.getPosMovie();
            }
            else
            {
               _loc1_ = _movie;
            }
            if(_loc1_)
            {
               if(_loc1_.pos)
               {
                  return new Point(_loc1_.pos.x,_loc1_.pos.y);
               }
               _loc2_ = 0;
               while(_loc2_ < _loc1_.numChildren)
               {
                  _loc3_ = _loc1_.getChildAt(_loc2_) as MovieClip;
                  if(_loc3_ && _loc3_.numChildren < 1)
                  {
                     return new Point(_loc3_.x,_loc3_.y);
                  }
                  _loc2_++;
               }
            }
         }
         return null;
      }
      
      public function getLabelFrameNum(param1:String) : int
      {
         return int(_labesDic[param1]);
      }
      
      public function dispose() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         if(_delayCall)
         {
            _delayCall.cancel();
         }
         if(_movie)
         {
            _movie.stop();
            if(_movie.parent)
            {
               _movie.parent.removeChild(_movie);
            }
         }
         _movie = null;
         errorCallBack = null;
         _labels = null;
         _labesDic = null;
      }
   }
}

