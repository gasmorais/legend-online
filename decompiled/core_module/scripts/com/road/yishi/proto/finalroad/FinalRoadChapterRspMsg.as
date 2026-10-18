package com.road.yishi.proto.finalroad
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class FinalRoadChapterRspMsg extends Message implements IExternalizable
   {
      
      private var currentChapter$field:int;
      
      private var hasField$0:uint = 0;
      
      private var surplusChapterTimes$field:int;
      
      private var buyChapterTimes$field:int;
      
      private var passChapterRecord$field:int;
      
      private var isOpen$field:Boolean;
      
      public function FinalRoadChapterRspMsg()
      {
         super();
      }
      
      public function removeCurrentChapter() : void
      {
         hasField$0 &= 4294967294;
         currentChapter$field = new int();
      }
      
      public function get hasCurrentChapter() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set currentChapter(param1:int) : void
      {
         hasField$0 |= 1;
         currentChapter$field = param1;
      }
      
      public function get currentChapter() : int
      {
         return currentChapter$field;
      }
      
      public function removeSurplusChapterTimes() : void
      {
         hasField$0 &= 4294967293;
         surplusChapterTimes$field = new int();
      }
      
      public function get hasSurplusChapterTimes() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set surplusChapterTimes(param1:int) : void
      {
         hasField$0 |= 2;
         surplusChapterTimes$field = param1;
      }
      
      public function get surplusChapterTimes() : int
      {
         return surplusChapterTimes$field;
      }
      
      public function removeBuyChapterTimes() : void
      {
         hasField$0 &= 4294967291;
         buyChapterTimes$field = new int();
      }
      
      public function get hasBuyChapterTimes() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set buyChapterTimes(param1:int) : void
      {
         hasField$0 |= 4;
         buyChapterTimes$field = param1;
      }
      
      public function get buyChapterTimes() : int
      {
         return buyChapterTimes$field;
      }
      
      public function removePassChapterRecord() : void
      {
         hasField$0 &= 4294967287;
         passChapterRecord$field = new int();
      }
      
      public function get hasPassChapterRecord() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set passChapterRecord(param1:int) : void
      {
         hasField$0 |= 8;
         passChapterRecord$field = param1;
      }
      
      public function get passChapterRecord() : int
      {
         return passChapterRecord$field;
      }
      
      public function removeIsOpen() : void
      {
         hasField$0 &= 4294967279;
         isOpen$field = new Boolean();
      }
      
      public function get hasIsOpen() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set isOpen(param1:Boolean) : void
      {
         hasField$0 |= 16;
         isOpen$field = param1;
      }
      
      public function get isOpen() : Boolean
      {
         return isOpen$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasCurrentChapter)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,currentChapter$field);
         }
         if(hasSurplusChapterTimes)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,surplusChapterTimes$field);
         }
         if(hasBuyChapterTimes)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,buyChapterTimes$field);
         }
         if(hasPassChapterRecord)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,passChapterRecord$field);
         }
         if(hasIsOpen)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_BOOL(param1,isOpen$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FinalRoadChapterRspMsg.currentChapter cannot be set twice.");
                  }
                  _loc4_++;
                  currentChapter = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FinalRoadChapterRspMsg.surplusChapterTimes cannot be set twice.");
                  }
                  _loc6_++;
                  surplusChapterTimes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: FinalRoadChapterRspMsg.buyChapterTimes cannot be set twice.");
                  }
                  _loc7_++;
                  buyChapterTimes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: FinalRoadChapterRspMsg.passChapterRecord cannot be set twice.");
                  }
                  _loc8_++;
                  passChapterRecord = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: FinalRoadChapterRspMsg.isOpen cannot be set twice.");
                  }
                  _loc3_++;
                  isOpen = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

