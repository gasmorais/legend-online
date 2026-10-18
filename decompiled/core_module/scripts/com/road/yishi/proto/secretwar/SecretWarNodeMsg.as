package com.road.yishi.proto.secretwar
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SecretWarNodeMsg extends Message implements IExternalizable
   {
      
      private var nodeId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var type$field:int;
      
      private var cdTime$field:int;
      
      private var isPop$field:Boolean;
      
      public function SecretWarNodeMsg()
      {
         super();
      }
      
      public function removeNodeId() : void
      {
         hasField$0 &= 4294967294;
         nodeId$field = new int();
      }
      
      public function get hasNodeId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set nodeId(param1:int) : void
      {
         hasField$0 |= 1;
         nodeId$field = param1;
      }
      
      public function get nodeId() : int
      {
         return nodeId$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967293;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 2;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeCdTime() : void
      {
         hasField$0 &= 4294967291;
         cdTime$field = new int();
      }
      
      public function get hasCdTime() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set cdTime(param1:int) : void
      {
         hasField$0 |= 4;
         cdTime$field = param1;
      }
      
      public function get cdTime() : int
      {
         return cdTime$field;
      }
      
      public function removeIsPop() : void
      {
         hasField$0 &= 4294967287;
         isPop$field = new Boolean();
      }
      
      public function get hasIsPop() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set isPop(param1:Boolean) : void
      {
         hasField$0 |= 8;
         isPop$field = param1;
      }
      
      public function get isPop() : Boolean
      {
         return isPop$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasNodeId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,nodeId$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasCdTime)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,cdTime$field);
         }
         if(hasIsPop)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,isPop$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarNodeMsg.nodeId cannot be set twice.");
                  }
                  _loc3_++;
                  nodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarNodeMsg.type cannot be set twice.");
                  }
                  _loc5_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarNodeMsg.cdTime cannot be set twice.");
                  }
                  _loc4_++;
                  cdTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarNodeMsg.isPop cannot be set twice.");
                  }
                  _loc7_++;
                  isPop = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

