package com.road.yishi.proto.gods
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CrossGodsMsg extends Message implements IExternalizable
   {
      
      private var op_type$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.gods.CrossGodsInfoMsg")]
      public var info:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.gods.GodsPlayerInfoMsg")]
      public var playerInfo:Array = [];
      
      private var gameType$field:int;
      
      private var param1$field:Int64;
      
      private var param2$field:Int64;
      
      private var param3$field:int;
      
      private var param4$field:int;
      
      [ArrayElementType("com.road.yishi.proto.gods.GodsTaskInfoMsg")]
      public var taskInfo:Array = [];
      
      private var server_name$field:String;
      
      private var user_id$field:int;
      
      private var my_info$field:GodsPlayerInfoMsg;
      
      private var openTime$field:String;
      
      private var stopTime$field:String;
      
      public function CrossGodsMsg()
      {
         super();
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294967294;
         op_type$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 1;
         op_type$field = param1;
      }
      
      public function get opType() : int
      {
         return op_type$field;
      }
      
      public function removeGameType() : void
      {
         hasField$0 &= 4294967293;
         gameType$field = new int();
      }
      
      public function get hasGameType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set gameType(param1:int) : void
      {
         hasField$0 |= 2;
         gameType$field = param1;
      }
      
      public function get gameType() : int
      {
         return gameType$field;
      }
      
      public function removeParam1() : void
      {
         param1$field = null;
      }
      
      public function get hasParam1() : Boolean
      {
         return param1$field != null;
      }
      
      public function set param1(param1:Int64) : void
      {
         param1$field = param1;
      }
      
      public function get param1() : Int64
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
      
      public function set param2(param1:Int64) : void
      {
         param2$field = param1;
      }
      
      public function get param2() : Int64
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
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967279;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 16;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
      }
      
      public function removeMyInfo() : void
      {
         my_info$field = null;
      }
      
      public function get hasMyInfo() : Boolean
      {
         return my_info$field != null;
      }
      
      public function set myInfo(param1:GodsPlayerInfoMsg) : void
      {
         my_info$field = param1;
      }
      
      public function get myInfo() : GodsPlayerInfoMsg
      {
         return my_info$field;
      }
      
      public function removeOpenTime() : void
      {
         openTime$field = null;
      }
      
      public function get hasOpenTime() : Boolean
      {
         return openTime$field != null;
      }
      
      public function set openTime(param1:String) : void
      {
         openTime$field = param1;
      }
      
      public function get openTime() : String
      {
         return openTime$field;
      }
      
      public function removeStopTime() : void
      {
         stopTime$field = null;
      }
      
      public function get hasStopTime() : Boolean
      {
         return stopTime$field != null;
      }
      
      public function set stopTime(param1:String) : void
      {
         stopTime$field = param1;
      }
      
      public function get stopTime() : String
      {
         return stopTime$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc2_:* = 0;
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op_type$field);
         }
         _loc3_ = 0;
         while(_loc3_ < info.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,info[_loc3_]);
            _loc3_++;
         }
         _loc4_ = 0;
         while(_loc4_ < playerInfo.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,playerInfo[_loc4_]);
            _loc4_++;
         }
         if(hasGameType)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,gameType$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT64(param1,param1$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT64(param1,param2$field);
         }
         if(hasParam3)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,param3$field);
         }
         if(hasParam4)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,param4$field);
         }
         _loc2_ = 0;
         while(_loc2_ < taskInfo.length)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_MESSAGE(param1,taskInfo[_loc2_]);
            _loc2_++;
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasMyInfo)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_MESSAGE(param1,my_info$field);
         }
         if(hasOpenTime)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_STRING(param1,openTime$field);
         }
         if(hasStopTime)
         {
            WriteUtils.writeTag(param1,2,14);
            WriteUtils.write$TYPE_STRING(param1,stopTime$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc15_:* = 0;
         var _loc13_:CrossGodsInfoMsg = null;
         var _loc11_:GodsPlayerInfoMsg = null;
         var _loc17_:GodsTaskInfoMsg = null;
         var _loc12_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc16_:uint = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         var _loc14_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc15_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: CrossGodsMsg.opType cannot be set twice.");
                  }
                  _loc12_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc13_ = new CrossGodsInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc13_);
                  info.push(_loc13_);
                  break;
               case 2:
                  _loc11_ = new GodsPlayerInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc11_);
                  playerInfo.push(_loc11_);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CrossGodsMsg.gameType cannot be set twice.");
                  }
                  _loc5_++;
                  gameType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CrossGodsMsg.param1 cannot be set twice.");
                  }
                  _loc3_++;
                  param1 = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 5:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: CrossGodsMsg.param2 cannot be set twice.");
                  }
                  _loc16_++;
                  param2 = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CrossGodsMsg.param3 cannot be set twice.");
                  }
                  _loc4_++;
                  param3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: CrossGodsMsg.param4 cannot be set twice.");
                  }
                  _loc9_++;
                  param4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  _loc17_ = new GodsTaskInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc17_);
                  taskInfo.push(_loc17_);
                  break;
               case 9:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CrossGodsMsg.serverName cannot be set twice.");
                  }
                  _loc7_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: CrossGodsMsg.userId cannot be set twice.");
                  }
                  _loc14_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: CrossGodsMsg.myInfo cannot be set twice.");
                  }
                  _loc6_++;
                  myInfo = new GodsPlayerInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,myInfo);
                  break;
               case 12:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: CrossGodsMsg.openTime cannot be set twice.");
                  }
                  _loc8_++;
                  openTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 13:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: CrossGodsMsg.stopTime cannot be set twice.");
                  }
                  _loc10_++;
                  stopTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc15_ & 7);
            }
         }
      }
   }
}

