package battle
{
   import battle.events.BattleEvent;
   import battle.skillsys.helper.BloodHelper;
   import battle.skillsys.loader.SkillResourceLoader;
   import battle.skillsys.ripple.RipplePreCreater;
   import battle.transaction.BattleTransactionManager;
   import battle.view.BattleView;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import mainBar.ChatBar;
   import ui.tasktracebar.TaskTraceBar;
   import yishi.datas.BattleModel;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.IMEManager;
   import yishi.manager.NotificationManager;
   import yishi.scene.BaseSceneView;
   import yishi.view.shadow.ShadowEffectMaker;
   
   public class BattleSceneView extends BaseSceneView implements IEnterFrame
   {
      
      private var _backGround:MovieClip;
      
      private var _view:BattleView;
      
      private var _model:BattleModel;
      
      private var _enterFrameManager:EnterFrameManager;
      
      private var _unusualCount:int = 0;
      
      private var tfTimer:int = 0;
      
      public function BattleSceneView()
      {
         super();
         _enterFrameManager = EnterFrameManager.instance;
      }
      
      override public function preLoadingStart(param1:Object = null) : void
      {
         super.preLoadingStart(param1);
      }
      
      override public function enter(param1:BaseSceneView, param2:Object = null) : void
      {
         var preScene:BaseSceneView = param1;
         var data:Object = param2;
         var validView:* = function():void
         {
            clearTimeout(timeId);
            timeId = 0;
            mouseChildren = mouseEnabled = true;
         };
         mouseChildren = mouseEnabled = false;
         var timeId:int = int(setTimeout(validView,1000));
         ShowTipManager.Instance.removeAllTip();
         LayerManager.Instance.clearnStageDynamic();
         LayerManager.Instance.clearGameMenuLayer();
         IMEManager.disable();
         BloodHelper.setup();
         BattleManager.getInstance().initBattle(this);
         _model = BattleManager.getInstance().battleModel;
         _backGround = ComponentFactory.Instance.creatCustomObject("battle.BattleBackGround");
         addChild(_backGround);
         _view = new BattleView(_model);
         _view.init();
         addChild(_view);
         EnterFrameManager.instance.registeEnterFrame(this);
         addEventListener("addedToStage",__addToStageHandler);
         ChatBar.inBattleFlag = true;
         TaskTraceBar.instance.hide();
         StageReferance.stage.focus = null;
         NotificationManager.instance.dispatchEvent(new BattleEvent("enterbattlescene",null));
         _view.addEventListener("click",onBattleViewClick);
      }
      
      private function onBattleViewClick(param1:MouseEvent) : void
      {
         if(!(param1.target is TextField) || TextField(param1.target).type != "input")
         {
            IMEManager.disable();
         }
      }
      
      override public function enterOver() : void
      {
         super.enterOver();
         addBattleVectoryAndFailedRes();
         if(ChatBar.inBattleFlag)
         {
            StageReferance.stage.focus = StageReferance.stage;
         }
      }
      
      private function addBattleVectoryAndFailedRes() : void
      {
         var _loc1_:String = ComponentSetting.getUISourcePath("battle2");
         LoaderManagerII.instance.load(_loc1_,3,7,null);
         if(_model.battleType == 293)
         {
            _loc1_ = ComponentSetting.getUISourcePath("clearance");
            LoaderManagerII.instance.load(_loc1_,3,7,null);
         }
      }
      
      private function __addToStageHandler(param1:Event) : void
      {
         layout();
         this.stage.addEventListener("resize",__sesizeHandler);
      }
      
      private function __sesizeHandler(param1:Event) : void
      {
         layout();
      }
      
      private function layout() : void
      {
         if(this.stage.stageWidth < 1500)
         {
            _view.x = 0;
         }
         else
         {
            _view.x = stage.stageWidth / 2 - 750;
         }
         if(stage.stageHeight < 900)
         {
            _view.y = 0;
         }
         else
         {
            _view.y = stage.stageHeight / 2 - 450;
         }
         _backGround.x = _view.x + (_view.sceneWidth >> 1);
         _backGround.y = _view.y + (_view.sceneHeight >> 1);
      }
      
      override public function leaving() : void
      {
         BattleManager.loginToBattleFlag = false;
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         this.removeEventListener("addedToStage",__addToStageHandler);
         if(this.stage)
         {
            this.stage.removeEventListener("resize",__sesizeHandler);
         }
         BattleTransactionManager.getInstance().dispose();
         BattleManager.getInstance().started = false;
         ChatBar.inBattleFlag = false;
         if(_view)
         {
            _view.removeEventListener("click",onBattleViewClick);
         }
         SkillResourceLoader.clearSkillLoader();
         RipplePreCreater.clear();
         LayerManager.Instance.clearGameMenuLayer();
         if(_view)
         {
            _view.dispose();
         }
         ShadowEffectMaker.stopAll();
         BattleManager.getInstance().disposeBattle();
         ObjectUtils.disposeViolentMc(_backGround);
         ObjectUtils.disposeObject(_view);
         _view = null;
         _model = null;
         _backGround = null;
      }
      
      override public function get SceneName() : String
      {
         return "BATTLE_SCENE";
      }
      
      public function enterFrame() : void
      {
         _view.update();
      }
      
      public function get view() : BattleView
      {
         return _view;
      }
   }
}

