package com.road.yishi.proto.seek.SeekNodeListMsg
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SeekNodeMsg extends Message implements IExternalizable
   {
      
      private var nodeId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var nodeName$field:String;
      
      private var pointX$field:int;
      
      private var pointY$field:int;
      
      public function SeekNodeMsg()
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
      
      public function removeNodeName() : void
      {
         nodeName$field = null;
      }
      
      public function get hasNodeName() : Boolean
      {
         return nodeName$field != null;
      }
      
      public function set nodeName(param1:String) : void
      {
         nodeName$field = param1;
      }
      
      public function get nodeName() : String
      {
         return nodeName$field;
      }
      
      public function removePointX() : void
      {
         hasField$0 &= 4294967293;
         pointX$field = new int();
      }
      
      public function get hasPointX() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set pointX(param1:int) : void
      {
         hasField$0 |= 2;
         pointX$field = param1;
      }
      
      public function get pointX() : int
      {
         return pointX$field;
      }
      
      public function removePointY() : void
      {
         hasField$0 &= 4294967291;
         pointY$field = new int();
      }
      
      public function get hasPointY() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set pointY(param1:int) : void
      {
         hasField$0 |= 4;
         pointY$field = param1;
      }
      
      public function get pointY() : int
      {
         return pointY$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasNodeId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,nodeId$field);
         }
         if(hasNodeName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,nodeName$field);
         }
         if(hasPointX)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,pointX$field);
         }
         if(hasPointY)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,pointY$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SeekNodeMsg.nodeId cannot be set twice.");
                  }
                  _loc3_++;
                  nodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SeekNodeMsg.nodeName cannot be set twice.");
                  }
                  _loc7_++;
                  nodeName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SeekNodeMsg.pointX cannot be set twice.");
                  }
                  _loc5_++;
                  pointX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SeekNodeMsg.pointY cannot be set twice.");
                  }
                  _loc4_++;
                  pointY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

