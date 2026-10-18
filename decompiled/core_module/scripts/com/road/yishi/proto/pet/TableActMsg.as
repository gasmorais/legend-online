package com.road.yishi.proto.pet
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TableActMsg extends Message implements IExternalizable
   {
      
      private var action$field:int;
      
      private var hasField$0:uint = 0;
      
      private var amount$field:int;
      
      private var server_name$field:String;
      
      private var param1$field:String;
      
      public function TableActMsg()
      {
         super();
      }
      
      public function removeAction() : void
      {
         hasField$0 &= 4294967294;
         action$field = new int();
      }
      
      public function get hasAction() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set action(param1:int) : void
      {
         hasField$0 |= 1;
         action$field = param1;
      }
      
      public function get action() : int
      {
         return action$field;
      }
      
      public function removeAmount() : void
      {
         hasField$0 &= 4294967293;
         amount$field = new int();
      }
      
      public function get hasAmount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set amount(param1:int) : void
      {
         hasField$0 |= 2;
         amount$field = param1;
      }
      
      public function get amount() : int
      {
         return amount$field;
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
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasAction)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_ENUM(param1,action$field);
         }
         if(hasAmount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,amount$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,param1$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: TableActMsg.action cannot be set twice.");
                  }
                  _loc7_++;
                  action = ReadUtils.read$TYPE_ENUM(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TableActMsg.amount cannot be set twice.");
                  }
                  _loc4_++;
                  amount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: TableActMsg.serverName cannot be set twice.");
                  }
                  _loc6_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TableActMsg.param1 cannot be set twice.");
                  }
                  _loc3_++;
                  param1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

