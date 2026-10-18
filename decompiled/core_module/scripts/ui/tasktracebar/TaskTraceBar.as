package ui.tasktracebar
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mainBar.effects.MainToolBtnGlowEffect;
   import map.campaign.CampaignManager;
   import ui.events.UIBarEvent;
   import ui.maintoolbar.MainToolBar;
   import ui.tasktracebar.view.HigherGradeOpenTipView;
   import ui.tasktracebar.view.NewbieTaskTraceView;
   import ui.tasktracebar.view.SelfHelpButtonView;
   import ui.tasktracebar.view.SpaceMapButtonView;
   import ui.tasktracebar.view.TaskTraceView;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   import yishi.utils.WorldBossHelper;
   
   public class TaskTraceBar extends Sprite
   {
      
      private static var _instance:TaskTraceBar;
      
      public static var DAY_GUIDE:String = "day_guide";
      
      public var selfHelpButtonView:SelfHelpButtonView;
      
      public var taskTraceView:Sprite;
      
      public var spaceMapButtonView:SpaceMapButtonView;
      
      public var openTipView:HigherGradeOpenTipView;
      
      private var _disEffect:MainToolBtnGlowEffect;
      
      private var needShowDataTipsBtnObj:Object = {};
      
      private var _isLoaded:Boolean = false;
      
      public function TaskTraceBar()
      {
         super();
      }
      
      public static function get instance() : TaskTraceBar
      {
         if(!_instance)
         {
            _instance = new TaskTraceBar();
         }
         return _instance;
      }
      
      private function initView() : void
      {
         mouseEnabled = false;
         selfHelpButtonView = ComponentFactory.Instance.creatCustomObject("taskTrace.SelfHelpButtonView");
         openTipView = ComponentFactory.Instance.creatCustomObject("taskTrace.HigherGradeOpenTipView");
         spaceMapButtonView = ComponentFactory.Instance.creatCustomObject("taskTrace.SpaceMapButtonView");
         if(PlayerManager.instance.newbieProcess < 19000)
         {
            taskTraceView = new NewbieTaskTraceView();
            taskTraceView.x = 70;
            NotificationManager.instance.addEventListener("SWITCH_SCENE",__switchSceneHandler);
         }
         else
         {
            taskTraceView = new TaskTraceView();
         }
         openTipView.mouseEnabled = openTipView.mouseChildren = false;
         openTipView.y = selfHelpButtonView.y + selfHelpButtonView.height;
         taskTraceView.y = openTipView.y + openTipView.height;
         spaceMapButtonView.y = 370;
         if(openTipView.height == 0)
         {
            selfHelpButtonView.y = 22;
         }
         else
         {
            selfHelpButtonView.y = 0;
         }
         addChild(selfHelpButtonView);
         addChild(taskTraceView);
         addChild(spaceMapButtonView);
         LayerManager.Instance.addToLayer(this,4,false,false,0,1);
         if(parent)
         {
            parent.setChildIndex(this,0);
         }
         __onResize();
      }
      
      private function initEvent() : void
      {
         StageReferance.addEventListener("resize",__onResize);
      }
      
      protected function dailyActivityBtnClickHandle(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("dayguide",1);
      }
      
      private function get inNeedHideTaskTraceBarCampaign() : Boolean
      {
         var _loc1_:int = 0;
         if(CampaignManager.instance.mapModel)
         {
            _loc1_ = CampaignManager.instance.mapModel.mapId;
            if(WorldBossHelper.checkMonopoly(_loc1_))
            {
               return true;
            }
            if(WorldBossHelper.checkSvs(_loc1_))
            {
               return true;
            }
            if(WorldBossHelper.checkMineral(_loc1_))
            {
               return true;
            }
            if(WorldBossHelper.checkFarm(_loc1_))
            {
               return true;
            }
            if(WorldBossHelper.checkInHouse(_loc1_))
            {
               return true;
            }
            if(SceneManager.instance.currentType == "SANDBOX_SCENE")
            {
               return true;
            }
            if(SceneManager.instance.currentType == "PLANE_CRISRIS")
            {
               return true;
            }
            if(SceneManager.instance.currentType == "GAME_HALL_SCENE")
            {
               return true;
            }
            if(SceneManager.instance.currentType == "STARAREA_SCENE")
            {
               return true;
            }
            if(SceneManager.instance.currentType == "SELF_CHESS_SCENE")
            {
               return true;
            }
            if(SceneManager.instance.currentType == "SECRET_ADVENTURE_SCENE")
            {
               return true;
            }
            if(SceneManager.instance.currentType == "THESE_PVP_SCENE")
            {
               return true;
            }
            if(SceneManager.instance.currentType == "THESE_Double_PVP_SCENE")
            {
               return true;
            }
            if(SceneManager.instance.currentType == "SECRET_WAR_SCENE")
            {
               return true;
            }
            if(SceneManager.instance.currentType == "CHILD_NS_WAR_SCENE")
            {
               return true;
            }
         }
         return false;
      }
      
      private function __switchSceneHandler(param1:NotificationEvent) : void
      {
         if(SceneManager.instance.currentType == "CASTLE_SCENE")
         {
            NotificationManager.instance.removeEventListener("SWITCH_SCENE",__switchSceneHandler);
            ObjectUtils.disposeObject(taskTraceView);
            taskTraceView = new TaskTraceView();
            taskTraceView.y = openTipView.y + openTipView.height;
            addChild(taskTraceView);
            __onResize();
         }
      }
      
      private function __onResize(param1:Event = null) : void
      {
         x = StageReferance.gameStageWidth - width;
         y = 159;
         var _loc2_:int = 987 - width;
         if(x < _loc2_)
         {
            x = _loc2_;
         }
      }
      
      private function __completehandler(param1:LoaderInfo, param2:Object) : void
      {
         _isLoaded = true;
         initView();
         initEvent();
         show();
      }
      
      override public function get width() : Number
      {
         return 455;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function get isLoaded() : Boolean
      {
         return _isLoaded;
      }
      
      public function show() : void
      {
         var _loc1_:String = null;
         if(PlayerManager.instance.newbieProcess < 15000)
         {
            return;
         }
         if(!_isLoaded)
         {
            _loc1_ = ComponentSetting.getUISourcePath("tasktracebar");
            LoaderManagerII.instance.load(_loc1_,3,8,__completehandler);
            return;
         }
         var _loc3_:Boolean = FrameControllerManager.instance.outyardControler.isOutyardMapApply;
         if(_loc3_)
         {
            return;
         }
         if(inNeedHideTaskTraceBarCampaign)
         {
            return;
         }
         if(SceneManager.instance.currentType == "PVP_ROOM_SCENE" || SceneManager.instance.currentType == "PVE_ROOM_SCENE" || SceneManager.instance.currentType == "MULTILORDS_ROOM" || SceneManager.instance.currentType == "UNREAL_SHOOTING_ROOM" || SceneManager.instance.currentType == "CROSS_GUILD_SCENE" || SceneManager.instance.currentType == "SELF_CHESS_SCENE")
         {
            return;
         }
         var _loc4_:Boolean = FrameControllerManager.instance.gemMazeController.isEnterGemMaze;
         if(_loc4_)
         {
            return;
         }
         if(needHideTaskTraceBar)
         {
            return;
         }
         var _loc2_:Boolean = SceneManager.instance.isEnterFullScene;
         if(_loc2_)
         {
            return;
         }
         visible = true;
         if(SceneManager.instance.currentType == "OUTER_CITY_SCENE")
         {
            openTipView.visible = false;
         }
         NotificationManager.instance.dispatchEvent(new UIBarEvent("SHOW_TASK_TRACE"));
         MainToolBar.instance.updateFriendNoticeBtnPos(taskTraceView is NewbieTaskTraceView,false);
      }
      
      private function get needHideTaskTraceBar() : Boolean
      {
         var _loc1_:int = 0;
         if(CampaignManager.instance.mapModel)
         {
            _loc1_ = CampaignManager.instance.mapModel.mapId;
            if(WorldBossHelper.checkMonopoly(_loc1_))
            {
               return true;
            }
         }
         return false;
      }
      
      private function get isInHome() : Boolean
      {
         var _loc1_:int = 0;
         if(CampaignManager.instance.mapModel)
         {
            _loc1_ = CampaignManager.instance.mapModel.mapId;
            if(WorldBossHelper.checkInHouse(_loc1_))
            {
               return true;
            }
         }
         return false;
      }
      
      private function get isConsortiaEmeDream() : Boolean
      {
         var _loc1_:int = 0;
         if(CampaignManager.instance.mapModel)
         {
            _loc1_ = CampaignManager.instance.mapModel.mapId;
            if(WorldBossHelper.checkConsortiaEmeDream(_loc1_))
            {
               return true;
            }
         }
         return false;
      }
      
      public function hide() : void
      {
         visible = false;
         NotificationManager.instance.dispatchEvent(new UIBarEvent("HIDE_TASK_TRACE"));
         MainToolBar.instance.updateFriendNoticeBtnPos(!isInHome,false);
      }
      
      private function addBtnTips(param1:String, param2:BaseButton) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:String = param1;
         if(DAY_GUIDE === _loc4_)
         {
            _loc3_ = needShowDataTipsBtnObj[param1];
            if(_loc3_ == null)
            {
               _loc3_ = getBtnTipView();
               needShowDataTipsBtnObj[param1] = _loc3_;
            }
            param2.addChild(_loc3_);
         }
      }
      
      private function getBtnTipView() : MovieClip
      {
         var _loc1_:MovieClip = ComponentFactory.Instance.creatCustomObject("core.InfoTipsMc");
         _loc1_.mouseChildren = _loc1_.mouseEnabled = false;
         _loc1_.visible = false;
         _loc1_.x = 33;
         _loc1_.y = -3;
         return _loc1_;
      }
   }
}

