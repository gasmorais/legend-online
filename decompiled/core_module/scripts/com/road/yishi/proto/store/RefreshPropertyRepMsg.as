package com.road.yishi.proto.store
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RefreshPropertyRepMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("int")]
      public var randomSkill:Array = [];
      
      [ArrayElementType("Boolean")]
      public var lockPos:Array = [];
      
      private var result$field:int;
      
      private var hasField$0:uint = 0;
      
      public function RefreshPropertyRepMsg()
      {
         super();
      }
      
      public function removeResult() : void
      {
         hasField$0 &= 4294967294;
         result$field = new int();
      }
      
      public function get hasResult() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set result(param1:int) : void
      {
         hasField$0 |= 1;
         result$field = param1;
      }
      
      public function get result() : int
      {
         return result$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < randomSkill.length)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,randomSkill[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < lockPos.length)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,lockPos[_loc3_]);
            _loc3_++;
         }
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,result$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if((_loc4_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,randomSkill);
                  }
                  else
                  {
                     randomSkill.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 1:
                  if((_loc4_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_BOOL,lockPos);
                  }
                  else
                  {
                     lockPos.push(ReadUtils.read$TYPE_BOOL(param1));
                  }
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RefreshPropertyRepMsg.result cannot be set twice.");
                  }
                  _loc3_++;
                  result = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

