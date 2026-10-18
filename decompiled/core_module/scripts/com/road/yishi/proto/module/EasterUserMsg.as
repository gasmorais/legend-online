package com.road.yishi.proto.module
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class EasterUserMsg extends Message implements IExternalizable
   {
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var wish$field:String;
      
      private var buyCount$field:int;
      
      [ArrayElementType("int")]
      public var openList:Array = [];
      
      private var buffCount$field:int;
      
      private var buyBuffCount$field:int;
      
      public function EasterUserMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         userId$field = param1;
      }
      
      public function get userId() : int
      {
         return userId$field;
      }
      
      public function removeWish() : void
      {
         wish$field = null;
      }
      
      public function get hasWish() : Boolean
      {
         return wish$field != null;
      }
      
      public function set wish(param1:String) : void
      {
         wish$field = param1;
      }
      
      public function get wish() : String
      {
         return wish$field;
      }
      
      public function removeBuyCount() : void
      {
         hasField$0 &= 4294967293;
         buyCount$field = new int();
      }
      
      public function get hasBuyCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set buyCount(param1:int) : void
      {
         hasField$0 |= 2;
         buyCount$field = param1;
      }
      
      public function get buyCount() : int
      {
         return buyCount$field;
      }
      
      public function removeBuffCount() : void
      {
         hasField$0 &= 4294967291;
         buffCount$field = new int();
      }
      
      public function get hasBuffCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set buffCount(param1:int) : void
      {
         hasField$0 |= 4;
         buffCount$field = param1;
      }
      
      public function get buffCount() : int
      {
         return buffCount$field;
      }
      
      public function removeBuyBuffCount() : void
      {
         hasField$0 &= 4294967287;
         buyBuffCount$field = new int();
      }
      
      public function get hasBuyBuffCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set buyBuffCount(param1:int) : void
      {
         hasField$0 |= 8;
         buyBuffCount$field = param1;
      }
      
      public function get buyBuffCount() : int
      {
         return buyBuffCount$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasWish)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,wish$field);
         }
         if(hasBuyCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,buyCount$field);
         }
         _loc2_ = 0;
         while(_loc2_ < openList.length)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,openList[_loc2_]);
            _loc2_++;
         }
         if(hasBuffCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,buffCount$field);
         }
         if(hasBuyBuffCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,buyBuffCount$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: EasterUserMsg.userId cannot be set twice.");
                  }
                  _loc6_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: EasterUserMsg.wish cannot be set twice.");
                  }
                  _loc4_++;
                  wish = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: EasterUserMsg.buyCount cannot be set twice.");
                  }
                  _loc3_++;
                  buyCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if((_loc7_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,openList);
                  }
                  else
                  {
                     openList.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: EasterUserMsg.buffCount cannot be set twice.");
                  }
                  _loc8_++;
                  buffCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: EasterUserMsg.buyBuffCount cannot be set twice.");
                  }
                  _loc5_++;
                  buyBuffCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

