package com.road.yishi.proto.active
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class StarAreaMessage extends Message implements IExternalizable
   {
      
      private var roads$field:String;
      
      private var nodes$field:String;
      
      private var nowNode$field:int;
      
      private var hasField$0:uint = 0;
      
      private var actionPower$field:int;
      
      private var key$field:int;
      
      private var light$field:int;
      
      public function StarAreaMessage()
      {
         super();
      }
      
      public function removeRoads() : void
      {
         roads$field = null;
      }
      
      public function get hasRoads() : Boolean
      {
         return roads$field != null;
      }
      
      public function set roads(param1:String) : void
      {
         roads$field = param1;
      }
      
      public function get roads() : String
      {
         return roads$field;
      }
      
      public function removeNodes() : void
      {
         nodes$field = null;
      }
      
      public function get hasNodes() : Boolean
      {
         return nodes$field != null;
      }
      
      public function set nodes(param1:String) : void
      {
         nodes$field = param1;
      }
      
      public function get nodes() : String
      {
         return nodes$field;
      }
      
      public function removeNowNode() : void
      {
         hasField$0 &= 4294967294;
         nowNode$field = new int();
      }
      
      public function get hasNowNode() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set nowNode(param1:int) : void
      {
         hasField$0 |= 1;
         nowNode$field = param1;
      }
      
      public function get nowNode() : int
      {
         return nowNode$field;
      }
      
      public function removeActionPower() : void
      {
         hasField$0 &= 4294967293;
         actionPower$field = new int();
      }
      
      public function get hasActionPower() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set actionPower(param1:int) : void
      {
         hasField$0 |= 2;
         actionPower$field = param1;
      }
      
      public function get actionPower() : int
      {
         return actionPower$field;
      }
      
      public function removeKey() : void
      {
         hasField$0 &= 4294967291;
         key$field = new int();
      }
      
      public function get hasKey() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set key(param1:int) : void
      {
         hasField$0 |= 4;
         key$field = param1;
      }
      
      public function get key() : int
      {
         return key$field;
      }
      
      public function removeLight() : void
      {
         hasField$0 &= 4294967287;
         light$field = new int();
      }
      
      public function get hasLight() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set light(param1:int) : void
      {
         hasField$0 |= 8;
         light$field = param1;
      }
      
      public function get light() : int
      {
         return light$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRoads)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,roads$field);
         }
         if(hasNodes)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,nodes$field);
         }
         if(hasNowNode)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,nowNode$field);
         }
         if(hasActionPower)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,actionPower$field);
         }
         if(hasKey)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,key$field);
         }
         if(hasLight)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,light$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: StarAreaMessage.roads cannot be set twice.");
                  }
                  _loc5_++;
                  roads = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: StarAreaMessage.nodes cannot be set twice.");
                  }
                  _loc9_++;
                  nodes = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: StarAreaMessage.nowNode cannot be set twice.");
                  }
                  _loc8_++;
                  nowNode = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: StarAreaMessage.actionPower cannot be set twice.");
                  }
                  _loc6_++;
                  actionPower = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: StarAreaMessage.key cannot be set twice.");
                  }
                  _loc3_++;
                  key = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: StarAreaMessage.light cannot be set twice.");
                  }
                  _loc4_++;
                  light = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

