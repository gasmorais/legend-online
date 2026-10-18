package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import map.internals.data.MapInitData;
   import map.internals.data.template.MapTemplate;
   import mvc.FrameController;
   import mvc.module.buildings.BuildInfo;
   import yishi.datas.playerinfo.PlayerEffectInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.BuildingManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class WorldMapControler extends FrameController
   {
      
      private var _toMapId:int;
      
      public function WorldMapControler()
      {
         super();
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
      
      override public function get frameClassName() : String
      {
         return "worldmap.WorldMapFrame";
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      public function sendMap(param1:int) : Boolean
      {
         _toMapId = param1;
         if(!checkScene())
         {
            return false;
         }
         var _loc6_:BuildInfo = BuildingManager.instance.model.buildingListByID[-11];
         var _loc8_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("transport_charge_cost");
         var _loc7_:int = playerEffect.getTransferPowerLimitAddition(_loc6_.templeteInfo.Property2);
         var _loc5_:int = _loc6_.property1;
         if(200 <= _loc5_)
         {
            PlayerManager.instance.sendMoveCastle(_toMapId,0,0,1);
            return true;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("map.outercity.mediator.mapview.TransmitHandler.command02",_loc8_.ConfigValue);
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc9_:String = LanguageMgr.GetTranslation("map.internals.view.displaye.PhysicsMenu.PORTAL");
         SimpleAlertHelper.instance.data = [transferBack];
         SimpleAlertHelper.instance.popAlerFrame(_loc9_,_loc2_,_loc3_,_loc4_,true,false,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert",_loc8_.ConfigValue);
         return true;
      }
      
      public function transferBack(param1:Boolean, param2:Boolean, param3:int = 0, param4:int = 2) : void
      {
         if(param1)
         {
            if(!param2)
            {
               param4 = 1;
            }
            PlayerManager.instance.sendMoveCastle(_toMapId,0,0,param4);
         }
      }
      
      public function lookMap(param1:int) : Boolean
      {
         var _loc2_:MapInitData = null;
         if(!checkScene())
         {
            return false;
         }
         var _loc3_:MapTemplate = TempleteManager.instance.mapTemplateCate.getTemplateByID(param1);
         if(_loc3_)
         {
            _loc2_ = new MapInitData();
            _loc2_.mapTempInfo = _loc3_;
            _loc2_.targetPoint = new Point(5000,5000);
            SceneManager.instance.setScene("OUTER_CITY_SCENE",_loc2_,true);
         }
         return true;
      }
      
      private function checkScene() : Boolean
      {
         var _loc1_:String = null;
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            _loc1_ = LanguageMgr.GetTranslation("worldmap.command01");
            MessageTipManager.instance().show(_loc1_);
            return false;
         }
         return true;
      }
      
      private function get playerEffect() : PlayerEffectInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerEffect;
      }
   }
}

