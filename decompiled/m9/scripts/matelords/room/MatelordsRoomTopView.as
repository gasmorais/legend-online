package matelords.room
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import mvc.module.matelords.MatelordsModel;
   import yishi.manager.MatelordsManager;
   
   public class MatelordsRoomTopView extends Sprite implements Disposeable
   {
      
      private var _bg:MutipleImage;
      
      private var _titleImg:Image;
      
      private var _roundTxt:FilterFrameText;
      
      private var _waitTimeTxt:FilterFrameText;
      
      private var _timer:Timer;
      
      private var _timeCount:int;
      
      private var _model:MatelordsModel = MatelordsManager.instance.model;
      
      public function MatelordsRoomTopView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("warlordsroom.FinalRoomTopBg");
         _titleImg = ComponentFactory.Instance.creatComponentByStylename("matelordsroom.FinalRoomTopTitleImg");
         _roundTxt = ComponentFactory.Instance.creatComponentByStylename("matelordsroom.FinalRoomTopRoundTxt");
         _waitTimeTxt = ComponentFactory.Instance.creatComponentByStylename("matelordsroom.FinalRoomTopWaitTimeTxt");
         _timer = new Timer(1000);
         addChild(_bg);
         addChild(_titleImg);
         addChild(_roundTxt);
         addChild(_waitTimeTxt);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_titleImg);
         _titleImg = null;
         ObjectUtils.disposeObject(_roundTxt);
         _roundTxt = null;
         ObjectUtils.disposeObject(_waitTimeTxt);
         _waitTimeTxt = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
         _timer.addEventListener("timer",__timeUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         _timer.removeEventListener("timer",__timeUpdateHandler);
      }
      
      private function __timeUpdateHandler(param1:TimerEvent) : void
      {
         _timeCount = _timeCount - 1;
         _waitTimeTxt.text = _timeCount.toString();
         if(_timeCount <= 0)
         {
            _timer.stop();
         }
      }
      
      public function refresh() : void
      {
         if(_model.currentTurn >= _model.maxTurnCount)
         {
            _titleImg.visible = true;
            _bg.setChildVisible(1,false);
            _roundTxt.visible = _waitTimeTxt.visible = false;
         }
         else
         {
            _titleImg.visible = false;
            _bg.setChildVisible(1,true);
            _roundTxt.visible = _waitTimeTxt.visible = true;
         }
         _timeCount = _model.leftTime;
         _roundTxt.text = (_model.currentTurn < _model.maxTurnCount ? _model.currentTurn + 1 : _model.currentTurn) + "/" + _model.maxTurnCount;
         _timer.start();
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
         if(_timer)
         {
            _timer.stop();
            _timer = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

