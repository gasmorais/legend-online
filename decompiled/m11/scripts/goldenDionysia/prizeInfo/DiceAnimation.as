package goldenDionysia.prizeInfo
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import utils.LogicUtils;
   
   public class DiceAnimation extends Sprite
   {
      
      public static const DICE_COUNT:uint = 3;
      
      private var _setTimeout:uint;
      
      private var _curPlayEndCount:uint;
      
      private var _animationFinishCallback:Function;
      
      private var _diceAnimationList:Vector.<DiceMc>;
      
      public function DiceAnimation(param1:Array, param2:Function)
      {
         var _loc5_:DiceMc = null;
         var _loc3_:MovieClip = null;
         var _loc4_:* = 0;
         super();
         this.mouseChildren = this.mouseEnabled = false;
         _animationFinishCallback = param2;
         _diceAnimationList = new Vector.<DiceMc>();
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            _loc3_ = ComponentFactory.Instance.creatCustomObject("goldenDionysia.diceAnimation") as MovieClip;
            _loc5_ = new DiceMc(_loc3_);
            _diceAnimationList.push(_loc5_);
            addChild(_loc5_);
            _loc5_.x = _loc4_ * _loc5_.width;
            _loc4_++;
         }
         playAnimation(param1);
      }
      
      private function playAnimation(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc4_:DiceMc = null;
         var _loc3_:* = 0;
         _curPlayEndCount = 0;
         _loc3_ = 0;
         while(_loc3_ < _diceAnimationList.length)
         {
            _loc4_ = _diceAnimationList[_loc3_];
            _loc4_.play(param1[_loc3_],_loc3_ + 1,playEndCallback);
            _loc3_++;
         }
      }
      
      private function playEndCallback() : void
      {
         _curPlayEndCount = _curPlayEndCount + 1;
         if(_curPlayEndCount == 3)
         {
            _setTimeout = setTimeout(runCallback,5000);
            StageReferance.stage.addEventListener("click",__stageClickHandler);
         }
      }
      
      private function __stageClickHandler(param1:MouseEvent) : void
      {
         runCallback();
      }
      
      private function runCallback() : void
      {
         StageReferance.stage.removeEventListener("click",__stageClickHandler);
         clearTimeout(_setTimeout);
         if(_animationFinishCallback != null)
         {
            _animationFinishCallback();
            _animationFinishCallback = null;
         }
      }
      
      public function dispose() : void
      {
         LogicUtils.disposeDisplayCollection(_diceAnimationList);
         _diceAnimationList = null;
      }
   }
}

import com.pickgliss.utils.ObjectUtils;
import flash.display.MovieClip;
import flash.display.Sprite;

class DiceMc extends Sprite
{
   
   private var _mainMc:MovieClip;
   
   private var _resultMc:MovieClip;
   
   private var _totlaYoyoTime:uint = 0;
   
   private var _curYoyoTime:uint = 0;
   
   private var _endCallback:Function;
   
   public function DiceMc(param1:MovieClip)
   {
      super();
      _mainMc = param1;
      _mainMc.gotoAndStop(1);
      _resultMc = _mainMc["resultDiceMc"] as MovieClip;
      _resultMc.stop();
      _resultMc.visible = false;
      addChild(_mainMc);
   }
   
   public function play(param1:uint, param2:uint, param3:Function) : void
   {
      _resultMc.gotoAndStop(param1);
      _endCallback = param3;
      _curYoyoTime = 0;
      _totlaYoyoTime = param2;
      _mainMc.addFrameScript(30,__targetFrameHandler);
      _mainMc.play();
   }
   
   private function __targetFrameHandler() : void
   {
      _curYoyoTime = _curYoyoTime + 1;
      if(_curYoyoTime >= _totlaYoyoTime)
      {
         _mainMc.addFrameScript(30,null);
         _mainMc.gotoAndStop(31);
         _resultMc.visible = true;
         _endCallback();
      }
      else
      {
         _mainMc.gotoAndPlay(1);
      }
   }
   
   public function dispose() : void
   {
      ObjectUtils.disposeViolentMc(_mainMc);
      _mainMc = null;
      ObjectUtils.disposeViolentMc(_resultMc);
      _resultMc = null;
   }
}
