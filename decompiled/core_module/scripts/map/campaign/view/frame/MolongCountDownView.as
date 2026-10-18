package map.campaign.view.frame
{
   import battle.utils.Helpers;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import yishi.timer.TimerTicker;
   
   public class MolongCountDownView extends Component
   {
      
      private var _timePoint:Number;
      
      private var _timer:TimerTicker;
      
      private var _text:FilterFrameText;
      
      private var _sceneWidth:Number;
      
      private var _sceneHeight:Number;
      
      private var _bg:DisplayObject;
      
      private var _isInBattle:Boolean = false;
      
      public function MolongCountDownView(param1:Number)
      {
         super();
         _bg = ComponentFactory.Instance.creat("asset.core.molongCountDownBg");
         this.addChild(_bg);
         _text = ComponentFactory.Instance.creatComponentByStylename("molong.countDown");
         _text.x = 280;
         _text.y = 0;
         this.addChild(_text);
         count = param1;
         StageReferance.stage.addEventListener("resize",__stageResize);
         __stageResize(null);
      }
      
      public function addtoBattle(param1:DisplayObjectContainer) : void
      {
         _isInBattle = true;
         param1.addChild(this);
         __stageResize(null);
      }
      
      protected function __stageResize(param1:Event) : void
      {
         if(_isInBattle)
         {
            _sceneWidth = Helpers.limitRange(StageReferance.stage.stageWidth,1000,1300);
            _sceneHeight = Helpers.limitRange(StageReferance.stage.stageHeight,600,780);
            this.x = (_sceneWidth - _bg.width) * 0.5;
            this.y = 76;
         }
         else
         {
            _sceneWidth = StageReferance.stage.stageWidth;
            _sceneHeight = StageReferance.stage.stageHeight;
            this.x = (_sceneWidth - _bg.width) * 0.5;
            this.y = 76;
         }
      }
      
      public function set count(param1:Number) : void
      {
         _timePoint = param1;
         var _loc2_:Date = new Date();
         if(param1 <= _loc2_.time)
         {
            if(_timer)
            {
               _text.text = "00:00";
               _timer.stop();
            }
            else
            {
               _text.text = "20:00";
            }
            return;
         }
         if(!_timer)
         {
            _timer = new TimerTicker(1000);
            _timer.addEventListener("timer",__timeHandler);
         }
         _timer.reset();
         _timer.start();
      }
      
      private function __timeHandler(param1:int) : void
      {
         updateTime();
      }
      
      public function show() : void
      {
         _isInBattle = false;
         LayerManager.Instance.addToLayer(this,4,false,false,0,2);
      }
      
      private function updateTime() : void
      {
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:Date = new Date();
         if(_timePoint - _loc1_.time <= 0)
         {
            _timer.stop();
         }
         var _loc7_:int = (_timePoint - _loc1_.time) * 0.001;
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
      
      override public function dispose() : void
      {
         if(_timer)
         {
            _timer.removeEventListener("timer",__timeHandler);
            _timer.stop();
            _timer = null;
         }
         _text.dispose();
         _text = null;
         StageReferance.stage.removeEventListener("resize",__stageResize);
         ObjectUtils.removeChildAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

