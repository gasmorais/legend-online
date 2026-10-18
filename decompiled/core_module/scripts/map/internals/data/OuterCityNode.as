package map.internals.data
{
   import flash.display.Sprite;
   import map.campaign.data.skill.MapBuffHurtData;
   import map.campaign.data.skill.MapSkillResultInfo;
   
   public class OuterCityNode extends NodeMapPhysics
   {
      
      private var _sonType:int;
      
      public var preNodeIds:String;
      
      public var nextNodeIds:String;
      
      public var nodeId:int;
      
      public var tempData:Object;
      
      private var _followTarget:int;
      
      public var curPosX:int;
      
      public var curPosY:int;
      
      public var attackTypes:int;
      
      public var nameColor:int;
      
      public var toward:int;
      
      public var patrolPos:String;
      
      private var _resource:int;
      
      public var fightUserId:int;
      
      public var resetPosX:int;
      
      public var resetPosY:int;
      
      public var fixX:int;
      
      public var fixY:int;
      
      public var heroTemplateId:int;
      
      private var _visitUserIds:Array;
      
      private var _curHp:Number = 0;
      
      public var totalHp:Number = 0;
      
      public var handlerRange:int;
      
      public var fightCapaity:int;
      
      private var _param1:int;
      
      public var param2:int;
      
      public var param3:String;
      
      public var param4:String;
      
      public var param5:String = "";
      
      public var param6:String;
      
      public var uid:String;
      
      public var createTime:Number;
      
      public var layer:int;
      
      public var preParent:Sprite;
      
      public var followTargetServiceName:String = "";
      
      public var buffList:Vector.<MapBuffHurtData> = new Vector.<MapBuffHurtData>();
      
      public var isStun:Boolean;
      
      public function OuterCityNode()
      {
         super();
      }
      
      public function get resource() : int
      {
         return _resource;
      }
      
      public function set resource(param1:int) : void
      {
         _resource = param1;
      }
      
      public function get param1() : int
      {
         return _param1;
      }
      
      public function set param1(param1:int) : void
      {
         if(_param1 != param1)
         {
            _param1 = param1;
            this.dispatchEvent(new PhysicsEvent("PARA_1",param1));
         }
      }
      
      public function get curHp() : Number
      {
         return _curHp;
      }
      
      public function set curHp(param1:Number) : void
      {
         _curHp = param1;
         this.dispatchEvent(new PhysicsEvent("UPDATE_CUR_HP",param1));
      }
      
      public function get visitUserIds() : Array
      {
         return _visitUserIds;
      }
      
      public function set visitUserIds(param1:Array) : void
      {
         _visitUserIds = param1;
         this.dispatchEvent(new PhysicsEvent("_visitUserIds",param1));
      }
      
      public function get followTarget() : int
      {
         return _followTarget;
      }
      
      public function set followTarget(param1:int) : void
      {
         _followTarget = param1;
         this.dispatchEvent(new PhysicsEvent("followTarget",param1));
      }
      
      public function get sonType() : int
      {
         return _sonType;
      }
      
      public function set sonType(param1:int) : void
      {
         if(_sonType == param1)
         {
            return;
         }
         _sonType = param1;
         this.dispatchEvent(new PhysicsEvent("UP_SONTYPE"));
      }
      
      public function beHurt(param1:Object) : void
      {
         dispatchEvent(new PhysicsEvent("DANNAY",param1));
      }
      
      public function removeBuff(param1:int) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < buffList.length)
         {
            if(buffList[_loc2_].id == param1)
            {
               buffList[_loc2_].state = 1;
               break;
            }
            _loc2_++;
         }
         buffList.splice(_loc2_,1);
      }
      
      public function addBuff(param1:MapBuffHurtData) : void
      {
         buffList.push(param1);
         this.dispatchEvent(new PhysicsEvent("ADD_BUFF",param1));
      }
      
      public function updateBuff(param1:MapBuffHurtData) : void
      {
         var _loc2_:MapBuffHurtData = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < buffList.length)
         {
            if(buffList[_loc3_].id == param1.id)
            {
               _loc2_ = buffList[_loc3_];
               break;
            }
            _loc3_++;
         }
         if(_loc2_)
         {
            _loc2_.updateWith(param1);
         }
         if(param1.state == 1)
         {
            removeBuff(param1.id);
         }
         else if(param1.state == 0)
         {
            addBuff(param1);
         }
      }
      
      public function cleanBuff() : void
      {
         var _loc1_:MapBuffHurtData = null;
         while(buffList.length != 0)
         {
            _loc1_ = buffList[0];
            removeBuff(_loc1_.id);
         }
         isStun = false;
      }
      
      public function useSkill(param1:MapSkillResultInfo) : void
      {
         dispatchEvent(new PhysicsEvent("USE_SKILL",param1));
      }
   }
}

