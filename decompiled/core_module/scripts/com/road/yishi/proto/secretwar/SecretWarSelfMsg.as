package com.road.yishi.proto.secretwar
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SecretWarSelfMsg extends Message implements IExternalizable
   {
      
      private var camp$field:int;
      
      private var hasField$0:uint = 0;
      
      private var score$field:int;
      
      private var honor$field:int;
      
      private var waitMove$field:Boolean;
      
      public function SecretWarSelfMsg()
      {
         super();
      }
      
      public function removeCamp() : void
      {
         hasField$0 &= 4294967294;
         camp$field = new int();
      }
      
      public function get hasCamp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set camp(param1:int) : void
      {
         hasField$0 |= 1;
         camp$field = param1;
      }
      
      public function get camp() : int
      {
         return camp$field;
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967293;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 2;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
      }
      
      public function removeHonor() : void
      {
         hasField$0 &= 4294967291;
         honor$field = new int();
      }
      
      public function get hasHonor() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set honor(param1:int) : void
      {
         hasField$0 |= 4;
         honor$field = param1;
      }
      
      public function get honor() : int
      {
         return honor$field;
      }
      
      public function removeWaitMove() : void
      {
         hasField$0 &= 4294967287;
         waitMove$field = new Boolean();
      }
      
      public function get hasWaitMove() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set waitMove(param1:Boolean) : void
      {
         hasField$0 |= 8;
         waitMove$field = param1;
      }
      
      public function get waitMove() : Boolean
      {
         return waitMove$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasCamp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,camp$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasHonor)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,honor$field);
         }
         if(hasWaitMove)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,waitMove$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarSelfMsg.camp cannot be set twice.");
                  }
                  _loc5_++;
                  camp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarSelfMsg.score cannot be set twice.");
                  }
                  _loc7_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarSelfMsg.honor cannot be set twice.");
                  }
                  _loc3_++;
                  honor = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarSelfMsg.waitMove cannot be set twice.");
                  }
                  _loc4_++;
                  waitMove = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

