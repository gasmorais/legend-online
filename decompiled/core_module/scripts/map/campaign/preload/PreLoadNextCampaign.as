package map.campaign.preload
{
   import battle.BattleResPreloadManager;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.ui.ComponentSetting;
   import com.road.yishi.proto.campaign.SystemArmyMsg;
   import logging.LoggerSys;
   import map.campaign.CampaignSocketOutManager;
   import map.internals.data.MapInfo;
   import map.internals.data.template.MapTemplate;
   import yishi.comm.PackageIn;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   
   public class PreLoadNextCampaign
   {
      
      private var _mapId:int;
      
      private var _mapFieldId:int = -1;
      
      private var _delay:Number;
      
      public function PreLoadNextCampaign(param1:MapInfo, param2:Boolean = false)
      {
         var _loc3_:String = null;
         super();
         if(param1)
         {
            if(param1.preLoaderNextMap)
            {
               return;
            }
            param1.preLoaderNextMap = true;
            param1 = null;
         }
         if(!param2)
         {
            _loc3_ = ComponentSetting.getUISourcePath("clearance");
            LoaderManagerII.instance.load(_loc3_,3,7,null);
            _loc3_ = ComponentSetting.getUISourcePath("chest");
            LoaderManagerII.instance.load(_loc3_,3,7,null);
            SocketManager.instance.addEventListener("SLGSocketEvent" + 20,__allSystemArmyHandler);
         }
         preLoadAttackState();
      }
      
      public function preLoadAttackState() : void
      {
         LoaderManagerII.instance.load(PathManager.fightStatePath,2,1,null);
      }
      
      public function set mapId(param1:int) : void
      {
         _mapId = param1;
         CampaignSocketOutManager.instance.questCampaignAllEnemy(_mapId);
      }
      
      private function load(param1:MapTemplate) : void
      {
         _mapFieldId = param1.MapFileId;
         preLoadBattleScene(param1);
      }
      
      private function preLoadBattleScene(param1:MapTemplate) : void
      {
         var _loc3_:int = TempleteManager.instance.mapTemplateCate.getTemplateByID(param1.Id).BattleGround;
         var _loc2_:String = PathManager.getBattleMapPath(_loc3_);
         LoaderManagerII.instance.load(_loc2_,1,1,null);
      }
      
      private function __allSystemArmyHandler(param1:SLGSocketEvent) : void
      {
         var _loc7_:int = 0;
         var _loc6_:MapTemplate = null;
         var _loc10_:CampaignTemplate = null;
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 20,__allSystemArmyHandler);
         var _loc9_:PackageIn = param1.data as PackageIn;
         var _loc2_:SystemArmyMsg = new SystemArmyMsg();
         _loc2_ = _loc9_.readBody(_loc2_) as SystemArmyMsg;
         var _loc3_:Array = [];
         for each(var _loc4_:int in _loc2_.heroTemplated)
         {
            if(_loc4_ != -1)
            {
               _loc3_.push(_loc4_);
            }
         }
         var _loc5_:Array = [];
         for each(var _loc8_:int in _loc2_.soldierTemplated)
         {
            if(_loc8_ != -1)
            {
               _loc5_.push(_loc8_);
            }
         }
         _loc2_ = null;
         try
         {
            _loc7_ = TempleteManager.instance.mapTemplateCate.getTemplateByID(_mapId).BattleGround;
            BattleResPreloadManager.load(_loc5_,_loc3_,_loc7_);
            _loc6_ = TempleteManager.instance.mapTemplateCate.getTemplateByID(_mapId);
            _loc10_ = TempleteManager.instance.campaignTemplateDic[_loc6_.CampaignId];
            if(!_loc10_)
            {
               _loc10_ = TempleteManager.instance.worldBossTemplateDict[_loc6_.CampaignId];
            }
            if(!_loc10_)
            {
               return;
            }
            _loc6_ = TempleteManager.instance.mapTemplateCate.getTemplateByID(_loc10_.NextCampaignId);
            if(_loc6_)
            {
               load(_loc6_);
            }
         }
         catch(e:Error)
         {
            LoggerSys.info("预先加副本中战斗资源出错，当前副本编号 ： " + _loc7_ + " _mapId :  " + _mapId + "error : " + e.toString());
         }
      }
   }
}

