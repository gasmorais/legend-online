package map.outercity.mediator.mapview
{
   import com.pickgliss.toplevel.StageReferance;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import mainBar.SmallMapBar;
   import manager.LanguageMgr;
   import map.internals.data.BaseCastle;
   import map.outercity.OuterCityModel;
   import map.outercity.manager.OuterCityManager;
   import map.outercity.view.OuterCityMap;
   import map.outercity.view.mapphysics.ArmyView;
   import mvc.module.armyII.BaseArmy;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IMediator;
   import yishi.manager.ArmyManager;
   import yishi.manager.CursorManagerII;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class OuterCitySmallMapMediator implements IMediator
   {
      
      public function OuterCitySmallMapMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         SmallMapBar.instance.show();
         var _loc2_:OuterCityModel = OuterCityManager.instance.model;
         SmallMapBar.instance.initData(_loc2_.mapTempInfo,null,initMouseCursor,transmitHandler,localArmyHandler,moveMapHandler,returnCastle,localCastleHandler);
      }
      
      private function initMouseCursor() : void
      {
         TransmitHandler.Instance.resetCursor();
         StageReferance.stage.addEventListener("mouseDown",__mouseDownHandler);
         OuterCityManager.instance.mapView.addEventListener("mouseOut",__mouseOutHandler);
         OuterCityManager.instance.mapView.addEventListener("mouseOver",__mouseOverHandler);
      }
      
      private function __mouseDownHandler(param1:MouseEvent) : void
      {
         StageReferance.stage.removeEventListener("mouseDown",__mouseDownHandler);
         OuterCityManager.instance.mapView.removeEventListener("mouseOut",__mouseOutHandler);
         OuterCityManager.instance.mapView.removeEventListener("mouseOver",__mouseOverHandler);
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         CursorManagerII.instance.resetCursor();
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         CursorManagerII.instance.showCursorByType("PVP_ATTACT_CURSOR");
      }
      
      public function unregister(param1:Object) : void
      {
         __mouseDownHandler(null);
         var _loc2_:OuterCityModel = OuterCityManager.instance.model;
         SmallMapBar.instance.initData(_loc2_.mapTempInfo,null,null,null,null,null,null);
      }
      
      private function transmitHandler() : void
      {
         CursorManagerII.instance.resetCursor();
         TransmitHandler.Instance.show();
      }
      
      private function localArmyHandler() : void
      {
         var _loc2_:String = null;
         var _loc1_:BaseArmy = ArmyManager.instance.army;
         if(_loc1_.mapId != OuterCityManager.instance.model.mapId)
         {
            _loc2_ = LanguageMgr.GetTranslation("map.outercity.mediator.mapview.OuterCitySmallMapMediator.command01");
            MessageTipManager.instance().show(_loc2_);
            NotificationManager.instance.dispatchEvent(new NotificationEvent("ARMY_SYSC_CALL",null));
            return;
         }
         var _loc3_:BaseArmy = OuterCityManager.instance.model.getWorldArmyById(_loc1_.id);
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:ArmyView = _loc3_.armyView as ArmyView;
         if(_loc4_)
         {
            mapView.motionTo(new Point(_loc4_.x - StageReferance.stageWidth / 2,_loc4_.y - StageReferance.stageHeight / 2));
            return;
         }
         if(_loc1_)
         {
            mapView.motionTo(new Point(_loc1_.curPosX * 20 - StageReferance.stageWidth / 2,_loc1_.curPosY * 20 - StageReferance.stageHeight / 2));
         }
      }
      
      public function moveMapHandler(param1:String) : void
      {
         if(param1 == ",")
         {
            return;
         }
         var _loc2_:Array = param1.split(",");
         if(_loc2_.length == 2)
         {
            mapView.motionTo(new Point(int(_loc2_[0]) * 50 - StageReferance.stageWidth / 2,int(_loc2_[1]) * 50 - StageReferance.stageHeight / 2));
         }
      }
      
      private function returnCastle() : void
      {
         OuterCityManager.instance.controler.sendReturnHomeArmy();
      }
      
      private function localCastleHandler() : void
      {
         var _loc2_:String = null;
         var _loc1_:BaseArmy = ArmyManager.instance.army;
         var _loc3_:BaseCastle = PlayerManager.instance.currentPlayerModel.mapNodeInfo;
         if(_loc3_.info.mapId != OuterCityManager.instance.model.mapId)
         {
            _loc2_ = LanguageMgr.GetTranslation("map.outercity.mediator.mapview.OuterCitySmallMapMediator.command02");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(_loc3_)
         {
            mapView.motionTo(new Point(_loc3_.x - StageReferance.stageWidth / 2,_loc3_.y - StageReferance.stageHeight / 2));
         }
      }
      
      private function get mapView() : OuterCityMap
      {
         return OuterCityManager.instance.mapView;
      }
   }
}

