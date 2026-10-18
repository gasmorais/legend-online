package com.road.yishi.proto.module
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RemainsExploreNodeMsg extends Message implements IExternalizable
   {
      
      private var checkpointId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var chapterId$field:int;
      
      private var node$field:int;
      
      private var progress$field:int;
      
      private var exploreCost$field:int;
      
      private var isBoss1Pass$field:Boolean;
      
      private var isBoss2Pass$field:Boolean;
      
      public function RemainsExploreNodeMsg()
      {
         super();
      }
      
      public function removeCheckpointId() : void
      {
         hasField$0 &= 4294967294;
         checkpointId$field = new int();
      }
      
      public function get hasCheckpointId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set checkpointId(param1:int) : void
      {
         hasField$0 |= 1;
         checkpointId$field = param1;
      }
      
      public function get checkpointId() : int
      {
         return checkpointId$field;
      }
      
      public function removeChapterId() : void
      {
         hasField$0 &= 4294967293;
         chapterId$field = new int();
      }
      
      public function get hasChapterId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set chapterId(param1:int) : void
      {
         hasField$0 |= 2;
         chapterId$field = param1;
      }
      
      public function get chapterId() : int
      {
         return chapterId$field;
      }
      
      public function removeNode() : void
      {
         hasField$0 &= 4294967291;
         node$field = new int();
      }
      
      public function get hasNode() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set node(param1:int) : void
      {
         hasField$0 |= 4;
         node$field = param1;
      }
      
      public function get node() : int
      {
         return node$field;
      }
      
      public function removeProgress() : void
      {
         hasField$0 &= 4294967287;
         progress$field = new int();
      }
      
      public function get hasProgress() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set progress(param1:int) : void
      {
         hasField$0 |= 8;
         progress$field = param1;
      }
      
      public function get progress() : int
      {
         return progress$field;
      }
      
      public function removeExploreCost() : void
      {
         hasField$0 &= 4294967279;
         exploreCost$field = new int();
      }
      
      public function get hasExploreCost() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set exploreCost(param1:int) : void
      {
         hasField$0 |= 16;
         exploreCost$field = param1;
      }
      
      public function get exploreCost() : int
      {
         return exploreCost$field;
      }
      
      public function removeIsBoss1Pass() : void
      {
         hasField$0 &= 4294967263;
         isBoss1Pass$field = new Boolean();
      }
      
      public function get hasIsBoss1Pass() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set isBoss1Pass(param1:Boolean) : void
      {
         hasField$0 |= 32;
         isBoss1Pass$field = param1;
      }
      
      public function get isBoss1Pass() : Boolean
      {
         return isBoss1Pass$field;
      }
      
      public function removeIsBoss2Pass() : void
      {
         hasField$0 &= 4294967231;
         isBoss2Pass$field = new Boolean();
      }
      
      public function get hasIsBoss2Pass() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set isBoss2Pass(param1:Boolean) : void
      {
         hasField$0 |= 64;
         isBoss2Pass$field = param1;
      }
      
      public function get isBoss2Pass() : Boolean
      {
         return isBoss2Pass$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasCheckpointId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,checkpointId$field);
         }
         if(hasChapterId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,chapterId$field);
         }
         if(hasNode)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,node$field);
         }
         if(hasProgress)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,progress$field);
         }
         if(hasExploreCost)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,exploreCost$field);
         }
         if(hasIsBoss1Pass)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_BOOL(param1,isBoss1Pass$field);
         }
         if(hasIsBoss2Pass)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,isBoss2Pass$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc10_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: RemainsExploreNodeMsg.checkpointId cannot be set twice.");
                  }
                  _loc7_++;
                  checkpointId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: RemainsExploreNodeMsg.chapterId cannot be set twice.");
                  }
                  _loc4_++;
                  chapterId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: RemainsExploreNodeMsg.node cannot be set twice.");
                  }
                  _loc6_++;
                  node = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RemainsExploreNodeMsg.progress cannot be set twice.");
                  }
                  _loc3_++;
                  progress = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: RemainsExploreNodeMsg.exploreCost cannot be set twice.");
                  }
                  _loc5_++;
                  exploreCost = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: RemainsExploreNodeMsg.isBoss1Pass cannot be set twice.");
                  }
                  _loc10_++;
                  isBoss1Pass = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: RemainsExploreNodeMsg.isBoss2Pass cannot be set twice.");
                  }
                  _loc8_++;
                  isBoss2Pass = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

