package map.outercity.mediator.mapview
{
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import map.internals.view.displaye.PhysicsMenu;
   import map.outercity.helper.mapview.MapViewHelper;
   import map.outercity.manager.OuterCityManager;
   import map.outercity.view.OuterCityMap;
   import yishi.interfaces.IMediator;
   import yishi.keyboard.KeyBoardRegister;
   
   public class OuterCityMapDirectionKeyMediator implements IMediator
   {
      
      private var _target:DisplayObject;
      
      public function OuterCityMapDirectionKeyMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _target = param1 as DisplayObject;
         KeyBoardRegister.instance.registerMapKey(__leftMove,__rightMove,__topMove,__downMove);
      }
      
      public function unregister(param1:Object) : void
      {
         KeyBoardRegister.instance.removeMapKey(__leftMove,__rightMove,__topMove,__downMove);
         _target = null;
      }
      
      private function __leftMove() : void
      {
         _target.x += 50;
         PhysicsMenu.getInstance().close();
         dragingCallBack();
         OuterCityManager.instance.mapView.moveEnd();
      }
      
      private function __rightMove() : void
      {
         _target.x -= 50;
         dragingCallBack();
         PhysicsMenu.getInstance().close();
         OuterCityManager.instance.mapView.moveEnd();
      }
      
      private function __topMove() : void
      {
         _target.y += 50;
         PhysicsMenu.getInstance().close();
         dragingCallBack();
         OuterCityManager.instance.mapView.moveEnd();
      }
      
      private function __downMove() : void
      {
         _target.y -= 50;
         PhysicsMenu.getInstance().close();
         dragingCallBack();
         OuterCityManager.instance.mapView.moveEnd();
      }
      
      private function dragingCallBack() : void
      {
         var _loc1_:Point = MapViewHelper.mapMoveCheck(new Point(_target.x,_target.y));
         _target.x = _loc1_.x;
         _target.y = _loc1_.y;
         _loc1_ = null;
      }
      
      private function get mapView() : OuterCityMap
      {
         return OuterCityManager.instance.mapView;
      }
   }
}

