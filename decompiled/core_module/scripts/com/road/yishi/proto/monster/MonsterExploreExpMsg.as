package com.road.yishi.proto.monster
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MonsterExploreExpMsg extends Message implements IExternalizable
   {
      
      private var type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var exp$field:int;
      
      [ArrayElementType("int")]
      public var indexs:Array = [];
      
      public function MonsterExploreExpMsg()
      {
         super();
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967294;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 1;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeExp() : void
      {
         hasField$0 &= 4294967293;
         exp$field = new int();
      }
      
      public function get hasExp() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set exp(param1:int) : void
      {
         hasField$0 |= 2;
         exp$field = param1;
      }
      
      public function get exp() : int
      {
         return exp$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasExp)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,exp$field);
         }
         _loc2_ = 0;
         while(_loc2_ < indexs.length)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,indexs[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterExploreExpMsg.type cannot be set twice.");
                  }
                  _loc4_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterExploreExpMsg.exp cannot be set twice.");
                  }
                  _loc3_++;
                  exp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if((_loc5_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,indexs);
                  }
                  else
                  {
                     indexs.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

