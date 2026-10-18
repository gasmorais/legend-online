package com.road.yishi.proto.monster
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MonsterExploreFightMsg extends Message implements IExternalizable
   {
      
      private var state$field:int;
      
      private var hasField$0:uint = 0;
      
      private var stateTime$field:int;
      
      [ArrayElementType("com.road.yishi.proto.monster.MonsterExploreHeroMsg")]
      public var attackers:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.monster.MonsterExploreHeroMsg")]
      public var defender:Array = [];
      
      private var isEditSwitch$field:Boolean;
      
      public function MonsterExploreFightMsg()
      {
         super();
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967294;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 1;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeStateTime() : void
      {
         hasField$0 &= 4294967293;
         stateTime$field = new int();
      }
      
      public function get hasStateTime() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set stateTime(param1:int) : void
      {
         hasField$0 |= 2;
         stateTime$field = param1;
      }
      
      public function get stateTime() : int
      {
         return stateTime$field;
      }
      
      public function removeIsEditSwitch() : void
      {
         hasField$0 &= 4294967291;
         isEditSwitch$field = new Boolean();
      }
      
      public function get hasIsEditSwitch() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set isEditSwitch(param1:Boolean) : void
      {
         hasField$0 |= 4;
         isEditSwitch$field = param1;
      }
      
      public function get isEditSwitch() : Boolean
      {
         return isEditSwitch$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasStateTime)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,stateTime$field);
         }
         _loc2_ = 0;
         while(_loc2_ < attackers.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,attackers[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < defender.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,defender[_loc3_]);
            _loc3_++;
         }
         if(hasIsEditSwitch)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_BOOL(param1,isEditSwitch$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:MonsterExploreHeroMsg = null;
         var _loc7_:MonsterExploreHeroMsg = null;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterExploreFightMsg.state cannot be set twice.");
                  }
                  _loc4_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterExploreFightMsg.stateTime cannot be set twice.");
                  }
                  _loc6_++;
                  stateTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  _loc3_ = new MonsterExploreHeroMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  attackers.push(_loc3_);
                  break;
               case 3:
                  _loc7_ = new MonsterExploreHeroMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  defender.push(_loc7_);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterExploreFightMsg.isEditSwitch cannot be set twice.");
                  }
                  _loc8_++;
                  isEditSwitch = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

