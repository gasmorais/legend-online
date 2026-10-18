package com.road.yishi.proto.module
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class DoExploreResponseMsg extends Message implements IExternalizable
   {
      
      private var checkpointId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var chapterId$field:int;
      
      private var node$field:int;
      
      private var progress$field:int;
      
      private var tinder$field:int;
      
      private var eventType$field:int;
      
      public function DoExploreResponseMsg()
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
      
      public function removeTinder() : void
      {
         hasField$0 &= 4294967279;
         tinder$field = new int();
      }
      
      public function get hasTinder() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set tinder(param1:int) : void
      {
         hasField$0 |= 16;
         tinder$field = param1;
      }
      
      public function get tinder() : int
      {
         return tinder$field;
      }
      
      public function removeEventType() : void
      {
         hasField$0 &= 4294967263;
         eventType$field = new int();
      }
      
      public function get hasEventType() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set eventType(param1:int) : void
      {
         hasField$0 |= 32;
         eventType$field = param1;
      }
      
      public function get eventType() : int
      {
         return eventType$field;
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
         if(hasTinder)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,tinder$field);
         }
         if(hasEventType)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,eventType$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: DoExploreResponseMsg.checkpointId cannot be set twice.");
                  }
                  _loc6_++;
                  checkpointId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: DoExploreResponseMsg.chapterId cannot be set twice.");
                  }
                  _loc4_++;
                  chapterId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: DoExploreResponseMsg.node cannot be set twice.");
                  }
                  _loc5_++;
                  node = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: DoExploreResponseMsg.progress cannot be set twice.");
                  }
                  _loc3_++;
                  progress = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: DoExploreResponseMsg.tinder cannot be set twice.");
                  }
                  _loc7_++;
                  tinder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: DoExploreResponseMsg.eventType cannot be set twice.");
                  }
                  _loc9_++;
                  eventType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

