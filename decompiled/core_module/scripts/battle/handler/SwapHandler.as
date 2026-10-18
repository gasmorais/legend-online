package battle.handler
{
   import battle.BattleManager;
   import battle.actions.MovePointAction;
   import battle.events.BattleEvent;
   import battle.skillsys.helper.BloodHelper;
   import battle.skillsys.skills.BaseSkill;
   import battle.utils.BattleFunctionHelper;
   import battle.utils.BattleUtils;
   import com.road.yishi.proto.battle.HeroMsg;
   import com.road.yishi.proto.battle.ReinforceMsg;
   import com.road.yishi.proto.battle.SoldierMsg;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import map.internals.utils.SocketGameReader;
   import yishi.comm.PackageIn;
   import yishi.datas.BattleModel;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.objects.RoleInfo;
   import yishi.manager.NotificationManager;
   
   public class SwapHandler implements IPackageHandler
   {
      
      private const POS_X:uint = 700;
      
      public function SwapHandler()
      {
         super();
      }
      
      public function handle(param1:PackageIn) : void
      {
         var _loc9_:RoleInfo = null;
         var _loc10_:HeroMsg = null;
         var _loc5_:HeroMsg = null;
         var _loc11_:HeroRoleInfo = null;
         var _loc13_:HeroRoleInfo = null;
         var _loc4_:HeroMsg = null;
         var _loc14_:RoleInfo = null;
         BattleManager.getInstance().battleModel.isOver = false;
         var _loc2_:ReinforceMsg = new ReinforceMsg();
         _loc2_ = param1.readBody(_loc2_) as ReinforceMsg;
         var _loc7_:Vector.<RoleInfo> = new Vector.<RoleInfo>();
         var _loc8_:Vector.<RoleInfo> = new Vector.<RoleInfo>();
         for each(var _loc12_:SoldierMsg in _loc2_.soldiers)
         {
            _loc9_ = SocketGameReader.readPawnRoleInfo(_loc12_);
            _loc7_.push(_loc9_);
         }
         for each(var _loc3_:HeroMsg in _loc2_.hero)
         {
            _loc10_ = BattleFunctionHelper.instance.findBattleRoleMsgForHero(_loc2_.pets,_loc3_.livingId);
            _loc5_ = BattleFunctionHelper.instance.findBattleRoleMsgForHero(_loc2_.goddesses,_loc3_.livingId);
            _loc11_ = SocketGameReader.readHeroRoleInfo(_loc3_,_loc10_,_loc5_);
            _loc7_.push(_loc11_);
            if(_loc11_.petRoleInfo != null)
            {
               _loc7_.push(_loc11_.petRoleInfo);
            }
         }
         for each(var _loc15_:HeroMsg in _loc2_.children)
         {
            _loc4_ = BattleFunctionHelper.instance.findBattleRoleMsgForHero(_loc2_.pets,_loc15_.livingId);
            _loc13_ = SocketGameReader.readHeroRoleInfo(_loc15_,_loc4_,null,true);
            _loc7_.push(_loc13_);
         }
         for each(var _loc6_:uint in _loc2_.removeLivingIds)
         {
            _loc14_ = BattleManager.getInstance().battleModel.getRoleById(_loc6_);
            if(_loc14_ != null)
            {
               _loc8_.push(_loc14_);
            }
         }
         if(_loc2_.life != null && _loc2_.life.length > 0 && _loc2_.heroTempId != null && _loc2_.heroTempId.length > 0)
         {
            BattleManager.getInstance().battleModel._life = _loc2_.life;
            BattleManager.getInstance().battleModel._heroTempId = _loc2_.heroTempId;
         }
         skipOverdueActions(_loc2_.frameNum);
         swapRoleHandler(_loc7_,_loc8_);
      }
      
      private function skipOverdueActions(param1:Number) : void
      {
         var roleDic:Dictionary;
         var curRoleInfo:RoleInfo;
         var curTimestamp:Number = param1;
         var skipFunUnfinishedSkill:* = function(param1:Array, param2:Boolean):void
         {
            var _loc4_:BaseSkill = null;
            var _loc3_:* = 0;
            var _loc5_:int = 0;
            if(param1 != null)
            {
               _loc3_ = param1.length;
               _loc5_ = _loc3_ - 1;
               while(_loc5_ >= 0)
               {
                  _loc4_ = param1[_loc5_];
                  if(_loc4_ != null && !_loc4_.finished && _loc4_.getSkillData().liftTime < curTimestamp)
                  {
                     traceStr += "施放者:" + _loc4_.getCurrentRole().roleName + " 攻击目标id:" + _loc4_.getSkillData().getHurtRoles() + " 技能id:" + _loc4_.getSkillData().skillId + " 是否分配：" + param2 + "\n";
                     _loc4_.skipFun();
                     param1.splice(_loc5_,1);
                  }
                  _loc5_--;
               }
            }
         };
         var traceStr:String = ">>>>>>>>>>>跳过过期技能\n";
         skipFunUnfinishedSkill(BattleManager.getInstance().getSkillSystem().getSkillQueue().getActions(),false);
         roleDic = BattleManager.getInstance().battleModel.roleList;
         for each(curRoleInfo in roleDic)
         {
            skipFunUnfinishedSkill(curRoleInfo.getSkillQueue().getActions(),true);
         }
      }
      
      private function swapRoleHandler(param1:Vector.<RoleInfo>, param2:Vector.<RoleInfo>) : void
      {
         var curbackRoleInfo:RoleInfo;
         var temp:BaseSkill;
         var curJoinRoleInfo:RoleInfo;
         var fightPos:Point;
         var startPos:Point;
         var joinRoleInfoList:Vector.<RoleInfo> = param1;
         var backRoleInfoList:Vector.<RoleInfo> = param2;
         var battleModel:BattleModel = BattleManager.getInstance().battleModel;
         for each(curbackRoleInfo in backRoleInfoList)
         {
            if(curbackRoleInfo.getSkillQueue() && curbackRoleInfo.getSkillQueue().current)
            {
               temp = curbackRoleInfo.getSkillQueue().current as BaseSkill;
               if(temp && !temp.finished)
               {
                  temp.skipFun();
               }
            }
            curbackRoleInfo.isLiving = false;
            BloodHelper.removeCacheInfoById(curbackRoleInfo.livingId);
         }
         for each(curJoinRoleInfo in joinRoleInfoList)
         {
            curJoinRoleInfo.load();
            battleModel.addRole(curJoinRoleInfo);
            fightPos = BattleUtils.rolePointByPos(curJoinRoleInfo.pos,curJoinRoleInfo.face);
            startPos = new Point(fightPos.x + (curJoinRoleInfo.face == 2 ? 700 : -700),fightPos.y);
            curJoinRoleInfo.point = startPos;
            new MovePointAction(curJoinRoleInfo.livingId,fightPos,25);
         }
         switch(battleModel.battleType - 311)
         {
            case 0:
            case 1:
            case 2:
               if(BattleManager.getInstance().battleUIView != null)
               {
                  BattleManager.getInstance().battleUIView.updateMutilRoleShowView();
               }
               else
               {
                  NotificationManager.instance.addEventListener("enterbattlescene",function(param1:BattleEvent):void
                  {
                     NotificationManager.instance.removeEventListener("enterbattlescene",arguments.callee);
                     BattleManager.getInstance().battleUIView.updateMutilRoleShowView();
                  });
               }
         }
      }
   }
}

