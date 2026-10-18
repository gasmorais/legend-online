package battle.handler
{
   import battle.BattleManager;
   import battle.actions.MovePointAction;
   import battle.events.BattleEvent;
   import battle.skillsys.loader.SkillResourceLoader;
   import battle.utils.BattleFunctionHelper;
   import battle.utils.BattleUtils;
   import com.road.yishi.proto.battle.HeroMsg;
   import com.road.yishi.proto.battle.ReinforceMsg;
   import com.road.yishi.proto.battle.SoldierMsg;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.setTimeout;
   import map.internals.utils.SocketGameReader;
   import yishi.comm.PackageIn;
   import yishi.datas.BattleModel;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.objects.MonsterRoleInfo;
   import yishi.datas.objects.RoleInfo;
   import yishi.manager.NotificationManager;
   
   public class ReinforceHandler implements IPackageHandler
   {
      
      private static var childArenaType:int;
      
      private var _pkg:PackageIn;
      
      private var fighters:Array;
      
      public function ReinforceHandler()
      {
         super();
      }
      
      public static function addRole(param1:RoleInfo) : void
      {
         param1.face = param1.side == BattleManager.getInstance().battleModel.selfSide ? 1 : 2;
         if(!BattleManager.getInstance().battleModel.isHideOtherInBattle(param1))
         {
            param1.load();
         }
         if(!BattleManager.getInstance().battleModel.getRoleById(param1.livingId))
         {
            BattleManager.getInstance().battleModel.addRole(param1);
         }
         var _loc2_:Point = BattleUtils.rolePointByPos(param1.pos,param1.face);
         if(param1.face == 2)
         {
            param1.point = new Point(_loc2_.x + 700,_loc2_.y);
            new MovePointAction(param1.livingId,_loc2_,25,0,false,false,true,false);
         }
         else
         {
            param1.point = new Point(_loc2_.x - 700,_loc2_.y);
            new MovePointAction(param1.livingId,_loc2_,25,0,false,false,true,false);
         }
      }
      
      public static function removeRole(param1:RoleInfo, param2:Boolean = true, param3:int = -1) : void
      {
         setTimeout(removeRoleLater,600,param1,param2,param3);
      }
      
      public static function removeRoleLater(param1:RoleInfo, param2:Boolean = true, param3:int = -1) : void
      {
         var temp:Point;
         var role:RoleInfo = param1;
         var isSelfSide:Boolean = param2;
         var opType:int = param3;
         role.face = role.side == BattleManager.getInstance().battleModel.selfSide ? 1 : 2;
         role = BattleManager.getInstance().battleModel.getRoleById(role.livingId);
         temp = BattleUtils.rolePointByPos(role.pos,role.face);
         if(role.face == 2)
         {
            temp = new Point(temp.x + 700,temp.y);
            new MovePointAction(role.livingId,temp,25,0,false,false,true,false,function():void
            {
            },null,true,null,100,true);
         }
         else
         {
            temp = new Point(temp.x - 700,temp.y);
            if(isSelfSide && opType == 3)
            {
               new MovePointAction(role.livingId,temp,25,0,false,false,true,false,function():void
               {
                  role.cleanActions();
                  role.actionManager && role.actionManager.current && role.actionManager.current.cancel();
               },null,true,null,100,true);
            }
            else
            {
               new MovePointAction(role.livingId,temp,25,0,false,false,true,false,function():void
               {
                  role.cleanActions();
                  role.actionManager && role.actionManager.current && role.actionManager.current.cancel();
               },null,true,null,100,true);
            }
         }
      }
      
      public function handle(param1:PackageIn) : void
      {
         var _loc6_:RoleInfo = null;
         var _loc31_:SoldierMsg = null;
         var _loc22_:int = 0;
         var _loc3_:Boolean = false;
         var _loc10_:HeroRoleInfo = null;
         var _loc23_:* = null;
         var _loc12_:Dictionary = null;
         var _loc28_:int = 0;
         var _loc32_:HeroMsg = null;
         var _loc5_:HeroMsg = null;
         var _loc21_:HeroMsg = null;
         var _loc13_:HeroMsg = null;
         var _loc11_:MonsterRoleInfo = null;
         var _loc29_:int = 0;
         var _loc25_:int = 0;
         var _loc27_:int = 0;
         var _loc4_:int = 0;
         var _loc24_:HeroRoleInfo = null;
         var _loc14_:HeroRoleInfo = null;
         if(BattleManager.selfDie)
         {
            return;
         }
         _pkg = param1;
         var _loc2_:ReinforceMsg = new ReinforceMsg();
         _loc2_ = _pkg.readBody(_loc2_) as ReinforceMsg;
         childArenaType = -1;
         if(_loc2_.hasOpType)
         {
            childArenaType = _loc2_.opType;
         }
         var _loc7_:Array = [];
         var _loc19_:int = _loc2_.side;
         var _loc30_:int = int(_loc2_.soldiers.length);
         var _loc8_:BattleModel = BattleManager.getInstance().battleModel;
         if(_loc8_.battleType == 3870)
         {
            _loc12_ = _loc8_.armyInfoRight.roles;
            for each(var _loc9_:RoleInfo in _loc12_)
            {
               if(_loc9_ && _loc9_.isLiving)
               {
                  _loc9_.isLiving = false;
               }
            }
         }
         if(BattleManager.getInstance().battleModel.battleType != 295)
         {
            if(_loc2_.hasReinforceWave)
            {
               _loc8_.trialLayer = _loc2_.reinforceWave;
            }
         }
         var _loc17_:Array = [700001,700002];
         var _loc16_:Array = [700003,700004];
         var _loc15_:Array = [];
         _loc22_ = 0;
         while(_loc22_ < _loc30_)
         {
            _loc31_ = _loc2_.soldiers[_loc22_];
            _loc6_ = SocketGameReader.readPawnRoleInfo(_loc31_);
            addRole(_loc6_);
            _loc22_++;
         }
         var _loc18_:int = int(_loc2_.hero.length);
         var _loc20_:Array = [];
         _loc22_ = 0;
         while(_loc22_ < _loc18_)
         {
            _loc32_ = _loc2_.hero[_loc22_];
            _loc5_ = BattleFunctionHelper.instance.findBattleRoleMsgForHero(_loc2_.pets,_loc32_.livingId);
            _loc21_ = BattleFunctionHelper.instance.findBattleRoleMsgForHero(_loc2_.goddesses,_loc32_.livingId);
            _loc29_ = _loc2_.goddesses.indexOf(_loc21_);
            if(_loc21_ && _loc29_ != -1)
            {
               _loc2_.goddesses.splice(_loc29_,1);
            }
            _loc10_ = SocketGameReader.readHeroRoleInfo(_loc32_,_loc5_,_loc21_);
            addRole(_loc10_);
            if(_loc10_.goddessRoleInfo)
            {
               addRole(_loc10_.goddessRoleInfo);
            }
            if(_loc10_.petRoleInfo)
            {
               addRole(_loc10_.petRoleInfo);
               _loc25_ = 0;
               while(_loc25_ < _loc17_.length)
               {
                  _loc28_ = int(_loc17_[_loc25_]);
                  if(_loc15_.indexOf(_loc28_) == -1)
                  {
                     _loc15_.push(_loc28_);
                  }
                  _loc25_++;
               }
            }
            if(_loc10_.isChildFake)
            {
               _loc27_ = 0;
               while(_loc27_ < _loc16_.length)
               {
                  _loc28_ = int(_loc16_[_loc27_]);
                  if(_loc15_.indexOf(_loc28_) == -1)
                  {
                     _loc15_.push(_loc28_);
                  }
                  _loc27_++;
               }
            }
            if(HeroRoleInfo(_loc10_).type == 3)
            {
               _loc20_.push(_loc10_);
            }
            else
            {
               _loc3_ = true;
            }
            _loc22_++;
         }
         _loc18_ = int(_loc2_.children.length);
         fighters = [];
         var _loc26_:Dictionary = _loc8_.roleList;
         _loc22_ = 0;
         while(_loc22_ < _loc18_)
         {
            _loc32_ = _loc2_.children[_loc22_];
            _loc5_ = BattleFunctionHelper.instance.findBattleRoleMsgForHero(_loc2_.pets,_loc32_.livingId);
            _loc6_ = SocketGameReader.readHeroRoleInfo(_loc32_,_loc5_,null,true);
            if(_loc6_.side != 0)
            {
               addRole(_loc6_);
            }
            _loc32_ = null;
            _loc22_++;
         }
         if(_loc8_.battleType == 3866)
         {
            _loc4_ = int(_loc2_.pets.length);
            _loc22_ = 0;
            while(_loc22_ < _loc4_)
            {
               _loc5_ = _loc2_.pets[_loc22_];
               _loc24_ = SocketGameReader.readHeroRoleInfo(_loc5_,null,null);
               _loc24_.petRoleInfo = SocketGameReader.readPetRoleInfo(_loc5_);
               _loc24_.petRoleInfo.heroRoleInfo = _loc24_;
               _loc24_.heroInfo.petTemplateId = _loc5_.tempId;
               if(_loc8_.battleType == 3866)
               {
                  _loc24_.isPetState = true;
                  _loc24_.heroInfo.sexs = 2;
               }
               else
               {
                  _loc24_.isPetFake = true;
               }
               addRole(_loc24_);
               _loc5_ = null;
               _loc22_++;
            }
         }
         _loc4_ = int(_loc2_.goddesses.length);
         _loc22_ = 0;
         while(_loc22_ < _loc4_)
         {
            _loc21_ = _loc2_.goddesses[_loc22_];
            _loc14_ = SocketGameReader.readHeroRoleInfo(_loc21_,null,null);
            _loc14_.goddessRoleInfo = SocketGameReader.readGoddessRoleInfo(_loc21_);
            _loc14_.goddessRoleInfo.heroRoleInfo = _loc14_;
            _loc14_.isGoddess = true;
            _loc14_.goddessRoleInfo.templateId = _loc21_.tempId;
            addRole(_loc6_);
            _loc21_ = null;
            _loc22_++;
         }
         _loc4_ = int(_loc2_.monsters.length);
         _loc22_ = 0;
         while(_loc22_ < _loc4_)
         {
            _loc13_ = _loc2_.monsters[_loc22_];
            _loc11_ = SocketGameReader.readMonsterRoleInfo(_loc13_);
            if(_loc8_.battleType == 3884)
            {
               _loc11_.isFollowHero = false;
            }
            else
            {
               _loc11_.isFollowHero = true;
            }
            addRole(_loc11_);
            _loc13_ = null;
            _loc22_++;
         }
         if(_loc20_.length > 0 && BattleManager.getInstance().battleUIView)
         {
            BattleManager.getInstance().battleUIView.bossReinforce(_loc20_);
         }
         BattleManager.getInstance().battleModel.isOver = false;
         if(BattleManager.getInstance().battleUIView && !_loc3_)
         {
            NotificationManager.instance.sendNotification("SKILL_ENABLE",true);
         }
         if(_loc15_.length > 0)
         {
            SkillResourceLoader.add(_loc15_);
         }
         NotificationManager.instance.dispatchEvent(new BattleEvent("BATTLE_REINFORCE_HANDLER",null));
      }
      
      private function isSelfSide(param1:int) : Boolean
      {
         return param1 == BattleManager.getInstance().battleModel.selfSide;
      }
   }
}

