package com.road.yishi.proto.active
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ActiveMsgLeaveOp extends Message implements IExternalizable
   {
      
      private var op_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var msg_type$field:int;
      
      private var msg_str$field:String;
      
      private var count$field:int;
      
      private var result$field:Boolean;
      
      private var param1$field:String;
      
      private var param2$field:String;
      
      private var param3$field:int;
      
      [ArrayElementType("com.road.yishi.proto.active.ActiveMsgLeaveInfo")]
      public var msgList:Array = [];
      
      public function ActiveMsgLeaveOp()
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
      
      public function removeMsgType() : void
      {
         hasField$0 &= 4294967293;
         msg_type$field = new int();
      }
      
      public function get hasMsgType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set msgType(param1:int) : void
      {
         hasField$0 |= 2;
         msg_type$field = param1;
      }
      
      public function get msgType() : int
      {
         return msg_type$field;
      }
      
      public function removeMsgStr() : void
      {
         msg_str$field = null;
      }
      
      public function get hasMsgStr() : Boolean
      {
         return msg_str$field != null;
      }
      
      public function set msgStr(param1:String) : void
      {
         msg_str$field = param1;
      }
      
      public function get msgStr() : String
      {
         return msg_str$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967291;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 4;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeResult() : void
      {
         hasField$0 &= 4294967287;
         result$field = new Boolean();
      }
      
      public function get hasResult() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set result(param1:Boolean) : void
      {
         hasField$0 |= 8;
         result$field = param1;
      }
      
      public function get result() : Boolean
      {
         return result$field;
      }
      
      public function removeParam1() : void
      {
         param1$field = null;
      }
      
      public function get hasParam1() : Boolean
      {
         return param1$field != null;
      }
      
      public function set param1(param1:String) : void
      {
         param1$field = param1;
      }
      
      public function get param1() : String
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
         hasField$0 &= 4294967279;
         param3$field = new int();
      }
      
      public function get hasParam3() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set param3(param1:int) : void
      {
         hasField$0 |= 16;
         param3$field = param1;
      }
      
      public function get param3() : int
      {
         return param3$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op_type$field);
         }
         if(hasMsgType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,msg_type$field);
         }
         if(hasMsgStr)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,msg_str$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_BOOL(param1,result$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,param1$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,param2$field);
         }
         if(hasParam3)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,param3$field);
         }
         _loc2_ = 0;
         while(_loc2_ < msgList.length)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_MESSAGE(param1,msgList[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc11_:* = 0;
         var _loc4_:ActiveMsgLeaveInfo = null;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc10_:uint = 0;
         var _loc8_:uint = 0;
         var _loc12_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc11_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveMsgLeaveOp.opType cannot be set twice.");
                  }
                  _loc7_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveMsgLeaveOp.msgType cannot be set twice.");
                  }
                  _loc5_++;
                  msgType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveMsgLeaveOp.msgStr cannot be set twice.");
                  }
                  _loc3_++;
                  msgStr = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveMsgLeaveOp.count cannot be set twice.");
                  }
                  _loc6_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveMsgLeaveOp.result cannot be set twice.");
                  }
                  _loc10_++;
                  result = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveMsgLeaveOp.param1 cannot be set twice.");
                  }
                  _loc8_++;
                  param1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveMsgLeaveOp.param2 cannot be set twice.");
                  }
                  _loc12_++;
                  param2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveMsgLeaveOp.param3 cannot be set twice.");
                  }
                  _loc9_++;
                  param3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  _loc4_ = new ActiveMsgLeaveInfo();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  msgList.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc11_ & 7);
            }
         }
      }
   }
}

