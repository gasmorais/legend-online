package com.road.yishi.proto.consortiawar
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaWarDefendRecordMsg extends Message implements IExternalizable
   {
      
      private var num$field:int;
      
      private var hasField$0:uint = 0;
      
      private var attackName$field:String;
      
      private var attackType$field:int;
      
      private var isWin$field:Boolean;
      
      private var score$field:int;
      
      public function ConsortiaWarDefendRecordMsg()
      {
         super();
      }
      
      public function removeNum() : void
      {
         hasField$0 &= 4294967294;
         num$field = new int();
      }
      
      public function get hasNum() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set num(param1:int) : void
      {
         hasField$0 |= 1;
         num$field = param1;
      }
      
      public function get num() : int
      {
         return num$field;
      }
      
      public function removeAttackName() : void
      {
         attackName$field = null;
      }
      
      public function get hasAttackName() : Boolean
      {
         return attackName$field != null;
      }
      
      public function set attackName(param1:String) : void
      {
         attackName$field = param1;
      }
      
      public function get attackName() : String
      {
         return attackName$field;
      }
      
      public function removeAttackType() : void
      {
         hasField$0 &= 4294967293;
         attackType$field = new int();
      }
      
      public function get hasAttackType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set attackType(param1:int) : void
      {
         hasField$0 |= 2;
         attackType$field = param1;
      }
      
      public function get attackType() : int
      {
         return attackType$field;
      }
      
      public function removeIsWin() : void
      {
         hasField$0 &= 4294967291;
         isWin$field = new Boolean();
      }
      
      public function get hasIsWin() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set isWin(param1:Boolean) : void
      {
         hasField$0 |= 4;
         isWin$field = param1;
      }
      
      public function get isWin() : Boolean
      {
         return isWin$field;
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967287;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 8;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasNum)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,num$field);
         }
         if(hasAttackName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,attackName$field);
         }
         if(hasAttackType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,attackType$field);
         }
         if(hasIsWin)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,isWin$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarDefendRecordMsg.num cannot be set twice.");
                  }
                  _loc8_++;
                  num = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarDefendRecordMsg.attackName cannot be set twice.");
                  }
                  _loc4_++;
                  attackName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarDefendRecordMsg.attackType cannot be set twice.");
                  }
                  _loc6_++;
                  attackType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarDefendRecordMsg.isWin cannot be set twice.");
                  }
                  _loc3_++;
                  isWin = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarDefendRecordMsg.score cannot be set twice.");
                  }
                  _loc7_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

