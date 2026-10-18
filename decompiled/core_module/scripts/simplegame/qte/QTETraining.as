package simplegame.qte
{
   import com.greensock.TweenMax;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import yishi.interfaces.IEnterFrame;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.EnterFrameManager;
   
   public class QTETraining extends Sprite implements Disposeable, IEnterFrame
   {
      
      private var _bgMc:MovieClip;
      
      private var _closeBtn:BaseButton;
      
      private var _qte:QTEComponent;
      
      private var _timeMc:MovieClip;
      
      private var _mask:Sprite;
      
      private var _restartBtn:IconButton;
      
      private var _darkFilter:ColorMatrixFilter;
      
      private var _countDownMc:MovieClip;
      
      private var _qteShine:MovieClip;
      
      private var _succeedMc:MovieClip;
      
      private var _timerID:uint;
      
      private var _qteNum:int;
      
      private var _qteTime:Number;
      
      private var _succeedCallBack:Function;
      
      private var _isSuccessed:Boolean = false;
      
      public function QTETraining(param1:int = 5, param2:Number = 6000, param3:Function = null)
      {
         super();
         _qteNum = param1;
         _qteTime = param2;
         _succeedCallBack = param3;
         initView();
         addEvent();
         startQTE();
      }
      
      private function initView() : void
      {
         _darkFilter = new ColorMatrixFilter([0.5,0,0,0,6.1,0,0.5,0,0,6.1,0,0,0.5,0,6.1,0,0,0,1,0]);
         _bgMc = ComponentFactory.Instance.creatCustomObject("task.QteBgMc");
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("task.QteCloseBtn");
         _restartBtn = ComponentFactory.Instance.creatComponentByStylename("task.QteRestartBtn");
         _timeMc = ComponentFactory.Instance.creatCustomObject("task.QteTimeMc");
         _countDownMc = ComponentFactory.Instance.creatCustomObject("task.CountDownMc");
         _countDownMc.gotoAndStop(1);
         _qteShine = ComponentFactory.Instance.creatCustomObject("task.QteShine");
         _qteShine.gotoAndStop(1);
         _succeedMc = ComponentFactory.Instance.creatCustomObject("task.SucceedMc");
         _succeedMc.gotoAndStop(1);
         _mask = new Sprite();
         _mask.graphics.beginFill(16777215,1);
         _mask.graphics.drawRect(6,6,268,12);
         _mask.graphics.endFill();
         _mask.width = 268;
         _closeBtn.x = _bgMc.x + _bgMc.width - _closeBtn.width - 80;
         _closeBtn.y = _bgMc.y;
         _countDownMc.x = _bgMc.x + _bgMc.width / 2;
         _countDownMc.y = _bgMc.y + _bgMc.height / 2;
         _qteShine.x = _bgMc.x + _bgMc.width / 2;
         _qteShine.y = _bgMc.y + _bgMc.height / 2 + 20;
         _succeedMc.x = _bgMc.x + _bgMc.width / 2 - 77;
         _succeedMc.y = _bgMc.y + _bgMc.height / 2 + 14;
         _timeMc.x = _bgMc.x + _bgMc.width / 2 - _timeMc.width / 2;
         _timeMc.y = _bgMc.y + _bgMc.height / 2 + 32;
         _restartBtn.x = _bgMc.x + _bgMc.width / 2 - _restartBtn.width / 2;
         _restartBtn.y = _timeMc.y - 19;
         addChild(_bgMc);
         addChild(_closeBtn);
         _timeMc.addChild(_mask);
         _timeMc["progress"].mask = _mask;
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      private function addEvent() : void
      {
         _closeBtn.addEventListener("click",__onCloseClick);
         _restartBtn.addEventListener("click",__onRestartClick);
         StageReferance.stage.addEventListener("resize",__resizeHandler);
      }
      
      private function removeEvent() : void
      {
         _closeBtn.removeEventListener("click",__onCloseClick);
         _restartBtn.removeEventListener("click",__onRestartClick);
         StageReferance.stage.removeEventListener("resize",__resizeHandler);
      }
      
      private function __resizeHandler(param1:Event) : void
      {
         this.x = (StageReferance.gameStageWidth - 664) / 2 - 170;
      }
      
      private function startQTE() : void
      {
         addChild(_countDownMc);
         _countDownMc.gotoAndPlay(1);
      }
      
      public function enterFrame() : void
      {
         if(_qteShine.currentFrame == _qteShine.totalFrames)
         {
            _qteShine.gotoAndStop(1);
            if(_qteShine.parent)
            {
               _qteShine.parent.removeChild(_qteShine);
            }
         }
         if(_countDownMc.currentFrame == _countDownMc.totalFrames)
         {
            countdownCall();
         }
         if(_succeedMc.currentFrame == _succeedMc.totalFrames)
         {
            dispose();
         }
      }
      
      private function countdownCall() : void
      {
         _countDownMc.gotoAndStop(1);
         if(_countDownMc.parent)
         {
            _countDownMc.parent.removeChild(_countDownMc);
         }
         createQTE();
         addChild(_qteShine);
         _qteShine.gotoAndPlay(1);
         _mask.width = 268;
         addChild(_timeMc);
         startTime();
      }
      
      private function __onCloseClick(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function __onRestartClick(param1:MouseEvent) : void
      {
         StageReferance.stage.focus = null;
         if(_restartBtn.parent)
         {
            _restartBtn.parent.removeChild(_restartBtn);
         }
         if(_qte)
         {
            _qte.filters = null;
            if(_qte.parent)
            {
               _qte.parent.removeChild(_qte);
            }
            _qte.dispose();
            _qte = null;
         }
         startQTE();
      }
      
      private function createQTE() : void
      {
         _qte = new QTEComponent(_qteNum,succeedCall);
         _qte.x = _bgMc.x + (_bgMc.width - _qte.width) / 2 - 50;
         _qte.y = _bgMc.y + _bgMc.height / 2 - 33;
         addChild(_qte);
      }
      
      private function startTime() : void
      {
         TweenMax.to(_mask,_qteTime / 1000,{"width":1});
         _timerID = setTimeout(timeUpHandler,_qteTime);
      }
      
      private function succeedCall() : void
      {
         _isSuccessed = true;
         clearTimeout(_timerID);
         TweenMax.killTweensOf(_mask);
         if(_qte)
         {
            if(_qte.parent)
            {
               _qte.parent.removeChild(_qte);
            }
            _qte.dispose();
            _qte = null;
         }
         if(_timeMc && _timeMc.parent)
         {
            _timeMc.parent.removeChild(_timeMc);
         }
         addChild(_succeedMc);
         _succeedMc.gotoAndPlay(1);
      }
      
      private function timeUpHandler() : void
      {
         if(_qte)
         {
            _qte.enable = false;
            _qte.filters = [_darkFilter];
         }
         TweenMax.killTweensOf(_mask);
         clearTimeout(_timerID);
         if(_timeMc && _timeMc.parent)
         {
            _timeMc.parent.removeChild(_timeMc);
         }
         addChild(_restartBtn);
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,2,true,true,2);
         __resizeHandler(null);
      }
      
      public function dispose() : void
      {
         if(_isSuccessed && _succeedCallBack != null)
         {
            _succeedCallBack();
         }
         _succeedCallBack = null;
         KeyBoardRegister.instance.keyEnable = true;
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         clearTimeout(_timerID);
         removeEvent();
         TweenMax.killChildTweensOf(this,false);
         ObjectUtils.disposeAllChildren(this);
         _bgMc = null;
         _timeMc = null;
         _mask = null;
         _darkFilter = null;
         _succeedCallBack = null;
         if(_qte)
         {
            _qte.dispose();
            _qte = null;
         }
         if(_countDownMc)
         {
            _countDownMc.gotoAndStop(1);
            _countDownMc = null;
         }
         if(_qteShine)
         {
            _qteShine.gotoAndStop(1);
            _qteShine = null;
         }
         if(_succeedMc)
         {
            _succeedMc.gotoAndStop(1);
            _succeedMc = null;
         }
         if(_closeBtn)
         {
            _closeBtn.dispose();
         }
         _closeBtn = null;
         if(_restartBtn)
         {
            _restartBtn.dispose();
         }
         _restartBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

