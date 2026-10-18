package battle.skillsys.executer
{
   import battle.BattleManager;
   import battle.actions.DisplacementAction;
   import battle.actions.HideRoleAction;
   import battle.actions.common.SimpleScriptAction;
   import battle.data.AttackData;
   import battle.data.DannyEffectData;
   import battle.handler.NoviceReinforceHandler;
   import battle.logsys.BattleLogSystem;
   import battle.skillsys.effect.SkillEffect;
   import battle.skillsys.mode.framedata.ColorTransformFrameData;
   import battle.skillsys.mode.framedata.SkillFrameData;
   import battle.skillsys.skills.BaseSkill;
   import battle.utils.BattleUtils;
   import com.greensock.TweenLite;
   import flash.geom.Point;
   import yishi.datas.BattleModel;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.objects.PetRoleInfo;
   import yishi.datas.objects.RoleInfo;
   import yishi.manager.SharedManager;
   import yishi.utils.TimerUtils;
   
   public class SkillFrameExecuter
   {
      
      private var _skill:BaseSkill;
      
      private var _frameData:SkillFrameData;
      
      private var _action:SimpleScriptAction;
      
      private var _currentRole:RoleInfo;
      
      private var _attackData:Array;
      
      public function SkillFrameExecuter(param1:BaseSkill, param2:SkillFrameData, param3:SimpleScriptAction)
      {
         super();
         _skill = param1;
         _frameData = param2;
         _action = param3;
         _currentRole = param1.getCurrentRole();
         _attackData = param1.getSkillData().data;
      }
      
      public static function execute(param1:BaseSkill, param2:SkillFrameData, param3:SimpleScriptAction) : void
      {
         var _loc4_:SkillFrameExecuter = new SkillFrameExecuter(param1,param2,param3);
         _loc4_.run();
      }
      
      private function run() : void
      {
         switch(_frameData.ActionType)
         {
            case 1:
               playAttackAction();
               break;
            case 2:
               addReleaseEffect();
               break;
            case 3:
               addDanny();
               break;
            case 4:
               zoomMap();
               break;
            case 5:
               addGasEffect();
               break;
            case 6:
               playBgColorEffect();
               break;
            case 7:
               playBgShockEffect();
               break;
            case 99:
               finish();
               break;
            case 23:
               displacementForward();
               break;
            case 24:
               displacementBack();
               break;
            case 25:
               hideRole();
         }
      }
      
      private function playAttackAction() : void
      {
         var _loc1_:String = _frameData.attackLabel;
         _currentRole.action(_loc1_,"WAIT_AND_GOTO","Stand",12);
      }
      
      private function addReleaseEffect() : void
      {
         addEffect(false);
      }
      
      private function addGasEffect() : void
      {
         addEffect(true);
      }
      
      private function addEffect(param1:Boolean = false) : void
      {
         var _loc2_:int = 0;
         var _loc4_:Boolean = false;
         var _loc5_:Point = null;
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         var _loc10_:AttackData = null;
         var _loc3_:RoleInfo = null;
         if(battleModel.isHideOtherInBattle(_currentRole))
         {
            return;
         }
         var _loc9_:String = _frameData.effectData.effectRes;
         var _loc6_:SkillEffect = new SkillEffect(_loc9_);
         if(_frameData.effectData.type == 1)
         {
            if(param1)
            {
               _loc6_.getDisplayObject().x = _currentRole.point.x + _frameData.effectData.posX;
               _loc6_.getDisplayObject().y = _currentRole.point.y + _frameData.effectData.posY;
               _currentRole.map.addGasEffect(_loc6_);
            }
            else
            {
               _loc6_.getDisplayObject().x = _frameData.effectData.posX;
               _loc6_.getDisplayObject().y = _frameData.effectData.posY;
               _currentRole.view.addEffect(_loc6_,1,_frameData.effectData.arrange);
            }
         }
         else if(_frameData.effectData.type == 0)
         {
            _loc2_ = _frameData.effectData.target;
            if(_loc2_ == 0)
            {
               _loc2_ = 5;
            }
            _loc4_ = _currentRole.face == 2 ? true : false;
            _loc5_ = _loc4_ ? BattleUtils.getPosition(1,_loc2_) : BattleUtils.getPosition(2,_loc2_);
            _loc6_.getDisplayObject().scaleX = _loc4_ ? -1 : 1;
            _loc6_.getDisplayObject().x = _loc5_.x;
            _loc6_.getDisplayObject().y = _loc5_.y;
            if(param1)
            {
               _currentRole.map.addGasEffect(_loc6_);
            }
            else
            {
               _currentRole.map.addEffect(_loc6_,1,_frameData.effectData.arrange);
            }
         }
         else if(_frameData.effectData.type == 2)
         {
            _loc7_ = _attackData[0];
            _loc8_ = 0;
            while(_loc8_ < _loc7_.length)
            {
               _loc10_ = AttackData(_loc7_[_loc8_]);
               _loc3_ = battleModel.getRoleById(_loc10_.roleId);
               if(_loc3_ && SharedManager.instance.allowAttactedEffect)
               {
                  if(param1 && _loc3_.map)
                  {
                     _loc6_.getDisplayObject().x = _loc3_.point.x + _frameData.effectData.posX;
                     _loc6_.getDisplayObject().y = _loc3_.point.y + _frameData.effectData.posY;
                     _loc3_.map.addGasEffect(_loc6_);
                  }
                  else if(_loc3_.view)
                  {
                     _loc6_.getDisplayObject().x = _frameData.effectData.posX;
                     _loc6_.getDisplayObject().y = _frameData.effectData.posY;
                     _loc3_.view.addEffect(_loc6_,1,_frameData.effectData.arrange);
                  }
               }
               _loc8_++;
            }
         }
      }
      
      private function playBgColorEffect() : void
      {
         if(battleModel.isHideOtherInBattle(_currentRole))
         {
            return;
         }
         var _loc1_:ColorTransformFrameData = _frameData.bgColorData;
         _currentRole.map.backGroundToColor(_loc1_.color,_loc1_.tweenTime,_loc1_.stopTime,_loc1_.atOnceBool,_loc1_.isReduce);
      }
      
      private function playBgShockEffect() : void
      {
         if(battleModel.isHideOtherInBattle(_currentRole))
         {
            return;
         }
         _currentRole.map.shakeScreen(_frameData.bgShockData.time,_frameData.bgShockData.range);
      }
      
      private function addDanny() : void
      {
         var _loc3_:Boolean = false;
         var _loc1_:DannyEffectData = null;
         if(_skill.getCurrentRole() == BattleManager.getInstance().battleModel.selfHero)
         {
            _loc3_ = true;
         }
         if(_skill.actionId == 700001)
         {
            morph();
         }
         else if(_skill.actionId == 700002)
         {
            unMorph();
         }
         if(_skill.actionId == 700003)
         {
            ChildMorph();
         }
         else if(_skill.actionId == 700004)
         {
            ChildUnMorph();
         }
         var _loc2_:Boolean = battleModel.isHideOtherInBattle(_skill.getCurrentRole());
         if(_frameData.effectData.effectRes && _frameData.effectData.effectRes.length > 1 && !_loc2_)
         {
            _loc1_ = new DannyEffectData();
            _loc1_.effect = _frameData.effectData.effectRes;
            _loc1_.x = _frameData.effectData.posX;
            _loc1_.y = _frameData.effectData.posY;
            _loc1_.isPlayEffect = !battleModel.checkSelfTeam(_skill.getCurrentRole());
            BattleUtils.addSingleDannyTakeEffect(_attackData[_frameData.effectData.count],_loc1_,12,true,_frameData.effectData.backDistance,0,4,true,6710886,true,_loc3_,_frameData.effectData.delayBleed,_skill.getSkillData().skillId);
         }
         else
         {
            BattleUtils.addSingleDanny(_attackData[_frameData.effectData.count],12,true,_frameData.effectData.backDistance,0,4,true,6710886,true,_loc3_,_frameData.effectData.delayBleed,_skill.getSkillData().skillId);
         }
         BattleLogSystem.skillDannyFlag(_skill);
      }
      
      private function morph() : void
      {
         var _loc1_:HeroRoleInfo = null;
         var _loc2_:PetRoleInfo = null;
         if(_skill.getCurrentRole() is HeroRoleInfo)
         {
            _loc1_ = _skill.getCurrentRole() as HeroRoleInfo;
            _loc2_ = _loc1_.petRoleInfo;
            if(_loc1_ && _loc2_)
            {
               _loc1_.isPetState = true;
            }
         }
      }
      
      private function unMorph() : void
      {
         var _loc1_:HeroRoleInfo = null;
         var _loc2_:PetRoleInfo = null;
         if(_skill.getCurrentRole() is HeroRoleInfo)
         {
            _loc1_ = _skill.getCurrentRole() as HeroRoleInfo;
            _loc2_ = _loc1_.petRoleInfo;
            if(_loc1_ && _loc2_)
            {
               _loc1_.isPetState = false;
            }
         }
      }
      
      private function ChildMorph() : void
      {
         var _loc1_:HeroRoleInfo = null;
         if(_skill.getCurrentRole() is HeroRoleInfo)
         {
            _loc1_ = _skill.getCurrentRole() as HeroRoleInfo;
            if(_loc1_ && _loc1_.isChildFake)
            {
               _loc1_.isPetState = true;
            }
         }
      }
      
      private function ChildUnMorph() : void
      {
         var _loc1_:HeroRoleInfo = null;
         var _loc2_:PetRoleInfo = null;
         if(_skill.getCurrentRole() is HeroRoleInfo)
         {
            _loc1_ = _skill.getCurrentRole() as HeroRoleInfo;
            _loc2_ = _loc1_.petRoleInfo;
            if(_loc1_ && _loc2_)
            {
               _loc1_.isPetState = false;
            }
         }
      }
      
      private function zoomMap() : void
      {
         var point:Point;
         var zoomInComplete:* = function():void
         {
            if(_frameData.zoomData.stopTime > 0)
            {
               TimerUtils.setTimeout(backZoomStart,_frameData.zoomData.stopTime * 1000);
            }
            else
            {
               backZoomStart();
            }
         };
         var backZoomStart:* = function():void
         {
            TweenLite.to(_currentRole.map,_frameData.zoomData.backTime,{
               "zoom":1,
               "overwrite":0
            });
            _currentRole.map.setCamera(new Point(650,NoviceReinforceHandler.CAMERA_Y),_frameData.zoomData.backTime);
         };
         TweenLite.to(_currentRole.map,_frameData.zoomData.zoomTime,{
            "zoom":_frameData.zoomData.zoom,
            "overwrite":0,
            "onComplete":zoomInComplete
         });
         if(_frameData.zoomData.zoomType == 1)
         {
            point = _currentRole.point.clone();
            point.x += _frameData.zoomData.posX;
            point.y += _frameData.zoomData.posY;
            _currentRole.map.setCamera(point,_frameData.zoomData.zoomTime);
         }
      }
      
      private function displacementForward() : void
      {
         new DisplacementAction(_currentRole,_frameData.displacementForward,_skill);
      }
      
      private function displacementBack() : void
      {
         new DisplacementAction(_currentRole,_frameData.displacementBack,_skill);
      }
      
      private function hideRole() : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:AttackData = null;
         var _loc1_:RoleInfo = null;
         if(_frameData.hideData.target == 0)
         {
            _loc2_ = _attackData[0];
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc4_ = AttackData(_loc2_[_loc3_]);
               _loc1_ = BattleManager.getInstance().battleModel.getRoleById(_loc4_.roleId);
               if(_loc1_)
               {
                  new HideRoleAction(_loc1_,_frameData.hideData);
               }
               _loc3_++;
            }
         }
         else
         {
            new HideRoleAction(_currentRole,_frameData.hideData);
         }
      }
      
      private function finish() : void
      {
         if(_action)
         {
            _action.finish();
         }
      }
      
      private function get battleModel() : BattleModel
      {
         return BattleManager.getInstance().battleModel;
      }
   }
}

