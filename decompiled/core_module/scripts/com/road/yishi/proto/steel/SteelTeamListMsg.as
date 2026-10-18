package com.road.yishi.proto.steel
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SteelTeamListMsg extends Message implements IExternalizable
   {
      
      private var param1$field:int;
      
      private var hasField$0:uint = 0;
      
      private var param2$field:int;
      
      private var param3$field:int;
      
      private var param4$field:String;
      
      private var param5$field:String;
      
      private var param6$field:String;
      
      private var states$field:int;
      
      private var group$field:int;
      
      private var eventType$field:int;
      
      [ArrayElementType("com.road.yishi.proto.steel.SteelTeamInfoMsg")]
      public var teamInfo:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.steel.SteelTeamInfoMsg")]
      public var applyInfo:Array = [];
      
      public function SteelTeamListMsg()
      {
         super();
      }
      
      public function removeParam1() : void
      {
         hasField$0 &= 4294967294;
         param1$field = new int();
      }
      
      public function get hasParam1() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set param1(param1:int) : void
      {
         hasField$0 |= 1;
         param1$field = param1;
      }
      
      public function get param1() : int
      {
         return param1$field;
      }
      
      public function removeParam2() : void
      {
         hasField$0 &= 4294967293;
         param2$field = new int();
      }
      
      public function get hasParam2() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set param2(param1:int) : void
      {
         hasField$0 |= 2;
         param2$field = param1;
      }
      
      public function get param2() : int
      {
         return param2$field;
      }
      
      public function removeParam3() : void
      {
         hasField$0 &= 4294967291;
         param3$field = new int();
      }
      
      public function get hasParam3() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set param3(param1:int) : void
      {
         hasField$0 |= 4;
         param3$field = param1;
      }
      
      public function get param3() : int
      {
         return param3$field;
      }
      
      public function removeParam4() : void
      {
         param4$field = null;
      }
      
      public function get hasParam4() : Boolean
      {
         return param4$field != null;
      }
      
      public function set param4(param1:String) : void
      {
         param4$field = param1;
      }
      
      public function get param4() : String
      {
         return param4$field;
      }
      
      public function removeParam5() : void
      {
         param5$field = null;
      }
      
      public function get hasParam5() : Boolean
      {
         return param5$field != null;
      }
      
      public function set param5(param1:String) : void
      {
         param5$field = param1;
      }
      
      public function get param5() : String
      {
         return param5$field;
      }
      
      public function removeParam6() : void
      {
         param6$field = null;
      }
      
      public function get hasParam6() : Boolean
      {
         return param6$field != null;
      }
      
      public function set param6(param1:String) : void
      {
         param6$field = param1;
      }
      
      public function get param6() : String
      {
         return param6$field;
      }
      
      public function removeStates() : void
      {
         hasField$0 &= 4294967287;
         states$field = new int();
      }
      
      public function get hasStates() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set states(param1:int) : void
      {
         hasField$0 |= 8;
         states$field = param1;
      }
      
      public function get states() : int
      {
         return states$field;
      }
      
      public function removeGroup() : void
      {
         hasField$0 &= 4294967279;
         group$field = new int();
      }
      
      public function get hasGroup() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set group(param1:int) : void
      {
         hasField$0 |= 16;
         group$field = param1;
      }
      
      public function get group() : int
      {
         return group$field;
      }
      
      public function removeEventType() : void
      {
         hasField$0 &= 4294967263;
         eventType$field = new int();
      }
      
      public function get hasEventType() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set eventType(param1:int) : void
      {
         hasField$0 |= 32;
         eventType$field = param1;
      }
      
      public function get eventType() : int
      {
         return eventType$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,param1$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,param2$field);
         }
         if(hasParam3)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,param3$field);
         }
         if(hasParam4)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,param4$field);
         }
         if(hasParam5)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,param5$field);
         }
         if(hasParam6)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,param6$field);
         }
         if(hasStates)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,states$field);
         }
         if(hasGroup)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,group$field);
         }
         if(hasEventType)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,eventType$field);
         }
         _loc2_ = 0;
         while(_loc2_ < teamInfo.length)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_MESSAGE(param1,teamInfo[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < applyInfo.length)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_MESSAGE(param1,applyInfo[_loc3_]);
            _loc3_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc4_:SteelTeamInfoMsg = null;
         var _loc3_:SteelTeamInfoMsg = null;
         var _loc5_:uint = 0;
         var _loc14_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc10_:uint = 0;
         var _loc13_:uint = 0;
         var _loc9_:uint = 0;
         var _loc11_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SteelTeamListMsg.param1 cannot be set twice.");
                  }
                  _loc5_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: SteelTeamListMsg.param2 cannot be set twice.");
                  }
                  _loc14_++;
                  param2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SteelTeamListMsg.param3 cannot be set twice.");
                  }
                  _loc6_++;
                  param3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SteelTeamListMsg.param4 cannot be set twice.");
                  }
                  _loc8_++;
                  param4 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: SteelTeamListMsg.param5 cannot be set twice.");
                  }
                  _loc10_++;
                  param5 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: SteelTeamListMsg.param6 cannot be set twice.");
                  }
                  _loc13_++;
                  param6 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: SteelTeamListMsg.states cannot be set twice.");
                  }
                  _loc9_++;
                  states = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: SteelTeamListMsg.group cannot be set twice.");
                  }
                  _loc11_++;
                  group = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SteelTeamListMsg.eventType cannot be set twice.");
                  }
                  _loc7_++;
                  eventType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  _loc4_ = new SteelTeamInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  teamInfo.push(_loc4_);
                  break;
               case 10:
                  _loc3_ = new SteelTeamInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  applyInfo.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

