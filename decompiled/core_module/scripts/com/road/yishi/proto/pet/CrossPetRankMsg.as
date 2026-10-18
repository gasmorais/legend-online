package com.road.yishi.proto.pet
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CrossPetRankMsg extends Message implements IExternalizable
   {
      
      private var myRank$field:PetRankMsg;
      
      [ArrayElementType("com.road.yishi.proto.pet.PetRankMsg")]
      public var otherRank:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.pet.PetLogMsg")]
      public var log:Array = [];
      
      private var auto_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var max_count$field:int;
      
      private var cur_count$field:int;
      
      private var time$field:String;
      
      private var type$field:int;
      
      private var server_id$field:int;
      
      private var server_name$field:String;
      
      private var address$field:String;
      
      private var port$field:int;
      
      private var param1$field:int;
      
      private var param2$field:String;
      
      private var param3$field:Boolean;
      
      private var is_fresh$field:Boolean;
      
      public function CrossPetRankMsg()
      {
         super();
      }
      
      public function removeMyRank() : void
      {
         myRank$field = null;
      }
      
      public function get hasMyRank() : Boolean
      {
         return myRank$field != null;
      }
      
      public function set myRank(param1:PetRankMsg) : void
      {
         myRank$field = param1;
      }
      
      public function get myRank() : PetRankMsg
      {
         return myRank$field;
      }
      
      public function removeAutoId() : void
      {
         hasField$0 &= 4294967294;
         auto_id$field = new int();
      }
      
      public function get hasAutoId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set autoId(param1:int) : void
      {
         hasField$0 |= 1;
         auto_id$field = param1;
      }
      
      public function get autoId() : int
      {
         return auto_id$field;
      }
      
      public function removeMaxCount() : void
      {
         hasField$0 &= 4294967293;
         max_count$field = new int();
      }
      
      public function get hasMaxCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set maxCount(param1:int) : void
      {
         hasField$0 |= 2;
         max_count$field = param1;
      }
      
      public function get maxCount() : int
      {
         return max_count$field;
      }
      
      public function removeCurCount() : void
      {
         hasField$0 &= 4294967291;
         cur_count$field = new int();
      }
      
      public function get hasCurCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set curCount(param1:int) : void
      {
         hasField$0 |= 4;
         cur_count$field = param1;
      }
      
      public function get curCount() : int
      {
         return cur_count$field;
      }
      
      public function removeTime() : void
      {
         time$field = null;
      }
      
      public function get hasTime() : Boolean
      {
         return time$field != null;
      }
      
      public function set time(param1:String) : void
      {
         time$field = param1;
      }
      
      public function get time() : String
      {
         return time$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967287;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 8;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeServerId() : void
      {
         hasField$0 &= 4294967279;
         server_id$field = new int();
      }
      
      public function get hasServerId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set serverId(param1:int) : void
      {
         hasField$0 |= 16;
         server_id$field = param1;
      }
      
      public function get serverId() : int
      {
         return server_id$field;
      }
      
      public function removeServerName() : void
      {
         server_name$field = null;
      }
      
      public function get hasServerName() : Boolean
      {
         return server_name$field != null;
      }
      
      public function set serverName(param1:String) : void
      {
         server_name$field = param1;
      }
      
      public function get serverName() : String
      {
         return server_name$field;
      }
      
      public function removeAddress() : void
      {
         address$field = null;
      }
      
      public function get hasAddress() : Boolean
      {
         return address$field != null;
      }
      
      public function set address(param1:String) : void
      {
         address$field = param1;
      }
      
      public function get address() : String
      {
         return address$field;
      }
      
      public function removePort() : void
      {
         hasField$0 &= 4294967263;
         port$field = new int();
      }
      
      public function get hasPort() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set port(param1:int) : void
      {
         hasField$0 |= 32;
         port$field = param1;
      }
      
      public function get port() : int
      {
         return port$field;
      }
      
      public function removeParam1() : void
      {
         hasField$0 &= 4294967231;
         param1$field = new int();
      }
      
      public function get hasParam1() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set param1(param1:int) : void
      {
         hasField$0 |= 64;
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
         hasField$0 &= 4294967167;
         param3$field = new Boolean();
      }
      
      public function get hasParam3() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set param3(param1:Boolean) : void
      {
         hasField$0 |= 128;
         param3$field = param1;
      }
      
      public function get param3() : Boolean
      {
         return param3$field;
      }
      
      public function removeIsFresh() : void
      {
         hasField$0 &= 4294967039;
         is_fresh$field = new Boolean();
      }
      
      public function get hasIsFresh() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set isFresh(param1:Boolean) : void
      {
         hasField$0 |= 256;
         is_fresh$field = param1;
      }
      
      public function get isFresh() : Boolean
      {
         return is_fresh$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasMyRank)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,myRank$field);
         }
         _loc3_ = 0;
         while(_loc3_ < otherRank.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,otherRank[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < log.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,log[_loc2_]);
            _loc2_++;
         }
         if(hasAutoId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,auto_id$field);
         }
         if(hasMaxCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,max_count$field);
         }
         if(hasCurCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,cur_count$field);
         }
         if(hasTime)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,time$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasServerId)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,server_id$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
         if(hasAddress)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,address$field);
         }
         if(hasPort)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,port$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,param1$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,2,14);
            WriteUtils.write$TYPE_STRING(param1,param2$field);
         }
         if(hasParam3)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_BOOL(param1,param3$field);
         }
         if(hasIsFresh)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_BOOL(param1,is_fresh$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc16_:* = 0;
         var _loc13_:PetRankMsg = null;
         var _loc14_:PetLogMsg = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc15_:uint = 0;
         var _loc11_:uint = 0;
         var _loc17_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc10_:uint = 0;
         var _loc6_:uint = 0;
         var _loc12_:uint = 0;
         var _loc7_:uint = 0;
         var _loc19_:uint = 0;
         var _loc8_:uint = 0;
         var _loc18_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc16_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CrossPetRankMsg.myRank cannot be set twice.");
                  }
                  _loc3_++;
                  myRank = new PetRankMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,myRank);
                  break;
               case 1:
                  _loc13_ = new PetRankMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc13_);
                  otherRank.push(_loc13_);
                  break;
               case 2:
                  _loc14_ = new PetLogMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc14_);
                  log.push(_loc14_);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CrossPetRankMsg.autoId cannot be set twice.");
                  }
                  _loc4_++;
                  autoId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: CrossPetRankMsg.maxCount cannot be set twice.");
                  }
                  _loc15_++;
                  maxCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: CrossPetRankMsg.curCount cannot be set twice.");
                  }
                  _loc11_++;
                  curCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: CrossPetRankMsg.time cannot be set twice.");
                  }
                  _loc17_++;
                  time = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: CrossPetRankMsg.type cannot be set twice.");
                  }
                  _loc9_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CrossPetRankMsg.serverId cannot be set twice.");
                  }
                  _loc5_++;
                  serverId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: CrossPetRankMsg.serverName cannot be set twice.");
                  }
                  _loc10_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: CrossPetRankMsg.address cannot be set twice.");
                  }
                  _loc6_++;
                  address = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 11:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: CrossPetRankMsg.port cannot be set twice.");
                  }
                  _loc12_++;
                  port = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CrossPetRankMsg.param1 cannot be set twice.");
                  }
                  _loc7_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: CrossPetRankMsg.param2 cannot be set twice.");
                  }
                  _loc19_++;
                  param2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 14:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: CrossPetRankMsg.param3 cannot be set twice.");
                  }
                  _loc8_++;
                  param3 = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 15:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: CrossPetRankMsg.isFresh cannot be set twice.");
                  }
                  _loc18_++;
                  isFresh = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc16_ & 7);
            }
         }
      }
   }
}

