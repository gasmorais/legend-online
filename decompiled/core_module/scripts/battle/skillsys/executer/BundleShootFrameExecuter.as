package battle.skillsys.executer
{
   import battle.BattleManager;
   import battle.actions.DannyAction;
   import battle.data.AttackData;
   import battle.logsys.BattleLogSystem;
   import battle.skillsys.effect.BattleEffect;
   import battle.skillsys.effect.SkillEffect;
   import battle.skillsys.mode.framedata.SkillFrameData;
   import battle.skillsys.skills.BaseSkill;
   import battle.view.roles.RoleViewBase;
   import flash.geom.Point;
   import yishi.datas.BattleModel;
   import yishi.datas.battle.ResistModel;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.objects.RoleInfo;
   import yishi.view.tools.QuickenMovieClip;
   
   public class BundleShootFrameExecuter
   {
      
      private var _skill:BaseSkill;
      
      private var _frameData:SkillFrameData;
      
      private var _attackIndex:int;
      
      private var _completeFun:Function;
      
      private var _shootCount:int;
      
      private var _startPoint:Point;
      
      private var _attackData:Array;
      
      public function BundleShootFrameExecuter(param1:BaseSkill, param2:SkillFrameData, param3:int, param4:Function)
      {
         super();
         _skill = param1;
         _frameData = param2;
         _attackIndex = param3;
         _completeFun = param4;
         _startPoint = new Point(_frameData.shootData.startX,_frameData.shootData.startY);
         _attackData = _skill.getSkillData().data[_attackIndex];
         execute();
      }
      
      private function execute() : void
      {
         var _loc2_:RoleInfo = null;
         for each(var _loc1_:AttackData in _attackData)
         {
            _loc2_ = BattleManager.getInstance().battleModel.getRoleById(_loc1_.roleId);
            addBundle(_loc2_,_loc1_);
         }
      }
      
      private function addBundle(param1:RoleInfo, param2:AttackData) : void
      {
         var stPt:Point;
         var destPt:Point;
         var w:int;
         var arrowEffect:SkillEffect;
         var distance:Number;
         var scale:Number;
         var angle:Number;
         var mc:QuickenMovieClip;
         var target:RoleInfo = param1;
         var element:AttackData = param2;
         var frameEnd:* = function():void
         {
            onHit(target,element);
         };
         if(!target || !target.point || !_skill.getCurrentRole() || !_skill.getCurrentRole().map)
         {
            onHit(target,element);
            return;
         }
         if(BattleManager.getInstance().battleModel.isHideOtherInBattle(_skill.getCurrentRole()))
         {
            onHit(target,element);
            return;
         }
         stPt = new Point();
         w = _frameData.shootData.arrowWidth;
         arrowEffect = new SkillEffect(_frameData.shootData.arrowRes);
         _skill.getCurrentRole().map.effectContainer.addEffect(arrowEffect);
         stPt.x = arrowEffect.getDisplayObject().x = _skill.getCurrentRole().point.x + _startPoint.x;
         stPt.y = arrowEffect.getDisplayObject().y = _skill.getCurrentRole().point.y + _startPoint.y;
         destPt = new Point(target.point.x,target.point.y - 80);
         distance = Point.distance(stPt,destPt);
         if(w == 0)
         {
            scale = 1;
         }
         else
         {
            scale = distance / w;
         }
         w = arrowEffect.getDisplayObject().width * scale;
         arrowEffect.getDisplayObject().width = w;
         angle = Math.atan2(destPt.y - stPt.y,destPt.x - stPt.x) * 180 / 3.141592653589793;
         arrowEffect.getDisplayObject().rotation = angle;
         mc = arrowEffect.getDisplayObject() as QuickenMovieClip;
         if(_frameData.shootData.dannyFrame != 0 && _frameData.shootData.dannyFrame != mc.totalFrames)
         {
            mc.addFrameScript(_frameData.shootData.dannyFrame - 1,frameEnd);
         }
         else
         {
            arrowEffect.callBackComplete.addListener(function():void
            {
               frameEnd();
            });
         }
      }
      
      private function onHit(param1:RoleInfo, param2:AttackData) : void
      {
         var _loc10_:Boolean = false;
         var _loc9_:BattleEffect = null;
         BattleLogSystem.skillDannyFlag(_skill);
         var _loc3_:BattleModel = BattleManager.getInstance().battleModel;
         var _loc4_:HeroRoleInfo = _loc3_ ? _loc3_.selfHero : null;
         if(_skill && _loc4_ && _skill.getCurrentRole() == _loc4_)
         {
            _loc10_ = true;
         }
         var _loc5_:* = BattleManager.getInstance().battleMap;
         if(!_loc5_)
         {
            return;
         }
         var _loc8_:BattleModel = BattleManager.getInstance().battleModel;
         var _loc6_:ResistModel = BattleManager.getInstance().resistModel;
         _loc6_.attackOver = false;
         var _loc7_:RoleViewBase = RoleViewBase(_loc5_.rolesDict[param2.roleId]);
         if(_loc7_ && _loc7_.info && !_loc8_.isHideOtherInBattle(_loc7_.info))
         {
            _loc9_ = new SkillEffect(_frameData.shootData.dannyRes);
            _loc9_.getDisplayObject().y = -70;
            _loc7_.effectContainer.addEffect(_loc9_);
         }
         if(param1)
         {
            new DannyAction(param1,param2,12,true,50,0,4,true,6710886,true,_loc10_,_skill.getSkillData().skillId);
            _loc6_.currentResistSide = param1.side == _loc8_.selfSide ? 1 : 2;
            _loc6_.resistTotal = param2.resiPercent;
            if(_loc8_.selfHero.livingId != param2.fId && _loc8_.selfHero.livingId != param2.roleId)
            {
               _loc6_.resistTotal = 0;
            }
         }
         if(_loc6_.resistTotal != 0)
         {
            _loc6_.attackOver = true;
         }
         else
         {
            _loc6_.attackOver = false;
         }
         _shootCount = _shootCount + 1;
         if(_shootCount >= _attackData.length)
         {
            _completeFun();
         }
      }
   }
}

