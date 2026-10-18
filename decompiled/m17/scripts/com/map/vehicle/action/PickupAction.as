package com.map.vehicle.action
{
   import com.greensock.TweenMax;
   import com.map.vehicle.net.VehicleSocketOutManager;
   import com.map.vehicle.objects.TankAvatarView;
   import com.map.vehicle.objects.VehicleBoxView;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.mapengine.bitmap.logic.BitmapSimpleLogic;
   import flash.display.MovieClip;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.view.tips.MessageTipManager;
   
   public class PickupAction extends BaseVehicleAction
   {
      
      private var _pickMc:MovieClip;
      
      private var _pickuper:TankAvatarView;
      
      private var _target:VehicleBoxView;
      
      private var _stage:Stage;
      
      private var _tween:TweenMax;
      
      private var _pickupStartTime:Number = 0;
      
      private var _isPickuped:Boolean = false;
      
      public function PickupAction(param1:BitmapSimpleLogic, param2:BitmapSimpleLogic)
      {
         super();
         _pickuper = param1 as TankAvatarView;
         _target = param2 as VehicleBoxView;
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
            _pickuper.stop();
            VehicleSocketOutManager.instance.sendCampaignArmyMove(_pickuper.data.playerId,[_pickuper.getTilePoint()]);
         }
         if(_pickuper.data.hp <= 0)
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
            _pickuper.data.addEventListener("BREAK_PICKUP",__onBreakHandler);
         }
      }
      
      private function __tweenUpdate() : void
      {
         if(!_isPickuped && getTimer() - _pickupStartTime >= 800)
         {
            if(_target)
            {
               VehicleSocketOutManager.instance.sendPickup(_target.data.nodeId);
               _isPickuped = true;
               if(_pickuper && _pickuper.isSelf && _target.data.type == 2)
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
            _pickuper.data.removeEventListener("BREAK_PICKUP",__onBreakHandler);
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
         var _loc1_:String = null;
         if(_finished)
         {
            return;
         }
         if(_isPickuped)
         {
            return;
         }
         if(!_target)
         {
            dispose();
            beBreak();
            return;
         }
         if(!_isPickuped && _target.data.state == 1)
         {
            _loc1_ = LanguageMgr.GetTranslation("vehicle.noTarget");
            MessageTipManager.instance().show(_loc1_);
            dispose();
            return;
         }
         if(_pickuper.data.isStun || _pickuper.path && _pickuper.path.length > 0)
         {
            beBreak();
            dispose();
            return;
         }
      }
      
      private function beBreak() : void
      {
         var _loc1_:String = LanguageMgr.GetTranslation("vehicle.pickupBreak");
         MessageTipManager.instance().show(_loc1_);
      }
   }
}

