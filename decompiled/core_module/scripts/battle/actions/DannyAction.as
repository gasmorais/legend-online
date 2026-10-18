package battle.actions
{
   import battle.BattleManager;
   import battle.actions.common.SimpleScriptAction;
   import battle.data.AttackData;
   import battle.data.ReliveInfo;
   import battle.skillsys.effect.MovieClipEffect;
   import battle.utils.BattleUtils;
   import battle.view.roles.HeroRoleView;
   import chat.ChatManager;
   import chat.datas.ChatData;
   import com.road.yishi.proto.battle.DropInfoMsg;
   import flash.display.MovieClip;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import map.campaign.data.TrailPropInfo;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.objects.MonsterRoleInfo;
   import yishi.datas.objects.RoleInfo;
   import yishi.datas.objects.SelfChessRoleInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.interfaces.IAction;
   import yishi.manager.BaseManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.TimerUtils;
   
   public class DannyAction extends GameBaseAction
   {
      
      private static const PERCENTAGE_GRAVITY_TO_PIXEL:Number = 0.3;
      
      private static var gravity:Number = 10;
      
      public static var SHAKE_OFFSET:int = 2;
      
      private var _frame:int;
      
      private var _time:int;
      
      private var _data:AttackData;
      
      private var _distance:int;
      
      private var _backDust:MovieClip;
      
      private var _over:Boolean = false;
      
      private var _flyUpPower:Number;
      
      private var _currentPower:Number;
      
      private var _restShakeCount:int;
      
      private var _currentShakeOff:int;
      
      private var face:int;
      
      private var toPoint:Point;
      
      private var toPointZ:Number;
      
      private var _currentXOffset:Number;
      
      private var _endPoint:Point;
      
      private var _flash:Boolean;
      
      private var _flashColor:uint;
      
      private var _oldColorTransForm:ColorTransform;
      
      private var _playActBool:Boolean;
      
      private var _selfCause:Boolean;
      
      private var _isMoving:Boolean;
      
      private var _skillId:int;
      
      private var _needPlayDieAction:Boolean;
      
      public function DannyAction(param1:RoleInfo, param2:AttackData, param3:int = 12, param4:Boolean = true, param5:int = 0, param6:Number = 0, param7:int = 4, param8:Boolean = true, param9:uint = 6710886, param10:Boolean = true, param11:Boolean = false, param12:int = -1)
      {
         super();
         _data = param2;
         _currentRole = param1;
         if(_currentRole.realBloodA == 0 && param2.damageValue == 0 && _data.bloodType != 10)
         {
            return;
         }
         if(!_currentRole || !_currentRole.actionManager)
         {
            return;
         }
         _frame = param3;
         _distance = param5;
         if(_currentRole.actionManager.current is MovePointAction)
         {
            _isMoving = true;
            _distance = 0;
         }
         _flyUpPower = param6;
         _currentPower = param6;
         _restShakeCount = param7;
         _currentShakeOff = SHAKE_OFFSET;
         _time = 0;
         _flash = param8;
         _flashColor = param9;
         _playActBool = param10 && _data.damageValue != 0;
         _selfCause = param11;
         _skillId = param12;
         resolveIsPlayAct();
         playDenfence();
         initHurt();
         prepare();
         _currentRole.addConcurrentAction(this);
      }
      
      private function initHurt() : void
      {
         var _loc3_:Boolean = false;
         var _loc5_:HeroRoleInfo = null;
         if(_flash)
         {
            if(_data && _data.damageValue > 0)
            {
               if(_currentRole.view && _currentRole.view.movieContainer)
               {
                  _oldColorTransForm = _currentRole.view.movieContainer.transform.colorTransform;
                  _currentRole.view.movieContainer.transform.colorTransform = new ColorTransform(1,1,1,1,(_flashColor & 0xFF0000) >>> 16,(_flashColor & 0xFF00) >>> 8,_flashColor & 0xFF);
               }
            }
         }
         if(_playActBool)
         {
            _currentRole.action("Danny","STOP");
         }
         var _loc2_:Boolean = Boolean(_data.extraData & 1);
         var _loc4_:SkillTempInfo = TempleteManager.instance.getSkillTemplateInfoById(_skillId);
         if(!_loc4_ || _loc4_.UseWay == 3)
         {
            _loc3_ = true;
         }
         if(!(BattleManager.getInstance().battleModel && BattleManager.getInstance().battleModel.battleType == 17 && BaseManager.instance.wordBossInvincibleState && _currentRole is HeroRoleInfo && HeroRoleInfo(_currentRole).type == 3 && _currentRole.face == 2))
         {
            _currentRole.totalBloodA -= _data.hpMaxAdd;
            _currentRole.updateBlood(-_data.damageValue,-_data.displayBlood,_loc2_,_data.bloodType,_selfCause,_loc3_,_data.parry,_data.fire);
         }
         var _loc1_:String = _loc4_ ? _loc4_.TemplateName : "";
         if(_currentRole.realBloodA == 0 && _data.damageValue != 0)
         {
            _needPlayDieAction = true;
         }
         if(_currentRole.side == 1)
         {
            BattleManager.getInstance().batterModel.lock = true;
            BattleManager.getInstance().batterModel.isStart = false;
         }
         else
         {
            BattleManager.getInstance().batterModel.isStart = true;
         }
         if(_data.damageValue != 0 && (_data.bloodType == 6 || _data.bloodType == 7))
         {
            BattleManager.getInstance().batterModel.batterCount = BattleManager.getInstance().batterModel.batterCount + 1;
         }
         if(_data.bloodType == 10)
         {
            _loc5_ = BattleManager.getInstance().battleModel.getRoleById(_data.roleId) as HeroRoleInfo;
            if(HeroRoleInfo(_loc5_).type == 3)
            {
               revierBoss(_loc5_);
            }
            else
            {
               revierRole(_loc5_);
            }
         }
         NotificationManager.instance.sendNotification("BUFFER_SKILL_ENABLE");
         BattleManager.getInstance().batterModel.damageTotal = BattleManager.getInstance().batterModel.damageTotal + _data.displayBlood;
      }
      
      private function revierBoss(param1:RoleInfo) : void
      {
         param1.isLiving = true;
         param1.riveve = true;
         param1.dying = false;
         if(param1.view)
         {
            param1.view.setRoleInfoViewVisible(true);
            if(param1.map != undefined)
            {
               param1.map.revierBoss(param1.view);
            }
            else
            {
               BattleManager.getInstance().battleMap.addRole(param1.view);
            }
         }
         param1.action("Stand","REPEAT");
         var _loc2_:ChatData = new ChatData();
         _loc2_.channel = 3;
         _loc2_.type = 1;
         _loc2_.msg = LanguageMgr.GetTranslation("battle.actions.DannyAction.ChatDataMsg");
         _loc2_.commit();
         ChatManager.instance.model.addChat(_loc2_);
         BattleManager.getInstance().battleModel.isOver = false;
      }
      
      private function revierRole(param1:RoleInfo) : void
      {
         param1.isLiving = true;
         param1.riveve = true;
         if(param1.view)
         {
            param1.view.setRoleInfoViewVisible(true);
         }
         param1.action("Stand","REPEAT");
         if(param1 is HeroRoleInfo && (param1 as HeroRoleInfo).petRoleInfo != null)
         {
            (param1 as HeroRoleInfo).petRoleInfo.action("Stand","REPEAT");
         }
         BattleManager.getInstance().battleModel.isOver = false;
         if(param1 == BattleManager.getInstance().battleModel.selfHero)
         {
            NotificationManager.instance.sendNotification("SKILL_ENABLE",true);
         }
      }
      
      private function resolveIsPlayAct() : void
      {
         if(_playActBool)
         {
            if(_currentRole.actionMovie.currentLabels != "Stand")
            {
               _playActBool = false;
            }
            else if(!_data || _data.damageValue <= 0)
            {
               _playActBool = false;
            }
         }
      }
      
      private function playDenfence() : void
      {
      }
      
      override public function prepare() : void
      {
         face = _currentRole.face == 1 ? -1 : 1;
         var _loc1_:Point = BattleUtils.rolePointByPos(_currentRole.pos,_currentRole.face);
         var _loc2_:int = 80;
         var _loc3_:int = _currentRole.point.x + _distance * face;
         if(_currentRole.face == 1)
         {
            if(_loc3_ < _loc1_.x - _loc2_)
            {
               _loc3_ = _loc1_.x - _loc2_;
            }
         }
         else if(_loc3_ > _loc1_.x + _loc2_)
         {
            _loc3_ = _loc1_.x + _loc2_;
         }
         _endPoint = new Point(_loc3_,_currentRole.point.y);
      }
      
      override public function update() : void
      {
         _time = _time + 1;
         if(_time >= _frame)
         {
            if(!_over)
            {
               actionOver();
            }
            return;
         }
         if(_time == 10)
         {
            if(_currentRole.view)
            {
               _currentRole.view.setColorTransform(_currentRole.attackMode);
            }
         }
         if(!_finished && !_isMoving)
         {
            toPoint = new Point(_currentRole.point.x + 0.5 * (_endPoint.x - _currentRole.point.x),_currentRole.point.y);
            toPointZ = _currentRole.pointZ + _currentPower * 0.3;
            if(toPointZ <= 0)
            {
               toPointZ = 0;
            }
            else
            {
               _currentPower -= gravity;
            }
            if(_playActBool && _restShakeCount > 0)
            {
               if(_currentShakeOff < 0)
               {
                  _restShakeCount = _restShakeCount - 1;
               }
               toPoint.x += _currentShakeOff;
               _currentShakeOff = -_currentShakeOff;
            }
            if(_playActBool)
            {
               _currentRole.point = toPoint;
               _currentRole.pointZ = toPointZ;
            }
            if(_backDust)
            {
               _backDust.x = _currentRole.point.x;
               _backDust.y = _currentRole.point.y;
            }
         }
      }
      
      private function initBackDust() : void
      {
      }
      
      private function removeBackDust() : void
      {
         if(_backDust)
         {
            if(_backDust.parent)
            {
               _backDust.parent.removeChild(_backDust);
            }
         }
         _backDust = null;
      }
      
      override public function synchronization() : void
      {
         _time = 0;
         actionOver();
      }
      
      override public function replace(param1:IAction) : Boolean
      {
         return param1 is DannyAction;
      }
      
      override protected function actionOver() : void
      {
         var _loc1_:Point = null;
         if(_over)
         {
            return;
         }
         _over = true;
         if(_playActBool && !isAttacking())
         {
            _currentRole.action("Stand","REPEAT");
         }
         if(_oldColorTransForm)
         {
            if(_currentRole.view)
            {
               _currentRole.view.setColorTransform(_currentRole.attackMode);
            }
         }
         _loc1_ = BattleUtils.rolePointByPos(_currentRole.pos,_currentRole.face);
         _finished = true;
         if(_needPlayDieAction)
         {
            playDie();
         }
         else if(_distance != 0)
         {
            new MovePointAction(_currentRole.livingId,_loc1_,20,0,false,false,true,false,null,null,false);
         }
         else if(!_isMoving && _playActBool)
         {
            _currentRole.point = _loc1_;
            _currentRole.point = _loc1_;
         }
         playDrop();
         removeBackDust();
      }
      
      private function playDie() : void
      {
         var hero:HeroRoleInfo;
         var heroView:HeroRoleView;
         var mc:MovieClip;
         var effectAct:MovieClipEffect;
         var foo:Function;
         var foo2:Function;
         var isSelfchess:Boolean = Boolean(_currentRole as SelfChessRoleInfo);
         if(_currentRole is MonsterRoleInfo)
         {
            playMonsteDie();
         }
         else if(!isSelfchess && _currentRole is HeroRoleInfo && HeroRoleInfo(_currentRole).type != 3)
         {
            if(_currentRole.currentAction != "Failed")
            {
               hero = _currentRole as HeroRoleInfo;
               heroView = hero.view as HeroRoleView;
               if(heroView.isChangeBody && !hero.isPetFake)
               {
                  hero.updateAwaken(0);
                  if(hero.isChildFake)
                  {
                     hero.updateChildChangeValue(0);
                  }
                  if(!battleModel.isHideOtherInBattle(hero))
                  {
                     mc = createMovie("pet.changeback");
                     if(mc && !hero.isChildFake)
                     {
                        mc.y = -100;
                        effectAct = new MovieClipEffect(mc);
                        heroView.effectContainer.addEffect(effectAct);
                        foo = function():void
                        {
                           hero.isPetState = false;
                           playHeroDie();
                        };
                        TimerUtils.setTimeout(foo,640);
                     }
                     else
                     {
                        playHeroDie();
                     }
                  }
                  else
                  {
                     foo2 = function():void
                     {
                        hero.isPetState = false;
                        playHeroDie();
                     };
                     TimerUtils.setTimeout(foo2,640);
                  }
               }
               else
               {
                  playHeroDie();
               }
            }
         }
         else if(!(BattleManager.getInstance().battleModel && BattleManager.getInstance().battleModel.battleType == 17 && BaseManager.instance.wordBossInvincibleState && _currentRole is HeroRoleInfo && HeroRoleInfo(_currentRole).type == 3 && _currentRole.face == 2))
         {
            if(_currentRole.isLiving)
            {
               new DieAction(_currentRole);
            }
         }
      }
      
      private function createMovie(param1:String) : MovieClip
      {
         return BattleManager.getInstance().resourceModel.getOrCreateInstanse(param1) as MovieClip;
      }
      
      private function playHeroDie() : void
      {
         var _loc1_:MonsterRoleInfo = null;
         if(!(_currentRole is HeroRoleInfo))
         {
            return;
         }
         if(!BattleManager.getInstance().resourceModel)
         {
            return;
         }
         var _loc2_:HeroRoleInfo = _currentRole as HeroRoleInfo;
         if(_currentRole.view)
         {
            _currentRole.view.removeCollectionEffect();
            if(_loc2_)
            {
               (_currentRole.view as HeroRoleView).removeChildChangeEffect();
            }
         }
         if(!_loc2_.isPetFake)
         {
            _loc2_.isPetState = false;
         }
         _currentRole.action("Failed","STOP");
         _currentRole.setAttactDirection();
         _currentRole.cleanBuffers();
         _currentRole.isLiving = false;
         if(_loc2_.petRoleInfo)
         {
            _loc2_.petRoleInfo.action("Stand","STOP");
         }
         if(battleModel.checkAllDieByRole(_loc2_))
         {
            _loc1_ = battleModel.getMonsterInfoByRole(_loc2_);
            if(_loc1_)
            {
               if(_loc1_.view)
               {
                  _loc1_.view.heroNameTxt.text = "";
               }
               _loc1_.action("Die","STOP");
            }
         }
         if(_loc2_.reliveInfo)
         {
            reliveRole(_loc2_);
            _loc2_.reliveInfo = null;
         }
      }
      
      private function playMonsteDie() : void
      {
         if(!(_currentRole is MonsterRoleInfo))
         {
            return;
         }
         if(!BattleManager.getInstance().resourceModel)
         {
            return;
         }
         var _loc1_:MonsterRoleInfo = _currentRole as MonsterRoleInfo;
         if(_currentRole.view)
         {
            _currentRole.view.removeCollectionEffect();
            _currentRole.view.setBloodStripVisible(false,false);
            _currentRole.view.heroNameTxt.text = "";
         }
         _currentRole.action("Die","STOP");
         _currentRole.setAttactDirection();
         _currentRole.cleanBuffers();
         _currentRole.isLiving = false;
      }
      
      protected function reliveRole(param1:RoleInfo) : void
      {
         var reliveInfo:ReliveInfo;
         var reliveFun:Function;
         var prpare:Function;
         var act:SimpleScriptAction;
         var roleInfo:RoleInfo = param1;
         if(!roleInfo)
         {
            return;
         }
         if(!roleInfo.reliveInfo)
         {
            return;
         }
         reliveInfo = roleInfo.reliveInfo;
         if(reliveInfo.battleId != battleModel.battleId)
         {
            return;
         }
         reliveFun = function():void
         {
            roleInfo.updateBlood(reliveInfo.hp,reliveInfo.hp,false,6);
            if(roleInfo is HeroRoleInfo)
            {
               (roleInfo as HeroRoleInfo).updateSp(reliveInfo.sp,false,false);
               (roleInfo as HeroRoleInfo).updateHitPoint(reliveInfo.hitPoint,false,false);
               (roleInfo as HeroRoleInfo).updateBelief(0);
            }
            revierRole(roleInfo);
         };
         prpare = function():void
         {
            var _loc2_:MovieClip = null;
            var _loc1_:MovieClipEffect = null;
            if(roleInfo.view)
            {
               if(!BattleManager.getInstance().resourceModel)
               {
                  return;
               }
               if(battleModel.isHideOtherInBattle(roleInfo))
               {
                  return;
               }
               _loc2_ = BattleManager.getInstance().resourceModel.getOrCreateInstanse("buff.action.cure3") as MovieClip;
               _loc1_ = new MovieClipEffect(_loc2_);
               roleInfo.view.effectContainer.addEffect(_loc1_);
            }
         };
         act = new SimpleScriptAction(0,null,50);
         act.onUpdate = function():void
         {
            if(act.frameCount == 5)
            {
               if(roleInfo is HeroRoleInfo)
               {
                  (roleInfo as HeroRoleInfo).updateSp(0,false,false);
                  (roleInfo as HeroRoleInfo).updateHitPoint(0,false,false);
                  (roleInfo as HeroRoleInfo).updateBelief(0);
               }
            }
            if(act.frameCount == 15)
            {
               prpare();
            }
            else if(act.frameCount == 24)
            {
               reliveFun();
            }
         };
         roleInfo.addAction(act,true);
      }
      
      private function playDrop() : void
      {
         var _loc2_:HeroRoleInfo = null;
         var _loc1_:TrailPropInfo = null;
         if(_data.dropList && _data.dropList.length > 0)
         {
            _loc2_ = BattleManager.getInstance().battleModel.selfHero;
            for each(var _loc4_:DropInfoMsg in _data.dropList)
            {
               if(_loc4_.winnerIds && _loc4_.winnerIds.length > 0)
               {
                  for each(var _loc3_:int in _loc4_.winnerIds)
                  {
                     if(_loc2_.livingId == _loc3_)
                     {
                        _loc1_ = _loc2_.getTrialPropInfoById(_loc4_.dropId);
                        if(_loc1_)
                        {
                           _loc1_.useCount += _loc4_.dropCount;
                        }
                     }
                  }
               }
            }
         }
      }
      
      private function isAttacking() : Boolean
      {
         if(_currentRole && _currentRole.actionMovie && _currentRole.actionMovie.movie)
         {
            if(_currentRole.actionMovie.movie.currentLabel && _currentRole.actionMovie.movie.currentLabel.toLowerCase().indexOf("attack") > -1)
            {
               return true;
            }
         }
         return false;
      }
      
      override public function cancel() : void
      {
      }
      
      override public function dispose() : void
      {
         _finished = true;
         removeBackDust();
         _data = null;
      }
   }
}

