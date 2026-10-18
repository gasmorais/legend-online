package com.road.yishi.proto.pet
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PokerOpMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var user_id$field:int;
      
      private var server_name$field:String;
      
      private var param_msg$field:ByteArray;
      
      private var param1$field:int;
      
      private var param2$field:String;
      
      private var msg$field:TableChannelMessage;
      
      private var param3$field:Boolean;
      
      public function PokerOpMsg()
      {
         super();
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967294;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 1;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967293;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 2;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
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
      
      public function removeParamMsg() : void
      {
         param_msg$field = null;
      }
      
      public function get hasParamMsg() : Boolean
      {
         return param_msg$field != null;
      }
      
      public function set paramMsg(param1:ByteArray) : void
      {
         param_msg$field = param1;
      }
      
      public function get paramMsg() : ByteArray
      {
         return param_msg$field;
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
      
      public function removeMsg() : void
      {
         msg$field = null;
      }
      
      public function get hasMsg() : Boolean
      {
         return msg$field != null;
      }
      
      public function set msg(param1:TableChannelMessage) : void
      {
         msg$field = param1;
      }
      
      public function get msg() : TableChannelMessage
      {
         return msg$field;
      }
      
      public function removeParam3() : void
      {
         hasField$0 &= 4294967287;
         param3$field = new Boolean();
      }
      
      public function get hasParam3() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set param3(param1:Boolean) : void
      {
         hasField$0 |= 8;
         param3$field = param1;
      }
      
      public function get param3() : Boolean
      {
         return param3$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_ENUM(param1,op$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
         if(hasParamMsg)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_BYTES(param1,param_msg$field);
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
         if(hasMsg)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_MESSAGE(param1,msg$field);
         }
         if(hasParam3)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_BOOL(param1,param3$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc11_:uint = 0;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PokerOpMsg.op cannot be set twice.");
                  }
                  _loc9_++;
                  op = ReadUtils.read$TYPE_ENUM(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PokerOpMsg.userId cannot be set twice.");
                  }
                  _loc5_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PokerOpMsg.serverName cannot be set twice.");
                  }
                  _loc8_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PokerOpMsg.paramMsg cannot be set twice.");
                  }
                  _loc6_++;
                  paramMsg = ReadUtils.read$TYPE_BYTES(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PokerOpMsg.param1 cannot be set twice.");
                  }
                  _loc3_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: PokerOpMsg.param2 cannot be set twice.");
                  }
                  _loc11_++;
                  param2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PokerOpMsg.msg cannot be set twice.");
                  }
                  _loc10_++;
                  msg = new TableChannelMessage();
                  ReadUtils.read$TYPE_MESSAGE(param1,msg);
                  break;
               case 7:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PokerOpMsg.param3 cannot be set twice.");
                  }
                  _loc4_++;
                  param3 = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

