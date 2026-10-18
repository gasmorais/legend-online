package battle.skillsys.skills
{
   import battle.actions.common.SimpleScriptAction;
   import battle.data.BufferDamageData;
   import battle.handler.BufferHandler;
   import battle.logsys.BattleLogSystem;
   import battle.skillsys.executer.SkillFrameExecuter;
   import battle.skillsys.mode.framedata.SkillFrameData;
   import battle.skillsys.skills.move.MoveBackContext;
   import battle.skillsys.skills.move.MoveForwardContext;
   import yishi.manager.TempleteManager;
   
   public class CommonActionSkill extends BaseSkill
   {
      
      private var _dannyCount:int;
      
      public function CommonActionSkill()
      {
         super();
      }
      
      override protected function startRun() : void
      {
         if(!getCurrentRole().isLiving && _skillData.skillId != 103)
         {
            actionAttackLeft(0);
            return;
         }
         addPassiveEffectAction();
         addMoveForwardAction();
         addSkillPreEffect();
         _currentRole.addAction(createAttackAction());
         addMoveBackAction();
      }
      
      private function addSkillPreEffect() : void
      {
         var _loc1_:int = TempleteManager.instance.getSkillTemplateInfoById(_skillData.skillId).Priority;
         switch(_loc1_ - 3)
         {
            case 0:
               addProfoundEffect();
               break;
            case 1:
               addProfoundEffect2();
         }
      }
      
      private function addMoveForwardAction() : void
      {
         var _loc1_:MoveForwardContext = null;
         if(battleModel.isHideOtherInBattle(getCurrentRole()))
         {
            endMoveFun();
         }
         else
         {
            _loc1_ = new MoveForwardContext(this,startMoveFun,endMoveFun);
            _loc1_.execute();
         }
      }
      
      private function addMoveBackAction() : void
      {
         var _loc1_:MoveBackContext = new MoveBackContext(this,startMoveFun,endMoveFun);
         _loc1_.execute();
      }
      
      private function createAttackAction() : SimpleScriptAction
      {
         var action:SimpleScriptAction = new SimpleScriptAction(_skillData.liftTime,skillComplete);
         action.onPrepare = function():void
         {
            if(!getCurrentRole().isLiving)
            {
               action.finished = true;
               actionAttackLeft(0);
               return;
            }
            for each(var _loc1_:SkillFrameData in _actionTemplate.frames)
            {
               if(_loc1_.Frame == 0)
               {
                  if(isFrameSexFit(_loc1_))
                  {
                     SkillFrameExecuter.execute(_thisProxy,_loc1_,action);
                     if(!_bufferAdded && _addBufferFrame == 0)
                     {
                        updataSp();
                        addBuffer(0);
                     }
                  }
               }
            }
            setArrangePriority(true);
         };
         action.onUpdate = function():void
         {
            var _loc1_:int = 0;
            started = true;
            if(!getCurrentRole().isLiving)
            {
               action.finished = true;
               actionAttackLeft(_dannyCount + 1);
               return;
            }
            for each(var _loc2_:SkillFrameData in _actionTemplate.frames)
            {
               if(isFrameSexFit(_loc2_))
               {
                  _loc1_ = _loc2_.Frame;
                  if(_loc1_ == action.frameCount)
                  {
                     if(_loc2_.ActionType == 3 || _loc2_.ActionType == 11 || _loc2_.ActionType == 12)
                     {
                        addParryBuffer(_loc2_.effectData.count);
                     }
                     SkillFrameExecuter.execute(_thisProxy,_loc2_,action);
                     if(_loc2_.ActionType == 3 || _loc2_.ActionType == 11 || _loc2_.ActionType == 12)
                     {
                        addBuffer(_loc2_.effectData.count);
                        _dannyCount = _loc2_.effectData.count;
                     }
                  }
                  if(!_bufferAdded && _addBufferFrame == action.frameCount)
                  {
                     updataSp();
                  }
               }
            }
            BattleLogSystem.skillProgress(_thisProxy,3 + action.frameCount);
         };
         return action;
      }
      
      override protected function addParryBuffer(param1:int) : void
      {
         if(param1 > 0)
         {
            return;
         }
         if(_skillData.skillBuffers && _skillData.skillBuffers.length > 0)
         {
            for each(var _loc2_:BufferDamageData in _skillData.skillBuffers)
            {
               if(_loc2_.effectiveType == 4)
               {
                  BufferHandler.processBuffer(_loc2_,_skillData.fId,param1);
               }
            }
         }
      }
   }
}

