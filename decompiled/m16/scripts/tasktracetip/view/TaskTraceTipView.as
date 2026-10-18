package tasktracetip.view
{
   import com.greensock.TweenMax;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import mainBar.TipsBar;
   import map.campaign.CampaignManager;
   import tasktracetip.data.TipMessageData;
   import yishi.datas.PathInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.scene.SceneManager;
   
   public class TaskTraceTipView extends Component
   {
      
      private static const WIDTH:Number = 219.5;
      
      protected var _back:ScaleFrameImage;
      
      protected var _panel:ScaleFrameImage;
      
      protected var _clostBtn:BaseButton;
      
      protected var _titleImg:Bitmap;
      
      protected var _data:TipMessageData;
      
      protected var _textBtn:TextButton;
      
      protected var _backMv:MovieClip;
      
      private var _timer:Timer = new Timer(5000);
      
      public function TaskTraceTipView()
      {
         super();
         initView();
         initEvent();
      }
      
      protected function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("taskTrace.backBG1");
         _panel = ComponentFactory.Instance.creatComponentByStylename("taskTrace.panelBG1");
         _titleImg = ComponentFactory.Instance.creatBitmap("asset.taskTraceTips.TitleImg");
         _clostBtn = ComponentFactory.Instance.creatComponentByStylename("taskTrace.MessageCloseBtn");
         _backMv = ComponentFactory.Instance.creat("asset.taskTrace.backBGMv1");
         _backMv.container.movie01.visible = false;
         _backMv.container.movie01.stop();
         _backMv.container.movie02.visible = false;
         _backMv.container.movie02.stop();
         _back.setFrame(1);
         _panel.setFrame(1);
         _backMv.container.container.addChild(_back);
         addChild(_backMv);
         addChild(_panel);
         addChild(_titleImg);
         addChild(_clostBtn);
         __onResizeHandler(null);
      }
      
      protected function uninit() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _data = null;
      }
      
      protected function initEvent() : void
      {
         if(_textBtn)
         {
            _textBtn.addEventListener("click",__btnHandler);
         }
         _clostBtn.addEventListener("click",__onCloseHandler);
         StageReferance.stage.addEventListener("resize",__onResizeHandler);
         NotificationManager.instance.addEventListener("SHOW_TASK_TRACE",__show);
         NotificationManager.instance.addEventListener("HIDE_TASK_TRACE",__hide);
         NotificationManager.instance.addEventListener("SWITCH_SCENE",_onSceneViewAdded);
      }
      
      protected function removeEvent() : void
      {
         if(_textBtn)
         {
            _textBtn.removeEventListener("click",__btnHandler);
         }
         _clostBtn.removeEventListener("click",__onCloseHandler);
         StageReferance.stage.removeEventListener("resize",__onResizeHandler);
         NotificationManager.instance.removeEventListener("SHOW_TASK_TRACE",__show);
         NotificationManager.instance.removeEventListener("HIDE_TASK_TRACE",__hide);
         NotificationManager.instance.removeEventListener("SWITCH_SCENE",_onSceneViewAdded);
      }
      
      protected function __onResizeHandler(param1:Event) : void
      {
         if(SceneManager.instance.currentType == "CASTLE_SCENE" || SceneManager.instance.currentType == "SPACE_SCENE" || SceneManager.instance.currentType == "OUTER_CITY_SCENE")
         {
            x = StageReferance.gameStageWidth - wid - 90;
            if(x < PathInfo.GAME_WIDTH - wid - 90)
            {
               x = PathInfo.GAME_WIDTH - wid - 90;
            }
         }
         else
         {
            x = StageReferance.gameStageWidth - wid;
            if(x < PathInfo.GAME_WIDTH - wid)
            {
               x = PathInfo.GAME_WIDTH - wid;
            }
         }
         y = StageReferance.gameStageHeight - hei - 70 + gap;
         if(y < PathInfo.GAME_HEIGHT - hei - 70 + gap)
         {
            y = PathInfo.GAME_HEIGHT - hei - 70 + gap;
         }
      }
      
      private function moveComplete() : void
      {
         if(!_timer)
         {
            _timer = new Timer(5000);
         }
         _timer.addEventListener("timer",onTime);
         _timer.start();
         if(!_back || !_backMv || !_backMv.container)
         {
            return;
         }
         if(_back.getFrame == 1)
         {
            _backMv.container.movie01.visible = true;
            _backMv.container.movie01.gotoAndPlay(1);
         }
         else if(_back.getFrame == 2)
         {
            _backMv.container.movie02.visible = true;
            _backMv.container.movie02.gotoAndPlay(1);
         }
         else if(_back.getFrame == 3)
         {
            _backMv.container.movie01.visible = true;
            _backMv.container.movie01.gotoAndPlay(1);
         }
      }
      
      protected function onTime(param1:TimerEvent) : void
      {
         if(!_timer)
         {
            _timer = new Timer(5000);
         }
         _timer.removeEventListener("timer",onTime);
         _timer.reset();
         if(_back == null)
         {
            return;
         }
         if(_back.getFrame == 1 && _backMv)
         {
            _backMv.container.movie01.visible = false;
            _backMv.container.movie01.gotoAndStop(1);
         }
         else if(_back.getFrame == 2 && _backMv)
         {
            _backMv.container.movie02.visible = false;
            _backMv.container.movie02.gotoAndStop(1);
         }
         else if(_back.getFrame == 3 && _backMv)
         {
            _backMv.container.movie01.visible = false;
            _backMv.container.movie01.gotoAndStop(1);
         }
      }
      
      private function __onCloseHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _clostBtn.enable = false;
         dispose();
      }
      
      private function __show(param1:Event) : void
      {
         visible = true;
      }
      
      private function __hide(param1:Event) : void
      {
         var _loc2_:int = int(CampaignManager.instance.mapModel ? CampaignManager.instance.mapModel.mapId : 0);
         visible = false;
      }
      
      protected function _onSceneViewAdded(param1:NotificationEvent) : void
      {
         if(SceneManager.instance.currentType == "CASTLE_SCENE" || SceneManager.instance.currentType == "SPACE_SCENE" || SceneManager.instance.currentType == "OUTER_CITY_SCENE")
         {
            x = StageReferance.gameStageWidth - wid - 90;
            if(x < PathInfo.GAME_WIDTH - wid - 90)
            {
               x = PathInfo.GAME_WIDTH - wid - 90;
            }
         }
         else
         {
            x = StageReferance.gameStageWidth - wid;
            if(x < PathInfo.GAME_WIDTH - wid)
            {
               x = PathInfo.GAME_WIDTH - wid;
            }
         }
      }
      
      public function get data() : TipMessageData
      {
         return _data;
      }
      
      public function set data(param1:TipMessageData) : void
      {
         _data = param1;
         if(_textBtn)
         {
            if((_textBtn.textField as TextField).textWidth > 92)
            {
               (_textBtn.textField as TextField).width = (_textBtn.textField as TextField).textWidth + 3;
               _textBtn.width = (_textBtn.textField as TextField).width + 30;
               (_textBtn.textField as TextField).x = 15;
               _textBtn.x = (214 - _textBtn.width) * 0.5;
            }
         }
      }
      
      protected function __btnHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
      }
      
      protected function check() : Boolean
      {
         return false;
      }
      
      public function addMessage() : void
      {
         if(_data && _textBtn && _textBtn.enable && check())
         {
            TipsBar.instance.messageBtnList.addMessage(_data);
         }
      }
      
      public function show() : void
      {
         var _loc1_:Number = NaN;
         LayerManager.Instance.addToLayer(this,4,false,false,0,1,false);
         _loc1_ = StageReferance.gameStageHeight - hei - 70 + gap;
         if(_loc1_ < PathInfo.GAME_HEIGHT - hei - 70 + gap)
         {
            _loc1_ = PathInfo.GAME_HEIGHT - hei - 70 + gap;
         }
         y = _loc1_ + 200;
         TweenMax.to(this,0.5,{
            "alpha":1,
            "y":_loc1_,
            "onComplete":moveComplete
         });
      }
      
      private function get gap() : int
      {
         if(_back && _back.getFrame == 2)
         {
            return 40;
         }
         return 0;
      }
      
      protected function get hei() : int
      {
         return 167;
      }
      
      protected function get wid() : int
      {
         return 220;
      }
      
      override public function dispose() : void
      {
         TweenMax.killTweensOf(this);
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",onTime);
            _timer = null;
         }
         addMessage();
         removeEvent();
         uninit();
         if(_back)
         {
            _back.dispose();
         }
         _back = null;
         if(_clostBtn)
         {
            _clostBtn.dispose();
         }
         _clostBtn = null;
         if(_textBtn)
         {
            _textBtn.dispose();
         }
         _textBtn = null;
         ObjectUtils.disposeViolentMc(_backMv);
         _backMv = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         dispatchEvent(new Event("dispose"));
         StageReferance.stage.focus = null;
         super.dispose();
         NotificationManager.instance.sendNotification("NEXT_TASK_TRACETIPVIEW");
      }
   }
}

