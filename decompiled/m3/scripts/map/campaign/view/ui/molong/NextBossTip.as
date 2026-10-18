package map.campaign.view.ui.molong
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.image.MovieImage;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.scene.SceneManager;
   
   public class NextBossTip extends Sprite
   {
      
      private static var _instance:NextBossTip;
      
      private var _textTipMC:MovieImage;
      
      private var _timer:Timer;
      
      private var _preMouseEnabled:Boolean;
      
      public function NextBossTip()
      {
         super();
         addEvent();
      }
      
      public static function instance() : NextBossTip
      {
         if(_instance == null)
         {
            _instance = new NextBossTip();
         }
         return _instance;
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("SWITCH_SCENE",__onSceneChangeHandler);
      }
      
      private function __onSceneChangeHandler(param1:NotificationEvent) : void
      {
         visible = SceneManager.instance.currentType != "BATTLE_SCENE";
      }
      
      private function init() : void
      {
         mouseEnabled = false;
         mouseChildren = false;
         _textTipMC = ComponentFactory.Instance.creatComponentByStylename("asset.molong.textTipMC");
         addChild(_textTipMC);
         _textTipMC.mouseChildren = _textTipMC.mouseEnabled = false;
         _textTipMC.cacheAsBitmap = true;
         _textTipMC.x = 0;
         _textTipMC.y = -180;
         _textTipMC.movie.addFrameScript(_textTipMC.movie.totalFrames - 1,end);
         setCenter();
      }
      
      private function end() : void
      {
         _textTipMC.movie.gotoAndStop(_textTipMC.movie.totalFrames);
         hide();
      }
      
      private function setCenter() : void
      {
         x = (StageReferance.stage.stageWidth - _textTipMC.displayWidth) / 2;
         y = (StageReferance.stage.stageHeight - _textTipMC.displayHeight) / 2;
      }
      
      public function showTip() : void
      {
         if(_timer != null)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timerHandler);
            _timer = null;
         }
         _timer = new Timer(10000);
         _timer.addEventListener("timer",__timerHandler);
         _timer.start();
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timerHandler);
            _timer = null;
         }
         show();
      }
      
      private function show() : void
      {
         if(_textTipMC == null)
         {
            init();
         }
         _textTipMC.movie.gotoAndPlay(1);
         addChild(_textTipMC);
         LayerManager.Instance.addToLayer(this,0,true);
         _preMouseEnabled = this.parent.mouseEnabled;
         _textTipMC.mouseChildren = _textTipMC.mouseEnabled = false;
         this.parent.mouseEnabled = false;
      }
      
      public function hide() : void
      {
         if(parent)
         {
            this.parent.mouseEnabled = _preMouseEnabled;
         }
         if(_textTipMC && _textTipMC.parent)
         {
            removeChild(_textTipMC);
         }
         if(parent)
         {
            parent.removeChild(this);
         }
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timerHandler);
            _timer = null;
         }
      }
   }
}

