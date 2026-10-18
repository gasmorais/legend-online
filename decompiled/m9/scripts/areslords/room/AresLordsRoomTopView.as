package areslords.room
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import mvc.module.areslords.AresLordsRoomInfo;
   
   public class AresLordsRoomTopView extends Component
   {
      
      private var _bg:MutipleImage;
      
      private var _titleImg:Image;
      
      private var _roundImg:ScaleFrameImage;
      
      private var _roundTxt:FilterFrameText;
      
      private var _turnTxt:FilterFrameText;
      
      private var _waitTimeTxt:FilterFrameText;
      
      private var _timer:Timer;
      
      private var _timeCount:int;
      
      public function AresLordsRoomTopView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.RoomTopBg");
         _titleImg = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.RoomTopTitleImg");
         _roundImg = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.RoomTopRoundImg");
         _roundTxt = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.RoomTopRoundTxt");
         _turnTxt = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.RoomTopTurnTxt");
         _waitTimeTxt = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.RoomTopWaitTimeTxt");
         _timer = new Timer(1000);
         addChild(_bg);
         addChild(_titleImg);
         addChild(_roundImg);
         addChild(_roundTxt);
         addChild(_turnTxt);
         addChild(_waitTimeTxt);
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
      
      public function set data(param1:AresLordsRoomInfo) : void
      {
         if(param1.currentTurn >= param1.maxTurnCount)
         {
            _titleImg.visible = true;
            _roundImg.visible = false;
            _bg.setChildVisible(1,false);
            _roundTxt.visible = _turnTxt.visible = _waitTimeTxt.visible = false;
         }
         else
         {
            _titleImg.visible = false;
            _roundImg.visible = true;
            _bg.setChildVisible(1,true);
            _roundTxt.visible = _turnTxt.visible = _waitTimeTxt.visible = true;
         }
         _timeCount = param1.leftTime;
         if(param1.currentTurn < param1.maxTurnCount)
         {
            _turnTxt.text = param1.currentTurn + 1 + "/" + param1.maxTurnCount;
         }
         else
         {
            _turnTxt.text = param1.currentTurn + "/" + param1.maxTurnCount;
         }
         _roundTxt.text = param1.warIndex + "";
         _roundImg.setFrame(param1.season);
         _timer.start();
      }
      
      override public function get width() : Number
      {
         return 318;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_titleImg);
         _titleImg = null;
         ObjectUtils.disposeObject(_roundImg);
         _roundImg = null;
         ObjectUtils.disposeObject(_roundTxt);
         _roundTxt = null;
         ObjectUtils.disposeObject(_turnTxt);
         _turnTxt = null;
         ObjectUtils.disposeObject(_waitTimeTxt);
         _waitTimeTxt = null;
         _timer = null;
         super.dispose();
      }
   }
}

