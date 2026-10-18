package com.road.yishi.proto.star
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class StarMoveReqMsg extends Message implements IExternalizable
   {
      
      private var begin_star_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var begin_pos$field:int;
      
      private var end_star_type$field:int;
      
      private var end_pos$field:int;
      
      private var count$field:int;
      
      private var eat$field:Boolean;
      
      public function StarMoveReqMsg()
      {
         super();
      }
      
      public function removeBeginStarType() : void
      {
         hasField$0 &= 4294967294;
         begin_star_type$field = new int();
      }
      
      public function get hasBeginStarType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set beginStarType(param1:int) : void
      {
         hasField$0 |= 1;
         begin_star_type$field = param1;
      }
      
      public function get beginStarType() : int
      {
         return begin_star_type$field;
      }
      
      public function removeBeginPos() : void
      {
         hasField$0 &= 4294967293;
         begin_pos$field = new int();
      }
      
      public function get hasBeginPos() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set beginPos(param1:int) : void
      {
         hasField$0 |= 2;
         begin_pos$field = param1;
      }
      
      public function get beginPos() : int
      {
         return begin_pos$field;
      }
      
      public function removeEndStarType() : void
      {
         hasField$0 &= 4294967291;
         end_star_type$field = new int();
      }
      
      public function get hasEndStarType() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set endStarType(param1:int) : void
      {
         hasField$0 |= 4;
         end_star_type$field = param1;
      }
      
      public function get endStarType() : int
      {
         return end_star_type$field;
      }
      
      public function removeEndPos() : void
      {
         hasField$0 &= 4294967287;
         end_pos$field = new int();
      }
      
      public function get hasEndPos() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set endPos(param1:int) : void
      {
         hasField$0 |= 8;
         end_pos$field = param1;
      }
      
      public function get endPos() : int
      {
         return end_pos$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967279;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 16;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeEat() : void
      {
         hasField$0 &= 4294967263;
         eat$field = new Boolean();
      }
      
      public function get hasEat() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set eat(param1:Boolean) : void
      {
         hasField$0 |= 32;
         eat$field = param1;
      }
      
      public function get eat() : Boolean
      {
         return eat$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasBeginStarType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,begin_star_type$field);
         }
         if(hasBeginPos)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,begin_pos$field);
         }
         if(hasEndStarType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,end_star_type$field);
         }
         if(hasEndPos)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,end_pos$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasEat)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_BOOL(param1,eat$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: StarMoveReqMsg.beginStarType cannot be set twice.");
                  }
                  _loc7_++;
                  beginStarType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: StarMoveReqMsg.beginPos cannot be set twice.");
                  }
                  _loc4_++;
                  beginPos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: StarMoveReqMsg.endStarType cannot be set twice.");
                  }
                  _loc9_++;
                  endStarType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: StarMoveReqMsg.endPos cannot be set twice.");
                  }
                  _loc5_++;
                  endPos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: StarMoveReqMsg.count cannot be set twice.");
                  }
                  _loc3_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: StarMoveReqMsg.eat cannot be set twice.");
                  }
                  _loc6_++;
                  eat = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

