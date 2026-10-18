package map.campaign.view.ui.molong
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import yishi.timer.TimerTicker;
   
   public class BoxCountDown extends Component
   {
      
      private var _timer:TimerTicker;
      
      private var _endTime:Number;
      
      private var _text:FilterFrameText;
      
      private var _sceneWidth:Number;
      
      private var _sceneHeight:Number;
      
      private var _bg:DisplayObject;
      
      public function BoxCountDown(param1:Number)
      {
         _endTime = param1;
         super();
         initView();
         addEvents();
      }
      
      private function addEvents() : void
      {
         StageReferance.stage.addEventListener("resize",__stageResize);
         __stageResize(null);
      }
      
      private function removeEvents() : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",timeHandler);
            _timer = null;
         }
         StageReferance.stage.removeEventListener("resize",__stageResize);
      }
      
      protected function __stageResize(param1:Event) : void
      {
         _sceneWidth = StageReferance.stage.stageWidth;
         _sceneHeight = StageReferance.stage.stageHeight;
         this.x = (_sceneWidth - 155) * 0.5;
         this.y = _sceneHeight - 175;
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("asset.molong.boxCountDownBg");
         this.addChild(_bg);
         _text = ComponentFactory.Instance.creatComponentByStylename("molong.countDownBox");
         this.addChild(_text);
         _timer = new TimerTicker(1000);
         _timer.addEventListener("timer",timeHandler);
         _timer.start();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,4,false,false,0,2);
      }
      
      private function updateTime() : void
      {
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:Date = new Date();
         if(_endTime - _loc1_.time <= 0)
         {
            _timer.stop();
         }
         var _loc7_:int = (_endTime - _loc1_.time) * 0.001;
         if(_loc7_ >= 60)
         {
            _loc5_ = _loc7_ / 60;
            _loc6_ = _loc5_ % 60;
         }
         else
         {
            _loc6_ = 0;
         }
         _loc5_ = _loc7_ % 60;
         _loc3_ = _loc5_ = int(_loc5_ > 0 ? _loc5_ : 0);
         var _loc2_:String = _loc6_ >= 10 ? _loc6_ + "" : "0" + _loc6_;
         var _loc4_:String = _loc3_ >= 10 ? _loc3_ + "" : "0" + _loc3_;
         _text.text = _loc2_ + ":" + _loc4_;
      }
      
      protected function timeHandler(param1:TimerEvent) : void
      {
         updateTime();
      }
      
      override public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeObject(_text);
         _text = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

