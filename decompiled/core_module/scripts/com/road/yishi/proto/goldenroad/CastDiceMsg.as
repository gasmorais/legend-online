package com.road.yishi.proto.goldenroad
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CastDiceMsg extends Message implements IExternalizable
   {
      
      private var curPos$field:int;
      
      private var hasField$0:uint = 0;
      
      private var diceNumber$field:int;
      
      private var score$field:int;
      
      private var tempIds$field:String;
      
      public function CastDiceMsg()
      {
         super();
      }
      
      public function removeCurPos() : void
      {
         hasField$0 &= 4294967294;
         curPos$field = new int();
      }
      
      public function get hasCurPos() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set curPos(param1:int) : void
      {
         hasField$0 |= 1;
         curPos$field = param1;
      }
      
      public function get curPos() : int
      {
         return curPos$field;
      }
      
      public function removeDiceNumber() : void
      {
         hasField$0 &= 4294967293;
         diceNumber$field = new int();
      }
      
      public function get hasDiceNumber() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set diceNumber(param1:int) : void
      {
         hasField$0 |= 2;
         diceNumber$field = param1;
      }
      
      public function get diceNumber() : int
      {
         return diceNumber$field;
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967291;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 4;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
      }
      
      public function removeTempIds() : void
      {
         tempIds$field = null;
      }
      
      public function get hasTempIds() : Boolean
      {
         return tempIds$field != null;
      }
      
      public function set tempIds(param1:String) : void
      {
         tempIds$field = param1;
      }
      
      public function get tempIds() : String
      {
         return tempIds$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasCurPos)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,curPos$field);
         }
         if(hasDiceNumber)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,diceNumber$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasTempIds)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,tempIds$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CastDiceMsg.curPos cannot be set twice.");
                  }
                  _loc3_++;
                  curPos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CastDiceMsg.diceNumber cannot be set twice.");
                  }
                  _loc4_++;
                  diceNumber = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: CastDiceMsg.score cannot be set twice.");
                  }
                  _loc6_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CastDiceMsg.tempIds cannot be set twice.");
                  }
                  _loc7_++;
                  tempIds = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

