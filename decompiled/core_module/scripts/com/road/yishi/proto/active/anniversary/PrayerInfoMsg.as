package com.road.yishi.proto.active.anniversary
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PrayerInfoMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.active.anniversary.NoteInfoMsg")]
      public var myNote:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.active.anniversary.NoteInfoMsg")]
      public var goldenNote:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.active.anniversary.NoteInfoMsg")]
      public var nomalNote:Array = [];
      
      private var nomal_count$field:int;
      
      private var hasField$0:uint = 0;
      
      private var golden_count$field:int;
      
      private var free_count$field:int;
      
      private var uid$field:String;
      
      private var total_count$field:int;
      
      public function PrayerInfoMsg()
      {
         super();
      }
      
      public function removeNomalCount() : void
      {
         hasField$0 &= 4294967294;
         nomal_count$field = new int();
      }
      
      public function get hasNomalCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set nomalCount(param1:int) : void
      {
         hasField$0 |= 1;
         nomal_count$field = param1;
      }
      
      public function get nomalCount() : int
      {
         return nomal_count$field;
      }
      
      public function removeGoldenCount() : void
      {
         hasField$0 &= 4294967293;
         golden_count$field = new int();
      }
      
      public function get hasGoldenCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set goldenCount(param1:int) : void
      {
         hasField$0 |= 2;
         golden_count$field = param1;
      }
      
      public function get goldenCount() : int
      {
         return golden_count$field;
      }
      
      public function removeFreeCount() : void
      {
         hasField$0 &= 4294967291;
         free_count$field = new int();
      }
      
      public function get hasFreeCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set freeCount(param1:int) : void
      {
         hasField$0 |= 4;
         free_count$field = param1;
      }
      
      public function get freeCount() : int
      {
         return free_count$field;
      }
      
      public function removeUid() : void
      {
         uid$field = null;
      }
      
      public function get hasUid() : Boolean
      {
         return uid$field != null;
      }
      
      public function set uid(param1:String) : void
      {
         uid$field = param1;
      }
      
      public function get uid() : String
      {
         return uid$field;
      }
      
      public function removeTotalCount() : void
      {
         hasField$0 &= 4294967287;
         total_count$field = new int();
      }
      
      public function get hasTotalCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set totalCount(param1:int) : void
      {
         hasField$0 |= 8;
         total_count$field = param1;
      }
      
      public function get totalCount() : int
      {
         return total_count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         var _loc4_:* = 0;
         _loc3_ = 0;
         while(_loc3_ < myNote.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,myNote[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < goldenNote.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,goldenNote[_loc2_]);
            _loc2_++;
         }
         _loc4_ = 0;
         while(_loc4_ < nomalNote.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,nomalNote[_loc4_]);
            _loc4_++;
         }
         if(hasNomalCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,nomal_count$field);
         }
         if(hasGoldenCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,golden_count$field);
         }
         if(hasFreeCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,free_count$field);
         }
         if(hasUid)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,uid$field);
         }
         if(hasTotalCount)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,total_count$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc11_:NoteInfoMsg = null;
         var _loc3_:NoteInfoMsg = null;
         var _loc5_:NoteInfoMsg = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc11_ = new NoteInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc11_);
                  myNote.push(_loc11_);
                  break;
               case 1:
                  _loc3_ = new NoteInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  goldenNote.push(_loc3_);
                  break;
               case 2:
                  _loc5_ = new NoteInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  nomalNote.push(_loc5_);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PrayerInfoMsg.nomalCount cannot be set twice.");
                  }
                  _loc9_++;
                  nomalCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PrayerInfoMsg.goldenCount cannot be set twice.");
                  }
                  _loc10_++;
                  goldenCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PrayerInfoMsg.freeCount cannot be set twice.");
                  }
                  _loc6_++;
                  freeCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PrayerInfoMsg.uid cannot be set twice.");
                  }
                  _loc8_++;
                  uid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PrayerInfoMsg.totalCount cannot be set twice.");
                  }
                  _loc4_++;
                  totalCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

