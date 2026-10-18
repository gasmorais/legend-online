package ui.resourcebar
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import events.PetEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import mainBar.StripView;
   import mainBar.view.PowerExperenceView;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import managers.PetSocketOut;
   import managers.RoomManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignMapModel;
   import mvc.module.children.ChildModel;
   import mvc.module.pet.PetData;
   import mvc.module.room.RoomInfo;
   import ui.resourcebar.view.ChildrenFigureView;
   import ui.resourcebar.view.GoldenSheepView;
   import ui.resourcebar.view.IndulgeView;
   import ui.resourcebar.view.PetFigureView;
   import ui.resourcebar.view.ResourceExtraView;
   import ui.resourcebar.view.ResourceView;
   import ui.resourcebar.view.StrengthBar;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.ConfigManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.ResourceManager;
   import yishi.scene.SceneManager;
   import yishi.utils.MsgMan;
   import yishi.utils.WorldBossHelper;
   
   public class ResourcesBar extends Sprite
   {
      
      private static var _instance:ResourcesBar;
      
      private var _petFlag:int;
      
      private var _playerInfo:PlayerInfo;
      
      private var _childModel:ChildModel;
      
      private var _extraView:ResourceExtraView;
      
      private var _indulgeView:IndulgeView;
      
      private var _resourceView:ResourceView;
      
      private var _petFigureView:PetFigureView;
      
      private var _figureCover:Bitmap;
      
      private var _figureCoverStrip:StripView;
      
      private var _childrenFigureView:ChildrenFigureView;
      
      private var _childrenFigureViewII:ChildrenFigureView;
      
      private var _strengthBar:StrengthBar;
      
      private var _goldenSheepView:GoldenSheepView;
      
      public function ResourcesBar()
      {
         super();
         _resourceView = new ResourceView();
         _resourceView.x = 5;
         _extraView = ComponentFactory.Instance.creatCustomObject("resourceBar.ResourceExtraView");
         var _loc1_:Boolean = PlayerManager.instance.currentPlayerModel.isInAAS;
         var _loc2_:Boolean = ConfigManager.info.AAS;
         if(_loc1_ && _loc2_)
         {
            _indulgeView = ComponentFactory.Instance.creatCustomObject("resourceBar.IndulgeView");
            addChild(_indulgeView);
         }
         _figureCover = ComponentFactory.Instance.creatBitmap("asset.resourcesBar.FigureCover");
         _figureCoverStrip = ComponentFactory.Instance.creatCustomObject("resourceBar.figureCoverStrip");
         _petFigureView = ComponentFactory.Instance.creatCustomObject("resourceBar.PetFigureView");
         _childrenFigureView = ComponentFactory.Instance.creatCustomObject("resourceBar.ChildrenFigureView",[1]);
         _childrenFigureViewII = ComponentFactory.Instance.creatCustomObject("resourceBar.ChildrenFigureViewII",[2]);
         _goldenSheepView = ComponentFactory.Instance.creatCustomObject("resourceBar.GoldenSheepView");
         addChild(_resourceView);
         addChild(_extraView);
         addChild(_petFigureView);
         addChild(_figureCoverStrip);
         addChild(_childrenFigureView);
         addChild(_childrenFigureViewII);
         addChild(_goldenSheepView);
         _figureCoverStrip.addChild(_figureCover);
         _figureCoverStrip.visible = true;
         __heroLevelUpdate(null);
         ResourceManager.instance.sendSyncResources();
         this.mouseEnabled = false;
         this.scrollRect = null;
         _playerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         _childModel = ChildManager.instance.model;
         __updatePetHandler(null);
         _strengthBar = new StrengthBar();
         addChild(_strengthBar);
         addEvent();
         __switchSceneHandler(null);
      }
      
      public static function get instance() : ResourcesBar
      {
         if(!_instance)
         {
            _instance = ComponentFactory.Instance.creatCustomObject("resoueceBar.ResourcesBar");
         }
         return _instance;
      }
      
      private function addEvent() : void
      {
         _playerInfo.addEventListener("PET_ADD",__updatePetHandler);
         _playerInfo.addEventListener("PET_REMOVE",__updatePetHandler);
         _playerInfo.addEventListener("PET_UPDATE",__updatePetHandler);
         _playerInfo.addEventListener("PET_ENTERWAR_CHANGE",__updatePetHandler);
         thane.addEventListener("THANE_LEVEL_UPDATE",__heroLevelUpdate);
         MsgMan.addObserver("ChildEvent.ENTER_CHANGE",this,__updateChildInfoHandler);
         MsgMan.addObserver("ChildEvent.SLAVED_ENTER_CHANGE",this,__updateChildInfoHandler);
         MsgMan.addObserver("ChildEvent.CHILD_INFO",this,__updateChildInfoHandler);
         NotificationManager.instance.addEventListener("ROOM_SELECT_CHANGE",__updateSelectInfoHandler);
         NotificationManager.instance.addEventListener("SWITCH_SCENE",__switchSceneHandler);
      }
      
      private function __switchSceneHandler(param1:NotificationEvent) : void
      {
         var _loc2_:CampaignMapModel = null;
         _petFigureView.visible = true;
         _extraView.visible = true;
         _childrenFigureView.visible = true;
         _childrenFigureViewII.visible = true;
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            _loc2_ = CampaignManager.instance.mapModel;
            if(_loc2_)
            {
               if(WorldBossHelper.checkFlameTemple(_loc2_.mapId) || WorldBossHelper.checkDuskArea(_loc2_.mapId) || WorldBossHelper.checkIceFireTemple(_loc2_.mapId) || WorldBossHelper.checkSvs(_loc2_.mapId))
               {
                  _childrenFigureViewII.x = 205;
                  _childrenFigureViewII.y = 120;
               }
               else if(WorldBossHelper.checkDeepPrison(_loc2_.mapId))
               {
                  _petFigureView.visible = false;
                  _extraView.visible = false;
                  _childrenFigureView.visible = false;
                  _childrenFigureViewII.visible = false;
               }
            }
         }
      }
      
      private function __heroLevelUpdate(param1:PlayerEvent) : void
      {
         if(thane.grades == 11 && _extraView)
         {
            _extraView.refreshView();
         }
         if(thane.grades >= 50)
         {
            _figureCoverStrip.visible = false;
         }
         else
         {
            _figureCoverStrip.tipData = LanguageMgr.GetTranslation("armyII.SkillFrame.AlertMsg",50);
         }
      }
      
      private function __updatePetHandler(param1:PetEvent) : void
      {
         _petFigureView.data = _playerInfo.enterWarPet;
         __updateChildInfoHandler(null,null);
      }
      
      private function __updateChildInfoHandler(param1:String, param2:Object) : void
      {
         _childrenFigureView.data = _childModel.getEnterWar();
         _childrenFigureViewII.data = _childModel.getSlavedEnterWar();
      }
      
      private function __updateSelectInfoHandler(param1:NotificationEvent) : void
      {
         var _loc2_:RoomInfo = param1.data as RoomInfo;
         if(_loc2_ && _loc2_.mapTemplate && _loc2_.mapTemplate.AreaId == 405)
         {
            setVisible(false);
         }
         else
         {
            setVisible(true);
         }
      }
      
      public function checkPetBind(param1:PetData, param2:int) : void
      {
         _petFlag = param2;
         checkBindBack(true,true,param1);
      }
      
      private function checkBindBack(param1:Boolean, param2:Boolean, param3:PetData) : void
      {
         if(!param3)
         {
            return;
         }
         if(param1)
         {
            if(_petFlag == 1)
            {
               PetSocketOut.enterWar(param3.petId);
            }
            else if(_petFlag == 2)
            {
               PetSocketOut.enterChildPet(param3.petId,1);
            }
            else if(_petFlag == 3)
            {
               PetSocketOut.enterChildPet(param3.petId,2);
            }
         }
      }
      
      public function armyBtnEnable(param1:Boolean) : void
      {
         _extraView.armyBtnEnable(param1);
         _resourceView.jobChangeBtnEnable(param1);
      }
      
      public function closeIndulgeView() : void
      {
         _indulgeView.dispose();
         _indulgeView = null;
      }
      
      public function get fatigueView() : PowerExperenceView
      {
         return _resourceView.fatigueView;
      }
      
      public function hide() : void
      {
         visible = false;
      }
      
      public function set iconClickEnable(param1:Boolean) : void
      {
         _resourceView.iconClickEnable = param1;
      }
      
      public function show() : void
      {
         var _loc2_:Boolean = FrameControllerManager.instance.outyardControler.isOutyardMapApply;
         if(_loc2_)
         {
            return;
         }
         var _loc3_:Boolean = FrameControllerManager.instance.gemMazeController.isEnterGemMaze;
         if(_loc3_)
         {
            return;
         }
         var _loc1_:Boolean = SceneManager.instance.isEnterFullScene;
         if(_loc1_)
         {
            return;
         }
         if(RoomManager.instance.roomInfo && RoomManager.instance.roomInfo.mapTemplate && RoomManager.instance.roomInfo.mapTemplate.AreaId == 405)
         {
            setVisible(false);
         }
         else
         {
            setVisible(true);
         }
         _extraView.refreshView();
         _petFigureView.refreshView(true);
         _childrenFigureView.refreshView(true);
         _childrenFigureViewII.refreshView(true);
         _resourceView.refreshView();
         _resourceView.refreshIcon();
         LayerManager.Instance.addToLayer(this,4,false,false,0,0);
         visible = true;
      }
      
      private function setVisible(param1:Boolean) : void
      {
         _petFigureView.visible = param1;
         _childrenFigureView.visible = param1;
         _childrenFigureViewII.visible = param1;
      }
      
      private function get model() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

