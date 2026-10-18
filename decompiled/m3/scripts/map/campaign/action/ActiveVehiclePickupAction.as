package map.campaign.action
{
   import com.greensock.TweenMax;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.MovieClip;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignMapController;
   import map.campaign.CampaignSocketOutManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.view.physics.ActiveVehicleArmyView;
   import map.internals.data.CampaignNode;
   import yishi.actions.map.MapBaseAction;
   import yishi.interfaces.IAction;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.scene.SceneManager;
   import yishi.view.tips.MessageTipManager;
   
   public class ActiveVehiclePickupAction extends MapBaseAction
   {
      
      private var _pickMc:MovieClip;
      
      private var _pickuper:ActiveVehicleArmyView;
      
      private var _armyInfo:CampaignArmy;
      
      private var _target:CampaignNode;
      
      private var _stage:Stage;
      
      private var _tween:TweenMax;
      
      private var _controller:CampaignMapController;
      
      private var _pickupStartTime:Number = 0;
      
      private var _isPickuped:Boolean = false;
      
      public function ActiveVehiclePickupAction(param1:CampaignArmy, param2:CampaignNode)
      {
         super();
         _controller = CampaignManager.instance.controller;
         _armyInfo = param1;
         if(_controller)
         {
            _pickuper = _controller.getArmyView(param1) as ActiveVehicleArmyView;
         }
         _target = param2;
         _stage = StageReferance.stage;
         KeyBoardRegister.instance.battleFlag = false;
      }
      
      override public function cancel() : void
      {
      }
      
      override public function prepare() : void
      {
         startPickup();
      }
      
      private function __stageResizeHandler(param1:Event = null) : void
      {
         if(_pickMc)
         {
            _pickMc.x = (StageReferance.stageWidth - _pickMc.width) / 2;
            _pickMc.y = StageReferance.stageHeight - 200;
         }
      }
      
      private function startPickup() : void
      {
         var _loc1_:String = null;
         if(_pickuper && _pickuper.data)
         {
            _pickuper.data.isPickup = true;
            _pickuper.aiInfo.pathInfo = [];
         }
         if(_armyInfo.activeCurHp <= 0)
         {
            _loc1_ = LanguageMgr.GetTranslation("vehicle.waitRiver");
            MessageTipManager.instance().show(_loc1_);
            dispose();
            return;
         }
         _pickMc = ComponentFactory.Instance.creat("asset.core.CollectionAsset");
         if(_pickMc["stateMc"])
         {
            (_pickMc["stateMc"] as MovieClip).gotoAndStop(5);
         }
         LayerManager.Instance.addToLayer(_pickMc,3,false);
         _pickupStartTime = getTimer();
         _tween = TweenMax.to(_pickMc,1.5,{
            "frame":_pickMc.totalFrames,
            "onUpdate":__tweenUpdate,
            "onComplete":__successHandler
         });
         __stageResizeHandler();
         if(_stage)
         {
            _stage.addEventListener("resize",__stageResizeHandler);
         }
         if(_pickuper && _pickuper.data)
         {
            _pickuper.data.addEventListener("BREAK_ACTION",__onBreakHandler);
         }
      }
      
      private function __tweenUpdate() : void
      {
         if(_isPickuped)
         {
            return;
         }
         if(finished)
         {
            return;
         }
         if(getTimer() - _pickupStartTime >= 800)
         {
            if(_target)
            {
               CampaignSocketOutManager.instance.sendSnowBallActiveVehiclePickup(_target.nodeId,_armyInfo.baseHero.serviceName);
               _isPickuped = true;
               if(_pickuper)
               {
                  SoundManager.instance.play("010");
               }
            }
         }
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.battleFlag = false;
         if(_pickuper && _pickuper.data)
         {
            _pickuper.data.isPickup = false;
            _pickuper.data.removeEventListener("BREAK_ACTION",__onBreakHandler);
         }
         if(_stage)
         {
            _stage.removeEventListener("resize",__stageResizeHandler);
         }
         if(_tween)
         {
            _tween.kill();
         }
         if(_pickMc)
         {
            _pickMc.stop();
            ObjectUtils.disposeObject(_pickMc);
            TweenMax.killTweensOf(_pickMc);
         }
         _pickMc = null;
         _tween = null;
         _pickuper = null;
         _stage = null;
         _target = null;
         finished = true;
         super.dispose();
      }
      
      private function __onBreakHandler(param1:Event) : void
      {
         dispose();
      }
      
      private function __successHandler() : void
      {
         dispose();
      }
      
      override public function update() : void
      {
         if(_finished)
         {
            return;
         }
         if(_isPickuped)
         {
            return;
         }
         if(_pickuper.isDie)
         {
            dispose();
            return;
         }
         if(_armyInfo.activeCurHp <= 0)
         {
            dispose();
            return;
         }
         if(SceneManager.instance.currentType != "CAMPAIGN_MAP_SCENE")
         {
            dispose();
            return;
         }
         if(!_target)
         {
            pickFailed();
            dispose();
            return;
         }
         if(_target.info.state == 8)
         {
            pickFailed();
            dispose();
            return;
         }
         if(_armyInfo.isStun)
         {
            beBreak();
            dispose();
            return;
         }
         if(_pickuper.aiInfo.pathInfo && _pickuper.aiInfo.pathInfo.length > 0)
         {
            beBreak();
            dispose();
            return;
         }
      }
      
      private function pickFailed() : void
      {
         var _loc1_:String = LanguageMgr.GetTranslation("vehicle.noTarget");
         MessageTipManager.instance().show(_loc1_);
      }
      
      private function beBreak() : void
      {
         var _loc1_:String = LanguageMgr.GetTranslation("vehicle.pickupBreak");
         MessageTipManager.instance().show(_loc1_);
      }
      
      override public function get type() : String
      {
         return "ActiveVehiclePickupAction";
      }
      
      override public function replace(param1:IAction) : Boolean
      {
         if(param1 is ActiveVehicleJumpCastAction)
         {
            return true;
         }
         if(param1 is ActiveVehicleJumpAction)
         {
            return true;
         }
         return false;
      }
   }
}

