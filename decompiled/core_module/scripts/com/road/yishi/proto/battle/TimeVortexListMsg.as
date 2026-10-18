package com.road.yishi.proto.battle
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TimeVortexListMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.battle.TimeVortexInfoMsg")]
      public var vortexList:Array = [];
      
      private var opType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var userId$field:int;
      
      private var uuid$field:String;
      
      private var param1$field:int;
      
      private var param2$field:String;
      
      private var param3$field:String;
      
      private var param4$field:int;
      
      private var param5$field:int;
      
      [ArrayElementType("com.road.yishi.proto.battle.TimeVortexInfoMsg")]
      public var hourRewardList:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.battle.TimeVortexInfoMsg")]
      public var finalRewardList:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.battle.TimeVortexInfoMsg")]
      public var crackList:Array = [];
      
      private var revengeNodeId$field:int;
      
      private var revengeTime$field:String;
      
      public function TimeVortexListMsg()
      {
         super();
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294967294;
         opType$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 1;
         opType$field = param1;
      }
      
      public function get opType() : int
      {
         return opType$field;
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967293;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 2;
         userId$field = param1;
      }
      
      public function get userId() : int
      {
         return userId$field;
      }
      
      public function removeUuid() : void
      {
         uuid$field = null;
      }
      
      public function get hasUuid() : Boolean
      {
         return uuid$field != null;
      }
      
      public function set uuid(param1:String) : void
      {
         uuid$field = param1;
      }
      
      public function get uuid() : String
      {
         return uuid$field;
      }
      
      public function removeParam1() : void
      {
         hasField$0 &= 4294967291;
         param1$field = new int();
      }
      
      public function get hasParam1() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set param1(param1:int) : void
      {
         hasField$0 |= 4;
         param1$field = param1;
      }
      
      public function get param1() : int
      {
         return param1$field;
      }
      
      public function removeParam2() : void
      {
         param2$field = null;
      }
      
      public function get hasParam2() : Boolean
      {
         return param2$field != null;
      }
      
      public function set param2(param1:String) : void
      {
         param2$field = param1;
      }
      
      public function get param2() : String
      {
         return param2$field;
      }
      
      public function removeParam3() : void
      {
         param3$field = null;
      }
      
      public function get hasParam3() : Boolean
      {
         return param3$field != null;
      }
      
      public function set param3(param1:String) : void
      {
         param3$field = param1;
      }
      
      public function get param3() : String
      {
         return param3$field;
      }
      
      public function removeParam4() : void
      {
         hasField$0 &= 4294967287;
         param4$field = new int();
      }
      
      public function get hasParam4() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set param4(param1:int) : void
      {
         hasField$0 |= 8;
         param4$field = param1;
      }
      
      public function get param4() : int
      {
         return param4$field;
      }
      
      public function removeParam5() : void
      {
         hasField$0 &= 4294967279;
         param5$field = new int();
      }
      
      public function get hasParam5() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set param5(param1:int) : void
      {
         hasField$0 |= 16;
         param5$field = param1;
      }
      
      public function get param5() : int
      {
         return param5$field;
      }
      
      public function removeRevengeNodeId() : void
      {
         hasField$0 &= 4294967263;
         revengeNodeId$field = new int();
      }
      
      public function get hasRevengeNodeId() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set revengeNodeId(param1:int) : void
      {
         hasField$0 |= 32;
         revengeNodeId$field = param1;
      }
      
      public function get revengeNodeId() : int
      {
         return revengeNodeId$field;
      }
      
      public function removeRevengeTime() : void
      {
         revengeTime$field = null;
      }
      
      public function get hasRevengeTime() : Boolean
      {
         return revengeTime$field != null;
      }
      
      public function set revengeTime(param1:String) : void
      {
         revengeTime$field = param1;
      }
      
      public function get revengeTime() : String
      {
         return revengeTime$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc2_:* = 0;
         var _loc5_:* = 0;
         _loc3_ = 0;
         while(_loc3_ < vortexList.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,vortexList[_loc3_]);
            _loc3_++;
         }
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,opType$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasUuid)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,uuid$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,param1$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,param2$field);
         }
         if(hasParam3)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,param3$field);
         }
         if(hasParam4)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,param4$field);
         }
         if(hasParam5)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,param5$field);
         }
         _loc4_ = 0;
         while(_loc4_ < hourRewardList.length)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_MESSAGE(param1,hourRewardList[_loc4_]);
            _loc4_++;
         }
         _loc2_ = 0;
         while(_loc2_ < finalRewardList.length)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_MESSAGE(param1,finalRewardList[_loc2_]);
            _loc2_++;
         }
         _loc5_ = 0;
         while(_loc5_ < crackList.length)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_MESSAGE(param1,crackList[_loc5_]);
            _loc5_++;
         }
         if(hasRevengeNodeId)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,revengeNodeId$field);
         }
         if(hasRevengeTime)
         {
            WriteUtils.writeTag(param1,2,14);
            WriteUtils.write$TYPE_STRING(param1,revengeTime$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc14_:* = 0;
         var _loc8_:TimeVortexInfoMsg = null;
         var _loc15_:TimeVortexInfoMsg = null;
         var _loc17_:TimeVortexInfoMsg = null;
         var _loc13_:TimeVortexInfoMsg = null;
         var _loc12_:uint = 0;
         var _loc7_:uint = 0;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         var _loc16_:uint = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         var _loc11_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc14_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc8_ = new TimeVortexInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc8_);
                  vortexList.push(_loc8_);
                  break;
               case 1:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: TimeVortexListMsg.opType cannot be set twice.");
                  }
                  _loc12_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: TimeVortexListMsg.userId cannot be set twice.");
                  }
                  _loc7_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: TimeVortexListMsg.uuid cannot be set twice.");
                  }
                  _loc10_++;
                  uuid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TimeVortexListMsg.param1 cannot be set twice.");
                  }
                  _loc4_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: TimeVortexListMsg.param2 cannot be set twice.");
                  }
                  _loc16_++;
                  param2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TimeVortexListMsg.param3 cannot be set twice.");
                  }
                  _loc5_++;
                  param3 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: TimeVortexListMsg.param4 cannot be set twice.");
                  }
                  _loc9_++;
                  param4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: TimeVortexListMsg.param5 cannot be set twice.");
                  }
                  _loc11_++;
                  param5 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  _loc15_ = new TimeVortexInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc15_);
                  hourRewardList.push(_loc15_);
                  break;
               case 10:
                  _loc17_ = new TimeVortexInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc17_);
                  finalRewardList.push(_loc17_);
                  break;
               case 11:
                  _loc13_ = new TimeVortexInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc13_);
                  crackList.push(_loc13_);
                  break;
               case 12:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TimeVortexListMsg.revengeNodeId cannot be set twice.");
                  }
                  _loc3_++;
                  revengeNodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: TimeVortexListMsg.revengeTime cannot be set twice.");
                  }
                  _loc6_++;
                  revengeTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc14_ & 7);
            }
         }
      }
   }
}

