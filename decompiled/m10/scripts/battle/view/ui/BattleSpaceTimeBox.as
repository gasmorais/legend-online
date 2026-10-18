package battle.view.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class BattleSpaceTimeBox extends Sprite
   {
      
      private var _mc:MovieClip;
      
      private var _boxType:int = -1;
      
      private var _currStar:int = -1;
      
      private var _idx:int;
      
      private var _startTime:int;
      
      private var _endTime:int;
      
      private var _canUseTime:int;
      
      private var _boxCountText:FilterFrameText;
      
      public function BattleSpaceTimeBox()
      {
         super();
      }
      
      public function initConfig(param1:int, param2:int, param3:int, param4:int, param5:int) : void
      {
         _idx = param1;
         _startTime = param2;
         _endTime = param3;
         _canUseTime = _endTime - _startTime;
         if(_boxType == param4)
         {
            return;
         }
         ObjectUtils.disposeViolentMc(_mc);
         ObjectUtils.disposeObject(_boxCountText);
         _mc = ComponentFactory.Instance.creatCustomObject("asset.battle.spaceTimeBox" + param4);
         _boxCountText = ComponentFactory.Instance.creatComponentByStylename("battle.spaceTimeBox.boxCountText");
         _mc.gotoAndStop(1);
         addChild(_mc);
         addChild(_boxCountText);
         _boxCountText.text = param5 + "";
         _boxCountText.setFrame(1);
      }
      
      public function refreshTime(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Number = NaN;
         if(_canUseTime == 0)
         {
            return;
         }
         if(param1 < _endTime)
         {
            _loc3_ = param1 - _startTime;
            _loc2_ = 0;
            _loc2_ = _loc3_ / _canUseTime;
            if(_loc2_ <= 0.25)
            {
               star = 4;
            }
            else if(_loc2_ <= 0.5)
            {
               star = 3;
            }
            else if(_loc2_ <= 0.75)
            {
               star = 2;
            }
            else if(_loc2_ <= 1)
            {
               star = 1;
            }
         }
         else
         {
            star = 0;
         }
      }
      
      private function set star(param1:int) : void
      {
         if(_currStar == param1 || _mc == null)
         {
            return;
         }
         _currStar = param1;
         _boxCountText.setFrame(1);
         if(param1 == 0)
         {
            _mc.gotoAndStop(40);
            _boxCountText.setFrame(2);
         }
         else if(param1 == 1)
         {
            _mc.gotoAndStop(30);
         }
         else if(param1 == 2)
         {
            _mc.gotoAndStop(20);
         }
         else if(param1 == 3)
         {
            _mc.gotoAndStop(10);
         }
         else if(param1 == 4)
         {
            _mc.gotoAndStop(1);
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeViolentMc(_mc);
         _mc = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

