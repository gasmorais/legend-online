package map.outercity.mediator.mapview
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import map.internals.data.BaseCastle;
   import map.internals.utils.Utils;
   import map.outercity.OuterCityModel;
   import map.outercity.helper.mapview.MapViewHelper;
   import map.outercity.manager.OuterCityManager;
   import yishi.events.NotificationEvent;
   import yishi.events.ServiceReceiveEvent;
   import yishi.interfaces.IMediator;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.view.tools.SimpleMovie;
   
   public class TranseferMediator implements IMediator
   {
      
      private var _target:DisplayObject;
      
      public function TranseferMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _target = param1 as DisplayObject;
         PlayerManager.instance.addEventListener("TRANSEFER_CASTLE_SUCCESS",__transeferHandler);
         NotificationManager.instance.addEventListener("SWITCH_MAP_TRANSFER",__switchMapTranseferHandler);
      }
      
      public function unregister(param1:Object) : void
      {
         _target = null;
         PlayerManager.instance.removeEventListener("TRANSEFER_CASTLE_SUCCESS",__transeferHandler);
         NotificationManager.instance.removeEventListener("SWITCH_MAP_TRANSFER",__switchMapTranseferHandler);
      }
      
      private function __switchMapTranseferHandler(param1:NotificationEvent) : void
      {
      }
      
      private function __transeferHandler(param1:ServiceReceiveEvent) : void
      {
         var _loc3_:BaseCastle = PlayerManager.instance.currentPlayerModel.mapNodeInfo;
         var _loc4_:MovieClip = ComponentFactory.Instance.creatCustomObject("asset.outercity.TranseferEffAsset");
         var _loc5_:SimpleMovie = new SimpleMovie(_loc4_);
         (_target as Sprite).addChild(_loc5_);
         _loc5_.x = _loc3_.x;
         _loc5_.y = _loc3_.y;
         var _loc8_:OuterCityModel = OuterCityManager.instance.model;
         var _loc2_:String = Utils.getFileName(_loc8_.targetPoint.x,_loc8_.targetPoint.y,1000,1000);
         _loc8_.upPreNineSliceScaling(_loc2_);
         _loc8_.targetPoint.x = _loc3_.x;
         _loc8_.targetPoint.y = _loc3_.y;
         var _loc7_:String = Utils.getFileName(_loc8_.targetPoint.x,_loc8_.targetPoint.y,1000,1000);
         _loc8_.upPreNineSliceScaling(_loc7_);
         _loc4_ = null;
         var _loc6_:Point = MapViewHelper.targetSolveCenter(_loc8_.targetPoint);
         _target.x = _loc6_.x;
         _target.y = _loc6_.y;
         OuterCityManager.instance.mapView.moveEnd();
      }
   }
}

