package gamehall.room
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import gamehall.room.mediator.GameHallMouseEventMediator;
   import yishi.manager.MediatorMananger;
   
   public class GameHallSceneMapView extends Sprite
   {
      
      public static const NAME:String = "gamehall.room.GameHallSceneMapView";
      
      protected var _mediatorKey:String;
      
      private var _bgView:Image;
      
      private var _walkView:GameHallSceneWalkView;
      
      public function GameHallSceneMapView()
      {
         super();
         initView();
         addEvent();
      }
      
      protected function registerList() : void
      {
         var _loc1_:Array = [GameHallMouseEventMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"gamehall.room.GameHallSceneMapView");
      }
      
      protected function initView() : void
      {
         _bgView = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallSceneMapView.bgView");
         _walkView = new GameHallSceneWalkView();
         addChild(_bgView);
         addChild(_walkView);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_bgView);
         _bgView = null;
         ObjectUtils.disposeObject(_walkView);
         _walkView = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function addToStage(param1:Event) : void
      {
         registerList();
         if(_walkView)
         {
            _walkView.addToStage(param1);
         }
      }
      
      public function resize(param1:int, param2:int) : void
      {
         this.x = (param1 - _bgView.width) * 0.5;
         this.y = param2 - _bgView.height;
      }
      
      public function onClickHandler(param1:MouseEvent) : Boolean
      {
         if(_walkView)
         {
            _walkView.onClickHandler(param1);
         }
         return true;
      }
      
      public function dispose() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         removeEvent();
         uninitView();
      }
   }
}

