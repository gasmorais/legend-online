package com.road.yishi.proto.stargazing
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ZodiacSignInfoMsg extends Message implements IExternalizable
   {
      
      private var index$field:int;
      
      private var hasField$0:uint = 0;
      
      private var totalLightStar$field:int;
      
      [ArrayElementType("com.road.yishi.proto.stargazing.StarMapInfoMsg")]
      public var starMapMsg:Array = [];
      
      public function ZodiacSignInfoMsg()
      {
         super();
      }
      
      public function removeIndex() : void
      {
         hasField$0 &= 4294967294;
         index$field = new int();
      }
      
      public function get hasIndex() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set index(param1:int) : void
      {
         hasField$0 |= 1;
         index$field = param1;
      }
      
      public function get index() : int
      {
         return index$field;
      }
      
      public function removeTotalLightStar() : void
      {
         hasField$0 &= 4294967293;
         totalLightStar$field = new int();
      }
      
      public function get hasTotalLightStar() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set totalLightStar(param1:int) : void
      {
         hasField$0 |= 2;
         totalLightStar$field = param1;
      }
      
      public function get totalLightStar() : int
      {
         return totalLightStar$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasIndex)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,index$field);
         }
         if(hasTotalLightStar)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,totalLightStar$field);
         }
         _loc2_ = 0;
         while(_loc2_ < starMapMsg.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,starMapMsg[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:StarMapInfoMsg = null;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ZodiacSignInfoMsg.index cannot be set twice.");
                  }
                  _loc3_++;
                  index = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ZodiacSignInfoMsg.totalLightStar cannot be set twice.");
                  }
                  _loc5_++;
                  totalLightStar = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  _loc4_ = new StarMapInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  starMapMsg.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

