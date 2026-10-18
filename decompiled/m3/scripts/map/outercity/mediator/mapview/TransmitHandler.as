package map.outercity.mediator.mapview
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.road.yishi.proto.army.ArmyPositionMsg;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.ui.Mouse;
   import flash.utils.clearTimeout;
   import flash.utils.setInterval;
   import manager.LanguageMgr;
   import map.outercity.manager.OuterCityManager;
   import map.outercity.manager.OuterFrameManager;
   import map.outercity.view.OuterCityMap;
   import mvc.module.buildings.BuildInfo;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.PlayerEffectInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.BuildingManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.MaskUtils;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class TransmitHandler
   {
      
      private static var _Instance:TransmitHandler;
      
      private var _containter:Bitmap;
      
      public var mouseCursor:Boolean;
      
      private var _timeid:int;
      
      private var _downPos:Point = new Point();
      
      private var _upPos:Point = new Point();
      
      private var _alert:BaseAlerFrame;
      
      public function TransmitHandler()
      {
         super();
      }
      
      public static function get Instance() : TransmitHandler
      {
         if(!_Instance)
         {
            _Instance = new TransmitHandler();
         }
         return _Instance;
      }
      
      public function resetCursor() : void
      {
         StageReferance.stage.removeEventListener("enterFrame",__stageFrameHandler);
         StageReferance.stage.removeEventListener("click",__stageClickHandler);
         StageReferance.stage.removeEventListener("keyDown",__stageKeyHandler);
         StageReferance.stage.removeEventListener("keyUp",__stageKeyHandler);
         if(mapView)
         {
            mapView.removeEventListener("mouseOver",__mouseOverHandler);
         }
         if(mapView)
         {
            mapView.removeEventListener("mouseOut",__mouseOutHandler);
         }
         if(mapView)
         {
            mapView.removeEventListener("mouseDown",__mouseDownHandler);
         }
         if(mapView)
         {
            mapView.removeEventListener("mouseUp",__mouseUpHandler);
         }
         if(_containter && _containter.parent)
         {
            _containter.parent.removeChild(_containter);
         }
         _containter = null;
         Mouse.show();
         mouseCursor = false;
         Mouse.cursor = "auto";
      }
      
      public function show() : void
      {
         resetCursor();
         Mouse.hide();
         mouseCursor = true;
         _containter = ComponentFactory.Instance.creatBitmap("asset.outercity.transmitBim");
         LayerManager.Instance.addToLayer(_containter,0);
         StageReferance.stage.addEventListener("enterFrame",__stageFrameHandler);
         StageReferance.stage.addEventListener("click",__stageClickHandler);
         StageReferance.stage.addEventListener("keyDown",__stageKeyHandler);
         StageReferance.stage.addEventListener("keyUp",__stageKeyHandler);
         if(mapView)
         {
            mapView.addEventListener("mouseOver",__mouseOverHandler);
         }
         if(mapView)
         {
            mapView.addEventListener("mouseOut",__mouseOutHandler);
         }
         if(mapView)
         {
            mapView.addEventListener("mouseDown",__mouseDownHandler);
         }
         if(mapView)
         {
            mapView.addEventListener("mouseUp",__mouseUpHandler);
         }
         __stageFrameHandler(null);
      }
      
      private function __stageKeyHandler(param1:KeyboardEvent) : void
      {
         resetCursor();
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         if(_containter)
         {
            _containter.visible = true;
            Mouse.hide();
            mouseCursor = true;
         }
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         if(_containter)
         {
            _containter.visible = false;
         }
         Mouse.show();
         mouseCursor = false;
         Mouse.cursor = "auto";
      }
      
      private function __mouseDownHandler(param1:MouseEvent) : void
      {
         _downPos.x = StageReferance.stage.mouseX;
         _downPos.y = StageReferance.stage.mouseY;
      }
      
      private function __mouseUpHandler(param1:MouseEvent) : void
      {
         var _loc4_:Point = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc3_:String = null;
         _upPos.x = StageReferance.stage.mouseX;
         _upPos.y = StageReferance.stage.mouseY;
         var _loc2_:int = Point.distance(_downPos,_upPos);
         if(_loc2_ < 3 && _containter)
         {
            _loc4_ = mapView.worldWalkLayer.globalToLocal(_upPos);
            if(!isWalkable(_loc4_.x,_loc4_.y))
            {
               KeyBoardRegister.instance.keyEnable = false;
               _loc5_ = LanguageMgr.GetTranslation("public.prompt");
               _loc6_ = LanguageMgr.GetTranslation("map.campaign.view.ui.RiverView.txt.TransmitHandler.content");
               _alert = AlertManager.Instance.simpleAlert(_loc5_,_loc6_);
               _alert.addEventListener("response",__transferHandler);
            }
            else
            {
               _loc3_ = LanguageMgr.GetTranslation("map.outercity.mediator.mapview.TransmitHandler.command01");
               MessageTipManager.instance().show(_loc3_);
            }
         }
      }
      
      private function __transferHandler(param1:FrameEvent) : void
      {
         var _loc6_:BuildInfo = null;
         var _loc8_:ConfigInfosTempInfo = null;
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         var _loc9_:int = 0;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc10_:String = null;
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            _loc6_ = BuildingManager.instance.model.buildingListByID[-11];
            _loc8_ = TempleteManager.instance.getConfigInfoByConfigName("transport_charge_cost");
            _loc7_ = int(playerEffect.getTransferPowerLimitAddition(_loc6_.templeteInfo.Property2));
            _loc5_ = int(_loc6_.property1);
            _loc9_ = _loc7_ - _loc5_;
            if(100 <= _loc5_)
            {
               transferBack(true,true);
            }
            else
            {
               _loc2_ = LanguageMgr.GetTranslation("map.outercity.mediator.mapview.TransmitHandler.command02",_loc8_.ConfigValue);
               _loc3_ = LanguageMgr.GetTranslation("public.confirm");
               _loc4_ = LanguageMgr.GetTranslation("public.cancel");
               _loc10_ = LanguageMgr.GetTranslation("map.internals.view.displaye.PhysicsMenu.PORTAL");
               SimpleAlertHelper.instance.data = [transferBack];
               SimpleAlertHelper.instance.popAlerFrame(_loc10_,_loc2_,_loc3_,_loc4_,true,false,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert",_loc8_.ConfigValue);
            }
         }
         KeyBoardRegister.instance.keyEnable = true;
         _alert.removeEventListener("response",__transferHandler);
         _alert.dispose();
         _alert = null;
      }
      
      private function transferBack(param1:Boolean, param2:Boolean, param3:int = 0, param4:int = 2) : void
      {
         var _loc5_:Point = null;
         if(param1)
         {
            if(!param2)
            {
               param4 = 1;
            }
            OuterFrameManager.getInstance().closeAll();
            _loc5_ = mapView.worldWalkLayer.globalToLocal(_upPos);
            senPosation(_loc5_.x,_loc5_.y,param4);
         }
      }
      
      private function isWalkable(param1:int, param2:int) : Boolean
      {
         return Boolean(OuterCityManager.instance.model.getWalkable(param1,param2));
      }
      
      private function get playerEffect() : PlayerEffectInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerEffect;
      }
      
      private function __stageFrameHandler(param1:Event) : void
      {
         _containter.x = StageReferance.stage.mouseX - _containter.width / 2;
         _containter.y = StageReferance.stage.mouseY - _containter.height / 2;
      }
      
      private function __stageClickHandler(param1:MouseEvent) : void
      {
         resetCursor();
      }
      
      private function get mapView() : OuterCityMap
      {
         return OuterCityManager.instance.mapView;
      }
      
      public function senPosation(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(8326);
         var _loc4_:ArmyPositionMsg = new ArmyPositionMsg();
         _loc4_.posX = param1 / 20;
         _loc4_.posY = param2 / 20;
         _loc4_.payType = param3;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
         MaskUtils.instance.maskShow(0);
         _timeid = setInterval(__transferPosationHandler,50000);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4237,__transferPosationHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4263,__transferPosationHandler);
      }
      
      private function __transferPosationHandler(param1:SLGSocketEvent = null) : void
      {
         clearTimeout(_timeid);
         MaskUtils.instance.dispose();
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4237,__transferPosationHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4263,__transferPosationHandler);
      }
   }
}

