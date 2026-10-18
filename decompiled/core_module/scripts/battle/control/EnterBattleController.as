package battle.control
{
   import battle.BattleManager;
   import battle.effect.TransSceneEffectContext;
   import battle.events.BattleEvent;
   import battle.skillsys.ripple.RipplePreCreater;
   import battle.view.ui.BattleLoadingView;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignMapModel;
   import mvc.module.maze.MazeModel;
   import yishi.datas.BattleModel;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.StageFocusManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.TimerUtils;
   import yishi.utils.WorldBossHelper;
   import yishi.view.community.LoadingSceneView;
   import yishi.view.guild.QteSkillGuide;
   
   public class EnterBattleController
   {
      
      private static var instance:EnterBattleController;
      
      private var _battleLoadingView:BattleLoadingView;
      
      private var _canceled:Boolean;
      
      private var switchSceneFlag:Boolean;
      
      private var _battleLoadingBlock:Sprite;
      
      private var _enterBattleEffect:MovieClip;
      
      public function EnterBattleController()
      {
         super();
      }
      
      public static function getInstance() : EnterBattleController
      {
         if(instance == null)
         {
            instance = new EnterBattleController();
         }
         return instance;
      }
      
      public function handler(param1:SLGSocketEvent) : void
      {
         _canceled = false;
         NotificationManager.instance.addEventListener("battleCancel",onBattleCancel);
         if(LoadingSceneView.instance.isShowing())
         {
            switchSceneFlag = LoadingSceneView.instance.switchSceneFlag;
            LoadingSceneView.instance.addEventListener("close",onLoadingClose);
         }
         else
         {
            startHandler();
         }
      }
      
      private function onLoadingClose(param1:Event) : void
      {
         LoadingSceneView.instance.removeEventListener("close",onLoadingClose);
         if(_canceled)
         {
            return;
         }
         if(switchSceneFlag)
         {
            NotificationManager.instance.addEventListener("SWITCH_SCENE",switchSceneHandler);
         }
         else
         {
            startHandler();
         }
      }
      
      private function switchSceneHandler(param1:NotificationEvent) : void
      {
         NotificationManager.instance.removeEventListener("SWITCH_SCENE",switchSceneHandler);
         startHandler();
      }
      
      private function startHandler() : void
      {
         if(_canceled)
         {
            return;
         }
         _battleLoadingView = new BattleLoadingView();
         _battleLoadingView.startShowLoad(preCreateRipple);
         addLoadingBlock();
         showLoadingView();
      }
      
      private function onBattleCancel(param1:BattleEvent) : void
      {
         _canceled = true;
         if(_enterBattleEffect)
         {
            _enterBattleEffect.stop();
            _enterBattleEffect.addFrameScript(7,null);
            if(_enterBattleEffect.parent)
            {
               _enterBattleEffect.parent.removeChild(_enterBattleEffect);
               _enterBattleEffect = null;
            }
         }
         removeBlock();
         removeLoadingView();
         NotificationManager.instance.removeEventListener("battleCancel",onBattleCancel);
      }
      
      private function addLoadingBlock() : void
      {
         if(_battleLoadingBlock)
         {
            return;
         }
      }
      
      private function showSwitchEffect(param1:Function) : void
      {
         if(_enterBattleEffect)
         {
            _enterBattleEffect.addFrameScript(7,null);
            ObjectUtils.disposeObject(_enterBattleEffect);
         }
         _enterBattleEffect = ComponentFactory.Instance.creat("asset.core.EnterBattleSwitchMC");
         LayerManager.Instance.addToLayer(_enterBattleEffect,2,false,false,2);
         _enterBattleEffect.x = StageReferance.stage.stageWidth * 0.5;
         _enterBattleEffect.y = StageReferance.stage.stageHeight * 0.5;
         _enterBattleEffect.addFrameScript(7,param1);
         _enterBattleEffect.gotoAndPlay(1);
      }
      
      private function showLoadingView() : void
      {
         if(_battleLoadingView)
         {
            LayerManager.Instance.addToLayer(_battleLoadingView,2,true);
         }
      }
      
      private function preCreateRipple() : void
      {
         if(_canceled)
         {
            return;
         }
         NotificationManager.instance.sendNotification("BATTLE_READ_GO");
         var _loc2_:Array = BattleManager.getInstance().battleModel.skillIds;
         var _loc1_:Array = RipplePreCreater.create(_loc2_,null);
         if(_loc1_.length > 0)
         {
            TimerUtils.setTimeout(loadingCallback,_loc1_.length * 100);
         }
         else
         {
            loadingCallback();
         }
         BattleManager.getInstance().battleModel.skillIds = null;
      }
      
      private function loadingCallback() : void
      {
         if(_canceled)
         {
            return;
         }
         if(_battleLoadingView && _battleLoadingView.parent)
         {
            showSwitchEffect(switchToBattle);
         }
         else
         {
            switchToBattle();
         }
         removeLoadingView();
      }
      
      private function removeLoadingView() : void
      {
         if(_battleLoadingView)
         {
            if(_battleLoadingView.parent)
            {
               _battleLoadingView.parent.removeChild(_battleLoadingView);
            }
            _battleLoadingView.dispose();
            _battleLoadingView = null;
         }
      }
      
      private function removeBlock() : void
      {
         if(_battleLoadingBlock)
         {
            if(_battleLoadingBlock.parent)
            {
               _battleLoadingBlock.parent.removeChild(_battleLoadingBlock);
            }
            _battleLoadingBlock = null;
         }
      }
      
      private function switchToBattle() : void
      {
         var _loc1_:Object = null;
         NotificationManager.instance.removeEventListener("battleCancel",onBattleCancel);
         QteSkillGuide.cleanAlert();
         removeBlock();
         if(BattleManager.getInstance().started)
         {
            if(!BattleManager.exitFlag || !BattleManager.loginToBattleFlag)
            {
               _loc1_ = {};
               _loc1_.isShowLoading = false;
               NotificationManager.instance.addEventListener("enterbattlescene",onBattleUILoaded);
               SceneManager.instance.setScene("BATTLE_SCENE",_loc1_);
               BattleManager.exitFlag = false;
               if(_enterBattleEffect)
               {
                  _enterBattleEffect.gotoAndStop(9);
               }
            }
            else
            {
               BattleManager.loginToBattleFlag = false;
            }
         }
      }
      
      private function onBattleUILoaded(param1:BattleEvent) : void
      {
         NotificationManager.instance.removeEventListener("enterbattlescene",onBattleUILoaded);
         BattleModel.battleUILoaded = true;
         TimerUtils.setTimeout(delayShowEffect,20);
         var _loc3_:BattleModel = BattleManager.getInstance().battleModel;
         var _loc2_:CampaignMapModel = CampaignManager.instance.mapModel;
         if(_loc3_ && _loc2_ && WorldBossHelper.checkInAnyMaze(_loc2_.mapId) && MazeModel.instance.isAuto)
         {
            _loc3_.setAutoFight(1);
         }
      }
      
      private function delayShowEffect() : void
      {
         var _loc3_:BattleModel = BattleManager.getInstance().battleModel;
         if(_enterBattleEffect)
         {
            _enterBattleEffect.stop();
            _enterBattleEffect.addFrameScript(7,null);
            if(_enterBattleEffect.parent)
            {
               _enterBattleEffect.parent.removeChild(_enterBattleEffect);
               _enterBattleEffect = null;
            }
         }
         if(_canceled || !_loc3_)
         {
            return;
         }
         var _loc1_:Sprite = LayerManager.Instance.getLayerByType(2);
         var _loc2_:TransSceneEffectContext = new TransSceneEffectContext(_loc1_,effectComplete);
         _loc2_.start();
         BattleManager.getInstance().muiscControl.start();
      }
      
      private function effectComplete() : void
      {
         var _loc1_:BattleModel = BattleManager.getInstance().battleModel;
         if(!_loc1_)
         {
            return;
         }
         _loc1_.transSceneEffectComplete = true;
         if(!StageFocusManager.getInstance().isActivate)
         {
            StageReferance.stage.dispatchEvent(new Event("deactivate"));
         }
         BattleManager.getInstance().plotHandler.activate();
         if(_loc1_.useWay == 0)
         {
            SocketSendManager.instance.sendLoadOver(_loc1_.battleId,PlayerManager.instance.currentPlayerModel.playerInfo.userId);
         }
         else
         {
            SocketSendManager.instance.sendReinfoLoadOver(_loc1_.battleId,PlayerManager.instance.currentPlayerModel.playerInfo.userId);
         }
         NotificationManager.instance.sendNotification("SKILL_ENABLE",true);
         NotificationManager.instance.sendNotification("TransSceneEffectComplete");
      }
   }
}

