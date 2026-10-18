package com.road.yishi.proto.childseal
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChildSealMsg extends Message implements IExternalizable
   {
      
      private var star$field:int;
      
      private var hasField$0:uint = 0;
      
      private var count$field:int;
      
      [ArrayElementType("int")]
      public var seals:Array = [];
      
      [ArrayElementType("int")]
      public var activatedSeals:Array = [];
      
      [ArrayElementType("int")]
      public var optionSeals:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.childseal.ChildSealRewardMsg")]
      public var rewards:Array = [];
      
      public function ChildSealMsg()
      {
         super();
      }
      
      public function removeStar() : void
      {
         hasField$0 &= 4294967294;
         star$field = new int();
      }
      
      public function get hasStar() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set star(param1:int) : void
      {
         hasField$0 |= 1;
         star$field = param1;
      }
      
      public function get star() : int
      {
         return star$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967293;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 2;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         var _loc5_:* = 0;
         var _loc4_:* = 0;
         if(hasStar)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,star$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         _loc3_ = 0;
         while(_loc3_ < seals.length)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,seals[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < activatedSeals.length)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,activatedSeals[_loc2_]);
            _loc2_++;
         }
         _loc5_ = 0;
         while(_loc5_ < optionSeals.length)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,optionSeals[_loc5_]);
            _loc5_++;
         }
         _loc4_ = 0;
         while(_loc4_ < rewards.length)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,rewards[_loc4_]);
            _loc4_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc6_:ChildSealRewardMsg = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChildSealMsg.star cannot be set twice.");
                  }
                  _loc3_++;
                  star = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChildSealMsg.count cannot be set twice.");
                  }
                  _loc4_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if((_loc5_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,seals);
                  }
                  else
                  {
                     seals.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 3:
                  if((_loc5_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,activatedSeals);
                  }
                  else
                  {
                     activatedSeals.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 4:
                  if((_loc5_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,optionSeals);
                  }
                  else
                  {
                     optionSeals.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 5:
                  _loc6_ = new ChildSealRewardMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  rewards.push(_loc6_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

