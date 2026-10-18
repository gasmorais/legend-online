package battle.utils
{
   import battle.BattleManager;
   import battle.actions.DannyAction;
   import battle.data.AttackData;
   import battle.data.SkillData;
   import battle.view.animation.AddSpAnimation;
   import battle.view.utils.DepthSprite;
   import com.road.yishi.proto.battle.AttackOrderMsg;
   import com.road.yishi.proto.battle.BufferMsg;
   import com.road.yishi.proto.battle.DamageMsg;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import yishi.datas.BattleModel;
   import yishi.datas.battle.ResistModel;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.objects.RoleInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.TimerUtils;
   
   public class BattleUtils
   {
      
      private static const gasRow:Number = 60;
      
      private static const gasColumn:Number = 150;
      
      private static var posLeft:Array;
      
      private static var posRight:Array;
      
      public function BattleUtils()
      {
         super();
      }
      
      public static function toStringAttackOrder(param1:AttackOrderMsg) : String
      {
         var _loc4_:DamageMsg = null;
         var _loc7_:BufferMsg = null;
         var _loc6_:int = 0;
         var _loc2_:String = "";
         _loc2_ += "battleId : " + param1.battleId + "\t";
         _loc2_ += "orderId : " + param1.orderId + "\t";
         _loc2_ += "source id : " + param1.livingId + "\t";
         _loc2_ += "source sp : " + param1.sp + "\t";
         _loc2_ += "source spAdd : " + param1.spAdded + "\t";
         _loc2_ += "attackMillis : " + DateFormatter.parse(param1.attackMillis,"YYYY-MM-DD hh:mm:ss").time + "\t";
         _loc2_ += "passive : " + param1.isPassive + "\t";
         _loc2_ += "execFrame : " + param1.execFrame + "\t";
         _loc2_ += "*****************\t";
         var _loc3_:int = int(param1.damages.length);
         _loc2_ += "skill target list size :" + _loc3_ + "\t";
         var _loc5_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = param1.damages[_loc5_];
            _loc2_ += "target id \t: " + _loc4_.livingId + "\t";
            _loc2_ += "damage \t: " + _loc4_.damageValue + "\t";
            _loc2_ += "damage type: " + _loc4_.damageType + "\t";
            _loc2_ += "left hp\t: " + _loc4_.leftValue + "\t";
            _loc2_ += "extra data\t: " + _loc4_.extraData + "\t";
            _loc2_ += "execFrame\t: " + param1.execFrame + "\t";
            _loc2_ += "damageCount: " + _loc4_.order + "\t";
            _loc5_++;
         }
         _loc2_ += "*****************\t";
         _loc3_ = int(param1.buffers.length);
         _loc2_ += "skill buffer list size :" + _loc3_ + "\t";
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc7_ = param1.buffers[_loc5_];
            _loc2_ += "buffer\tid\t\t\t: " + _loc7_.bufferId + "\t";
            _loc2_ += "buffer\ttemplateId\t: " + _loc7_.templateId + "\t";
            _loc2_ += "buffer\tsourceId\t: " + _loc7_.sourceId + "\t";
            _loc2_ += "buffer\ttargetId\t: " + _loc7_.targetId + "\t";
            _loc2_ += "buffer\tseeType\t\t: " + _loc7_.seeType + "\t";
            _loc2_ += "buffer\tcurTurn\t\t: " + _loc7_.curTurn + "\t";
            _loc2_ += "buffer\texeWay\t\t: " + _loc7_.exeWay + "\t";
            _loc2_ += "buffer\tpressedNum\t: " + _loc7_.pressedNum + "\t";
            _loc2_ += "skill buffer damage :\t";
            _loc6_ = 0;
            while(_loc6_ < _loc7_.damage.length)
            {
               _loc4_ = _loc7_.damage[_loc6_];
               _loc2_ += "target id \t: " + _loc4_.livingId + "\t";
               _loc2_ += "damage \t: " + _loc4_.damageValue + "\t";
               _loc2_ += "damage type: " + _loc4_.damageType + "\t";
               _loc2_ += "left hp\t: " + _loc4_.leftValue + "\t";
               _loc2_ += "extra data\t: " + _loc4_.extraData + "\t";
               _loc2_ += "execFrame\t: " + param1.execFrame + "\t";
               _loc6_++;
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      public static function initRolePos() : void
      {
         if(posLeft)
         {
            posLeft.splice(0,posLeft.length);
         }
         posLeft = null;
         if(posRight)
         {
            posRight.splice(0,posRight.length);
         }
         posRight = null;
         posLeft = get9GridPos(295,570,0,true);
         posRight = get9GridPos(905,570,0,false);
      }
      
      private static function get9GridPos(param1:int, param2:int, param3:int, param4:Boolean) : Array
      {
         var _loc11_:Point = null;
         var _loc6_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc7_:Array = [];
         var _loc5_:int = param4 ? 1 : -1;
         var _loc10_:Array = [0,60,120,180];
         var _loc12_:Array = [0,-40,-80,-120];
         _loc8_ = 0;
         while(_loc8_ < 3)
         {
            _loc6_ = [];
            _loc9_ = 0;
            while(_loc9_ < 4)
            {
               _loc11_ = new Point();
               _loc11_.x = _loc8_ * 150 + param1 + param3 * _loc8_ + _loc12_[_loc9_] * _loc5_;
               _loc11_.y = _loc9_ * 60 + param2;
               _loc6_.push(_loc11_);
               _loc9_++;
            }
            _loc7_.push(_loc6_);
            _loc8_++;
         }
         return _loc7_;
      }
      
      public static function rolePointByPos(param1:int, param2:int) : Point
      {
         var _loc3_:Array = null;
         if(BattleManager.getInstance().battleModel.selfSide == 1)
         {
            _loc3_ = param2 == 1 ? posLeft : posRight;
         }
         else
         {
            _loc3_ = param2 == 2 ? posRight : posLeft;
         }
         if(param2 == 1)
         {
            switch(param1 - 1)
            {
               case 0:
                  return _loc3_[2][0];
               case 1:
                  return _loc3_[1][0];
               case 2:
                  return _loc3_[0][0];
               case 3:
                  return _loc3_[2][1];
               case 4:
                  return _loc3_[1][1];
               case 5:
                  return _loc3_[0][1];
               case 6:
                  return _loc3_[2][2];
               case 7:
                  return _loc3_[1][2];
               case 8:
                  return _loc3_[0][2];
               case 9:
                  return _loc3_[2][3];
               case 10:
                  return _loc3_[1][3];
               case 11:
                  return _loc3_[0][3];
            }
         }
         else
         {
            switch(param1 - 1)
            {
               case 0:
                  return _loc3_[0][0];
               case 1:
                  return _loc3_[1][0];
               case 2:
                  return _loc3_[2][0];
               case 3:
                  return _loc3_[0][1];
               case 4:
                  return _loc3_[1][1];
               case 5:
                  return _loc3_[2][1];
               case 6:
                  return _loc3_[0][2];
               case 7:
                  return _loc3_[1][2];
               case 8:
                  return _loc3_[2][2];
               case 9:
                  return _loc3_[0][3];
               case 10:
                  return _loc3_[1][3];
               case 11:
                  return _loc3_[2][3];
            }
         }
         return new Point();
      }
      
      public static function isDefaultSkill(param1:int) : Boolean
      {
         if(param1 == -1 || param1 == 0)
         {
            return true;
         }
         var _loc2_:SkillTempInfo = TempleteManager.instance.getSkillTemplateInfoById(param1);
         if(_loc2_)
         {
            return _loc2_.UseWay == 3;
         }
         return true;
      }
      
      public static function getLeftTeamCenterPoint() : Point
      {
         return posLeft[1][1];
      }
      
      public static function getRightTeamCenterPoint() : Point
      {
         return posRight[1][1];
      }
      
      public static function getPosition(param1:int, param2:int) : Point
      {
         var _loc3_:int = (param2 - 1) % 3;
         var _loc4_:int = Math.ceil(param2 / 3) - 1;
         if(param1 == 1)
         {
            return posLeft[_loc3_][_loc4_];
         }
         return posRight[_loc3_][_loc4_];
      }
      
      public static function attackPointByPos(param1:int, param2:uint, param3:int = 1, param4:int = 0) : Point
      {
         var _loc5_:Point = rolePointByPos(param1,param2);
         if(param2 == 1)
         {
            _loc5_ = new Point(_loc5_.x + param3 + 120,_loc5_.y);
         }
         else
         {
            _loc5_ = new Point(_loc5_.x - param3 - 120,_loc5_.y);
         }
         return _loc5_;
      }
      
      public static function ManagerDepth(param1:Sprite) : void
      {
         var _loc4_:DepthSprite = null;
         var _loc5_:int = 0;
         var _loc7_:Dictionary = new Dictionary(true);
         _loc5_ = 0;
         while(_loc5_ < param1.numChildren)
         {
            _loc7_[_loc5_] = param1.getChildAt(_loc5_);
            _loc5_++;
         }
         var _loc3_:int = 0;
         for(var _loc6_:Object in _loc7_)
         {
            _loc4_ = _loc7_[_loc6_];
            for each(var _loc2_:DepthSprite in _loc7_)
            {
               _loc3_++;
               if(_loc4_.pointY < _loc2_.pointY && param1.getChildIndex(_loc4_) > param1.getChildIndex(_loc2_))
               {
                  param1.swapChildren(_loc4_,_loc2_);
               }
            }
         }
      }
      
      public static function addSingleDanny(param1:Array, param2:int = 12, param3:Boolean = true, param4:int = 0, param5:Number = 0, param6:int = 6, param7:Boolean = true, param8:uint = 6710886, param9:Boolean = true, param10:Boolean = false, param11:int = 0, param12:int = -1) : void
      {
         var singelAttackArr:Array = param1;
         var $frame:int = param2;
         var $checkDie:Boolean = param3;
         var distance:int = param4;
         var flyUpPower:Number = param5;
         var shakeCount:int = param6;
         var flash:Boolean = param7;
         var flashColor:uint = param8;
         var playActBool:Boolean = param9;
         var selfCause:Boolean = param10;
         var delayBleed:int = param11;
         var skillId:int = param12;
         var executeBleed:* = function():void
         {
            var _loc4_:int = 0;
            var _loc5_:AttackData = null;
            var _loc1_:RoleInfo = null;
            var _loc3_:BattleModel = BattleManager.getInstance().battleModel;
            var _loc2_:ResistModel = BattleManager.getInstance().resistModel;
            if(!_loc3_)
            {
               return;
            }
            if(!_loc2_)
            {
               return;
            }
            if(!singelAttackArr)
            {
               return;
            }
            _loc2_.attackOver = false;
            _loc4_ = 0;
            while(_loc4_ < singelAttackArr.length)
            {
               _loc5_ = AttackData(singelAttackArr[_loc4_]);
               _loc1_ = _loc3_.getRoleById(_loc5_.roleId);
               if(_loc1_)
               {
                  new DannyAction(_loc1_,_loc5_,$frame,$checkDie,distance,flyUpPower,shakeCount,flash,flashColor,playActBool,selfCause,skillId);
                  _loc2_.currentResistSide = _loc1_.side == _loc3_.selfSide ? 1 : 2;
                  _loc2_.resistTotal = _loc5_.resiPercent;
                  if(_loc3_.selfHero.livingId != _loc5_.fId && _loc3_.selfHero.livingId != _loc5_.roleId)
                  {
                     _loc2_.resistTotal = 0;
                  }
               }
               _loc4_++;
            }
            if(_loc2_.resistTotal != 0)
            {
               _loc2_.attackOver = true;
            }
            else
            {
               _loc2_.attackOver = false;
            }
         };
         if(delayBleed > 0)
         {
            TimerUtils.setTimeout(executeBleed,40 * delayBleed);
         }
         else
         {
            executeBleed();
         }
      }
      
      public static function addSingleDannyTakeEffect(param1:Array, param2:Object, param3:int = 12, param4:Boolean = true, param5:int = 0, param6:Number = 0, param7:int = 6, param8:Boolean = true, param9:uint = 6710886, param10:Boolean = true, param11:Boolean = false, param12:int = 0, param13:int = -1) : void
      {
         var _loc16_:int = 0;
         var _loc17_:AttackData = null;
         var _loc14_:RoleInfo = null;
         var _loc18_:String = null;
         var _loc15_:BattleModel = BattleManager.getInstance().battleModel;
         if(!_loc15_)
         {
            return;
         }
         if(!param1)
         {
            return;
         }
         _loc16_ = 0;
         while(_loc16_ < param1.length)
         {
            _loc17_ = AttackData(param1[_loc16_]);
            _loc14_ = _loc15_.getRoleById(_loc17_.roleId);
            if(!_loc14_)
            {
               _loc18_ = LanguageMgr.GetTranslation("battle.utils.BattleUtils.str");
               return;
            }
            if(SharedManager.instance.allowAttactedEffect)
            {
               _loc14_.showDannyEffect(param2);
            }
            _loc16_++;
         }
         addSingleDanny(param1,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13);
      }
      
      public static function skillUpdateSp(param1:SkillData, param2:RoleInfo) : void
      {
         var addSpContainer:Sprite;
         var tid:int;
         var skillData:SkillData = param1;
         var currentRole:RoleInfo = param2;
         var delayUpdateSp:* = function():void
         {
            var _loc1_:int = 0;
            if(currentRole.hasOwnProperty("sp") && currentRole.hasOwnProperty("updateSp"))
            {
               _loc1_ = currentRole["sp"] + skillData.spAdded;
               currentRole["updateSp"](_loc1_);
               if(_loc1_ != skillData.sp)
               {
                  tid = setTimeout(updateOtherSp,300,skillData.sp - _loc1_);
               }
            }
         };
         var updateOtherSp:* = function(param1:int):void
         {
            var _loc2_:int = 0;
            clearTimeout(tid);
            tid = 0;
            if(currentRole.hasOwnProperty("sp") && currentRole.hasOwnProperty("updateSp"))
            {
               _loc2_ = currentRole["sp"] + param1;
               currentRole["updateSp"](_loc2_);
            }
         };
         if(skillData.skillId == 3 || skillData.skillId == 4)
         {
            return;
         }
         if(currentRole is HeroRoleInfo && currentRole == BattleManager.getInstance().battleModel.selfHero)
         {
            addSpContainer = BattleManager.getInstance().battleUIView.getAddSpBallLayer();
            if(skillData.spAdded > 0)
            {
               if(!currentRole.view)
               {
                  return;
               }
            }
            delayUpdateSp();
         }
      }
      
      public static function skillUpdateHitPoint(param1:SkillData, param2:RoleInfo) : void
      {
         var addSpContainer:Sprite;
         var startPt:Point;
         var endPt:Point;
         var lineNum:Number;
         var animation:AddSpAnimation;
         var tid:int;
         var skillData:SkillData = param1;
         var currentRole:RoleInfo = param2;
         var delayUpdateHitPoint:* = function():void
         {
            var _loc1_:int = HeroRoleInfo(currentRole).hitPoint + skillData.hitPointAdded;
            HeroRoleInfo(currentRole).updateHitPoint(_loc1_);
            if(_loc1_ != skillData.hitPoint)
            {
               tid = setTimeout(updateOtherHitPoint,300,skillData.hitPoint - _loc1_);
            }
         };
         var updateOtherHitPoint:* = function(param1:int):void
         {
            clearTimeout(tid);
            tid = 0;
            var _loc2_:int = HeroRoleInfo(currentRole).hitPoint + param1;
            HeroRoleInfo(currentRole).updateHitPoint(_loc2_);
         };
         if(skillData.skillId == 3 || skillData.skillId == 4)
         {
            return;
         }
         if(currentRole is HeroRoleInfo && currentRole == BattleManager.getInstance().battleModel.selfHero)
         {
            addSpContainer = BattleManager.getInstance().battleUIView.getAddSpBallLayer();
            if(skillData.hitPointAdded > 0)
            {
               if(!currentRole.view)
               {
                  return;
               }
               startPt = new Point(currentRole.view.x + 100,currentRole.view.y - 70);
               startPt = currentRole.view.parent.localToGlobal(startPt);
               startPt = addSpContainer.globalToLocal(startPt);
               endPt = BattleManager.getInstance().battleUIView.getAddHitPointDestPoint();
               lineNum = Math.ceil(skillData.hitPointAdded / 10);
               animation = new AddSpAnimation(addSpContainer,lineNum);
               animation.arrivedFun = delayUpdateHitPoint;
               animation.play(startPt,endPt);
            }
            else
            {
               delayUpdateHitPoint();
            }
         }
      }
   }
}

