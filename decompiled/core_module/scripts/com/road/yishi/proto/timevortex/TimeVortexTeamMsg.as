package com.road.yishi.proto.timevortex
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TimeVortexTeamMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.timevortex.TeammatesInfoMsg")]
      public var teamList:Array = [];
      
      private var param1$field:int;
      
      private var hasField$0:uint = 0;
      
      private var param2$field:String;
      
      private var param3$field:String;
      
      private var param4$field:int;
      
      private var param5$field:int;
      
      public function TimeVortexTeamMsg()
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
         hasField$0 &= 4294967293;
         param4$field = new int();
      }
      
      public function get hasParam4() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set param4(param1:int) : void
      {
         hasField$0 |= 2;
         param4$field = param1;
      }
      
      public function get param4() : int
      {
         return param4$field;
      }
      
      public function removeParam5() : void
      {
         hasField$0 &= 4294967291;
         param5$field = new int();
      }
      
      public function get hasParam5() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set param5(param1:int) : void
      {
         hasField$0 |= 4;
         param5$field = param1;
      }
      
      public function get param5() : int
      {
         return param5$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < teamList.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,teamList[_loc2_]);
            _loc2_++;
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,param1$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,param2$field);
         }
         if(hasParam3)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,param3$field);
         }
         if(hasParam4)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,param4$field);
         }
         if(hasParam5)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,param5$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc6_:TeammatesInfoMsg = null;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc6_ = new TeammatesInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  teamList.push(_loc6_);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TimeVortexTeamMsg.param1 cannot be set twice.");
                  }
                  _loc4_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: TimeVortexTeamMsg.param2 cannot be set twice.");
                  }
                  _loc9_++;
                  param2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TimeVortexTeamMsg.param3 cannot be set twice.");
                  }
                  _loc5_++;
                  param3 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: TimeVortexTeamMsg.param4 cannot be set twice.");
                  }
                  _loc8_++;
                  param4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TimeVortexTeamMsg.param5 cannot be set twice.");
                  }
                  _loc3_++;
                  param5 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

