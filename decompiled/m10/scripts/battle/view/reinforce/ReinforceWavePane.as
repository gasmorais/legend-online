package battle.view.reinforce
{
   import battle.BattleManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import logging.LoggerSys;
   import manager.LanguageMgr;
   import yishi.datas.BattleModel;
   
   public class ReinforceWavePane extends Component
   {
      
      private var _totalWave:int;
      
      private var _currentWave:int;
      
      private var _top:int;
      
      private var _right:int;
      
      private var _balls:Vector.<ReinforceWaveBall>;
      
      private var _gap:int = 90;
      
      private var _eastGap:int = 80;
      
      private var _tf:FilterFrameText = ComponentFactory.Instance.creat("battle.WaveNumTxt") as FilterFrameText;
      
      public function ReinforceWavePane()
      {
         _tf.text = LanguageMgr.GetTranslation("battle.view.reinforce.ReinforceWavePane.tf.text");
         addChild(_tf);
         super();
      }
      
      public function setTotalWave(param1:int) : void
      {
         _totalWave = param1;
         if(battleModel.battleType == 3886)
         {
            createEastBalls();
         }
         else
         {
            createBalls();
         }
      }
      
      private function createEastBalls() : void
      {
         var _loc1_:ReinforceWaveBall = null;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         _balls = new Vector.<ReinforceWaveBall>();
         _loc3_ = 1;
         while(_loc3_ < _totalWave)
         {
            _loc2_ = LanguageMgr.GetTranslation("battle.view.reinforce.ReinforceWavePane.tipInfo") + (_loc3_ + 1);
            _loc1_ = new ReinforceWaveBall(removeBallCallback,_loc2_,_loc3_);
            _loc1_.x = (_loc3_ - 1) * _eastGap;
            _loc1_.y = _tf.y + _tf.textHeight + 20;
            addChild(_loc1_);
            _balls.push(_loc1_);
            _loc3_++;
         }
         if(_balls.length > 0)
         {
            _tf.x = _balls[0].x;
         }
      }
      
      private function createBalls() : void
      {
         var _loc1_:ReinforceWaveBall = null;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         _balls = new Vector.<ReinforceWaveBall>();
         _loc3_ = 1;
         while(_loc3_ < _totalWave)
         {
            _loc2_ = LanguageMgr.GetTranslation("battle.view.reinforce.ReinforceWavePane.tipInfo") + (_loc3_ + 1);
            _loc1_ = new ReinforceWaveBall(removeBallCallback,_loc2_);
            _loc1_.x = -(_totalWave - _loc3_ - 1) * _gap;
            addChild(_loc1_);
            _balls.push(_loc1_);
            _loc3_++;
         }
         if(_balls.length > 0)
         {
            _tf.x = _balls[0].x - _tf.textWidth - 80;
         }
      }
      
      private function removeBallCallback(param1:ReinforceWaveBall) : void
      {
         removeChild(param1);
         param1.dispose();
      }
      
      public function setCurrentWave(param1:int) : void
      {
         var _loc3_:ReinforceWaveBall = null;
         var _loc2_:String = null;
         var _loc4_:String = null;
         _currentWave = param1;
         if(_balls.length > 0 && _currentWave > 1 && _balls.length <= _totalWave - _currentWave)
         {
            _loc2_ = LanguageMgr.GetTranslation("battle.view.reinforce.ReinforceWavePane.str");
            _loc4_ = LanguageMgr.GetTranslation("battle.view.reinforce.ReinforceWavePane.str2");
            LoggerSys.info("@@@***" + _loc2_ + "=" + _totalWave + _loc4_ + "=" + _currentWave + ";*********@@@");
         }
         while(_balls.length > 0 && _balls.length > _totalWave - _currentWave)
         {
            _loc3_ = _balls.shift();
            if(_loc3_)
            {
               _loc3_.exit();
               if(battleModel.battleType == 3886)
               {
                  _tf.x += _eastGap - 60;
               }
               else
               {
                  _tf.x += _gap;
               }
            }
         }
         if(_totalWave < _currentWave)
         {
            while(_balls.length)
            {
               _loc3_ = _balls.shift();
               if(_loc3_)
               {
                  _loc3_.exit();
               }
            }
         }
         if(_balls.length == 0 || _totalWave < _currentWave)
         {
            if(_tf)
            {
               _tf.visible = false;
            }
         }
      }
      
      private function get battleModel() : BattleModel
      {
         return BattleManager.getInstance().battleModel;
      }
      
      public function showNextWave() : void
      {
         _currentWave = _currentWave + 1;
         setCurrentWave(_currentWave);
      }
      
      public function isLastBall() : Boolean
      {
         if(_totalWave - _currentWave == 1)
         {
            return true;
         }
         return false;
      }
      
      public function set top(param1:int) : void
      {
         _top = param1;
      }
      
      public function get top() : int
      {
         return _top;
      }
      
      public function set right(param1:int) : void
      {
         _right = param1;
      }
      
      public function get right() : int
      {
         return _right;
      }
      
      override public function dispose() : void
      {
         if(_tf)
         {
            ObjectUtils.disposeObject(_tf);
         }
         _tf = null;
         for each(var _loc1_:ReinforceWaveBall in _balls)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         _balls.length = 0;
         _balls = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

