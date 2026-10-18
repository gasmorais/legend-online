package yishi.datas.objects
{
   import battle.BattleManager;
   import battle.view.roles.HeroRoleView;
   import flash.display.MovieClip;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import map.campaign.data.TrailPropInfo;
   import yishi.datas.BattlePropItem;
   import yishi.datas.playerinfo.BattleReplaceSkillInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.events.RoleEvent;
   
   [Event(name="sp",type="yishi.events.RoleEvent")]
   public class HeroRoleInfo extends RoleInfo
   {
      
      public var petLivingId:int;
      
      public var petSkillIds:Array = [];
      
      public var heroInfo:ThaneInfo;
      
      public var pawnTempId:int;
      
      public var spMax:Number = 100;
      
      private var _sp:Number = 0;
      
      public var hitPointMax:Number = 5;
      
      private var _hitPoint:Number = 0;
      
      private var _avengerSp:int = 0;
      
      protected var _awaken:int;
      
      public var type:int;
      
      public var curturn:int;
      
      public var userId:int;
      
      public var playerIconId:int;
      
      public var bufferSp:int = -1;
      
      public var spChanged:Boolean;
      
      public var resPath:String;
      
      public var props:Array = [];
      
      public var trialProps:Array;
      
      public var marrSkills:Array = [];
      
      public var marrUserId:int = 0;
      
      private var _countDown:Boolean;
      
      private var _isPetState:Boolean;
      
      public var titanId:int = 0;
      
      public var titanSkill:Array = [];
      
      public var titanSkillUsed:Array = [];
      
      private var _changeValue:int;
      
      public var isManualChild:Boolean;
      
      public var isFollowChild:Boolean;
      
      public var pos_head_hero:Point;
      
      public var pos_body_hero:Point;
      
      public var pos_leg_hero:Point;
      
      public var goddessRoleInfo:GoddessRoleInfo;
      
      public var replaceSkillInfo:BattleReplaceSkillInfo;
      
      public var avengerFightSkills:Array = [];
      
      public var avengerAllSkills:Array = [];
      
      public var avengerWaitSec:int;
      
      public var avengerSpMax:Number = 70;
      
      public var warsoulSkills:Array = [];
      
      public var warsoulType:int;
      
      public var thessBoxSkills:Array = [];
      
      private var _warsoulSp:int;
      
      private const WARSOULSPMAX:int = 100;
      
      public var isWaitingChangeBody:Boolean = false;
      
      public var isPetFake:Boolean = false;
      
      public var isChildFake:Boolean = false;
      
      public var petRoleInfo:PetRoleInfo;
      
      public function HeroRoleInfo(param1:IEventDispatcher = null)
      {
         super(param1);
         pos_head_hero = new Point();
         pos_body_hero = new Point();
         pos_leg_hero = new Point();
         heroInfo = new ThaneInfo();
      }
      
      override public function initView() : void
      {
         _roleView = new HeroRoleView(this);
      }
      
      public function getActiveMarrSkillInfo() : TrailPropInfo
      {
         var _loc1_:SkillTempInfo = null;
         for each(var _loc2_:TrailPropInfo in marrSkills)
         {
            _loc1_ = _loc2_.skillTemp;
            if(_loc1_.UseWay == 1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getMarrSkillInfo(param1:int) : TrailPropInfo
      {
         for each(var _loc2_:TrailPropInfo in marrSkills)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getMarrObject() : HeroRoleInfo
      {
         var _loc2_:HeroRoleInfo = null;
         if(!_battleModel)
         {
            return null;
         }
         for each(var _loc1_:RoleInfo in _battleModel.roleList)
         {
            if(_loc1_ is HeroRoleInfo)
            {
               _loc2_ = _loc1_ as HeroRoleInfo;
               if(_loc2_.side == this.side && _loc2_.heroInfo.userId == marrUserId && _loc2_.heroInfo.serviceName == this.heroInfo.serviceName)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      public function get sp() : Number
      {
         return _sp;
      }
      
      public function updateSp(param1:Number, param2:Boolean = true, param3:Boolean = true, param4:Boolean = true, param5:Boolean = false) : void
      {
         _sp = param1;
         if(_sp > spMax)
         {
            _sp = spMax;
         }
         else if(_sp < 0)
         {
            _sp = 0;
         }
         dispatchEvent(new RoleEvent("sp",{
            "sp":param1,
            "fly":param2,
            "increase":param3,
            "showTip":param4,
            "buffCause":param5
         }));
      }
      
      public function get hitPoint() : Number
      {
         return _hitPoint;
      }
      
      public function updateHitPoint(param1:Number, param2:Boolean = true, param3:Boolean = true, param4:Boolean = true, param5:Boolean = false) : void
      {
         _hitPoint = param1;
         if(_hitPoint > hitPointMax)
         {
            _hitPoint = hitPointMax;
         }
         else if(_hitPoint < 0)
         {
            _hitPoint = 0;
         }
         dispatchEvent(new RoleEvent("HIT_POINT",{
            "hitPoint":param1,
            "fly":param2,
            "increase":param3,
            "showTip":param4,
            "buffCause":param5
         }));
      }
      
      public function get avengerSp() : int
      {
         return _avengerSp;
      }
      
      public function updateAvengerSp(param1:int) : void
      {
         _avengerSp = param1;
         if(_avengerSp > avengerSpMax)
         {
            _avengerSp = avengerSpMax;
         }
         else if(_avengerSp < 0)
         {
            _avengerSp = 0;
         }
         dispatchEvent(new RoleEvent("AVENGER_SP",{"avengerSp":param1}));
      }
      
      public function get warsoulSp() : int
      {
         return _warsoulSp;
      }
      
      public function updateWarsoulSp(param1:int) : void
      {
         _warsoulSp = param1;
         if(_warsoulSp > 100)
         {
            _warsoulSp = 100;
         }
         else if(_warsoulSp < 0)
         {
            _warsoulSp = 0;
         }
         dispatchEvent(new RoleEvent("WARSOUL_SP",{"warsoulSp":param1}));
      }
      
      public function updateAwaken(param1:int) : void
      {
         if(!petRoleInfo)
         {
            _awaken = 0;
            return;
         }
         if(_awaken == param1)
         {
            return;
         }
         _awaken = param1;
         if(_awaken > 3000)
         {
            _awaken = 3000;
         }
         else if(_awaken < 0)
         {
            _awaken = 0;
         }
         if(_awaken == 0 && isPetState)
         {
            isWaitingChangeBody = true;
         }
         dispatchEvent(new RoleEvent("AWAKEN",{"awaken":param1}));
      }
      
      public function updateChildAwaken(param1:int) : void
      {
         if(_awaken == param1)
         {
            return;
         }
         _awaken = param1;
         if(_awaken > 100)
         {
            _awaken = 100;
         }
         else if(_awaken < 0)
         {
            _awaken = 0;
         }
         dispatchEvent(new RoleEvent("AWAKEN",{"awaken":param1}));
      }
      
      public function updateChildChangeValue(param1:int) : void
      {
         if(_changeValue == param1)
         {
            return;
         }
         _changeValue = param1;
         if(_changeValue > 3000)
         {
            _changeValue = 3000;
         }
         else if(_changeValue < 0)
         {
            _awaken = 0;
         }
         dispatchEvent(new RoleEvent("CHILD_CHANGE_VALUE",{"changeValue":param1}));
      }
      
      public function get awaken() : int
      {
         return _awaken;
      }
      
      public function get changeValue() : int
      {
         return _changeValue;
      }
      
      override public function set templateId(param1:int) : void
      {
         _templateId = param1;
         heroInfo.templateId = param1;
      }
      
      public function refreshEffectInfo() : void
      {
         if(resPath != "" && type != 3)
         {
            effectId = resPath;
         }
      }
      
      public function get countDown() : Boolean
      {
         return _countDown;
      }
      
      override public function update() : void
      {
         super.update();
      }
      
      public function set countDown(param1:Boolean) : void
      {
         _countDown = param1;
         dispatchEvent(new RoleEvent("countDown",param1));
      }
      
      public function getTrialPropInfoByIndex(param1:int) : TrailPropInfo
      {
         for each(var _loc2_:TrailPropInfo in trialProps)
         {
            if(_loc2_.index == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getTrialPropInfoById(param1:int) : TrailPropInfo
      {
         for each(var _loc2_:TrailPropInfo in trialProps)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      override public function set actionMovieClip(param1:MovieClip) : void
      {
         super.actionMovieClip = param1;
         if(isPetFake)
         {
            if(isPetState)
            {
               view.setRoleInfoViewVisible(true);
            }
            else
            {
               view.setRoleInfoViewVisible(false);
            }
         }
      }
      
      private function hasPawn() : Boolean
      {
         var _loc2_:Array = BattleManager.getInstance().battleModel.getRoleBySide(side);
         for each(var _loc1_:RoleInfo in _loc2_)
         {
            if(_loc1_ is PawnRoleInfo)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getPropByID(param1:int) : BattlePropItem
      {
         for each(var _loc2_:BattlePropItem in props)
         {
            if(_loc2_.skillTempId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get isPetState() : Boolean
      {
         return _isPetState;
      }
      
      public function set isPetState(param1:Boolean) : void
      {
         if(_isPetState == param1)
         {
            return;
         }
         _isPetState = param1;
         if(petRoleInfo)
         {
            petRoleInfo.visible = true;
            if(_isPetState || bloodA <= 0)
            {
               petRoleInfo.visible = false;
            }
         }
         if(view is HeroRoleView)
         {
            (view as HeroRoleView).changeBody();
         }
         isWaitingChangeBody = false;
         dispatchEvent(new RoleEvent("MORPH",param1));
         dispatchEvent(new RoleEvent("bloodChangeS",this));
      }
      
      public function canMorph() : Boolean
      {
         return isPetState == false && awaken == 3000;
      }
      
      public function canCancelMorph() : Boolean
      {
         return isPetState == true && awaken > 0;
      }
      
      public function childCanMorph() : Boolean
      {
         return changeValue == 3000;
      }
      
      override public function set riveve(param1:Boolean) : void
      {
         super.riveve = param1;
         if(param1 && petRoleInfo)
         {
            if(!isPetState)
            {
               petRoleInfo.visible = true;
            }
            petRoleInfo.defaultAction = "Stand";
            petRoleInfo.action("Stand","REPEAT");
         }
      }
      
      override protected function die() : void
      {
         if(petRoleInfo)
         {
            petRoleInfo.visible = false;
         }
         super.die();
      }
      
      override public function get roleName() : String
      {
         return heroInfo.nickName;
      }
      
      public function getWaitSkillIds() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:int in avengerAllSkills)
         {
            if(avengerFightSkills.indexOf(_loc2_) == -1)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
   }
}

