package com.road.yishi.proto.simple
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChallengeLogMsg extends Message implements IExternalizable
   {
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var result$field:int;
      
      private var tarUserId$field:int;
      
      private var tarNickName$field:String;
      
      private var isAttack$field:Boolean;
      
      private var logDate$field:String;
      
      private var curRankResult$field:int;
      
      private var grades$field:int;
      
      private var gp_order$field:int;
      
      private var gp$field:int;
      
      private var job$field:int;
      
      private var forward$field:int;
      
      public function ChallengeLogMsg()
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
      
      public function removeResult() : void
      {
         hasField$0 &= 4294967293;
         result$field = new int();
      }
      
      public function get hasResult() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set result(param1:int) : void
      {
         hasField$0 |= 2;
         result$field = param1;
      }
      
      public function get result() : int
      {
         return result$field;
      }
      
      public function removeTarUserId() : void
      {
         hasField$0 &= 4294967291;
         tarUserId$field = new int();
      }
      
      public function get hasTarUserId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set tarUserId(param1:int) : void
      {
         hasField$0 |= 4;
         tarUserId$field = param1;
      }
      
      public function get tarUserId() : int
      {
         return tarUserId$field;
      }
      
      public function removeTarNickName() : void
      {
         tarNickName$field = null;
      }
      
      public function get hasTarNickName() : Boolean
      {
         return tarNickName$field != null;
      }
      
      public function set tarNickName(param1:String) : void
      {
         tarNickName$field = param1;
      }
      
      public function get tarNickName() : String
      {
         return tarNickName$field;
      }
      
      public function removeIsAttack() : void
      {
         hasField$0 &= 4294967287;
         isAttack$field = new Boolean();
      }
      
      public function get hasIsAttack() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set isAttack(param1:Boolean) : void
      {
         hasField$0 |= 8;
         isAttack$field = param1;
      }
      
      public function get isAttack() : Boolean
      {
         return isAttack$field;
      }
      
      public function removeLogDate() : void
      {
         logDate$field = null;
      }
      
      public function get hasLogDate() : Boolean
      {
         return logDate$field != null;
      }
      
      public function set logDate(param1:String) : void
      {
         logDate$field = param1;
      }
      
      public function get logDate() : String
      {
         return logDate$field;
      }
      
      public function removeCurRankResult() : void
      {
         hasField$0 &= 4294967279;
         curRankResult$field = new int();
      }
      
      public function get hasCurRankResult() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set curRankResult(param1:int) : void
      {
         hasField$0 |= 16;
         curRankResult$field = param1;
      }
      
      public function get curRankResult() : int
      {
         return curRankResult$field;
      }
      
      public function removeGrades() : void
      {
         hasField$0 &= 4294967263;
         grades$field = new int();
      }
      
      public function get hasGrades() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set grades(param1:int) : void
      {
         hasField$0 |= 32;
         grades$field = param1;
      }
      
      public function get grades() : int
      {
         return grades$field;
      }
      
      public function removeGpOrder() : void
      {
         hasField$0 &= 4294967231;
         gp_order$field = new int();
      }
      
      public function get hasGpOrder() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set gpOrder(param1:int) : void
      {
         hasField$0 |= 64;
         gp_order$field = param1;
      }
      
      public function get gpOrder() : int
      {
         return gp_order$field;
      }
      
      public function removeGp() : void
      {
         hasField$0 &= 4294967167;
         gp$field = new int();
      }
      
      public function get hasGp() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set gp(param1:int) : void
      {
         hasField$0 |= 128;
         gp$field = param1;
      }
      
      public function get gp() : int
      {
         return gp$field;
      }
      
      public function removeJob() : void
      {
         hasField$0 &= 4294967039;
         job$field = new int();
      }
      
      public function get hasJob() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set job(param1:int) : void
      {
         hasField$0 |= 256;
         job$field = param1;
      }
      
      public function get job() : int
      {
         return job$field;
      }
      
      public function removeForward() : void
      {
         hasField$0 &= 4294966783;
         forward$field = new int();
      }
      
      public function get hasForward() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set forward(param1:int) : void
      {
         hasField$0 |= 512;
         forward$field = param1;
      }
      
      public function get forward() : int
      {
         return forward$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,result$field);
         }
         if(hasTarUserId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,tarUserId$field);
         }
         if(hasTarNickName)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,tarNickName$field);
         }
         if(hasIsAttack)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_BOOL(param1,isAttack$field);
         }
         if(hasLogDate)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,logDate$field);
         }
         if(hasCurRankResult)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,curRankResult$field);
         }
         if(hasGrades)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,grades$field);
         }
         if(hasGpOrder)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,gp_order$field);
         }
         if(hasGp)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,gp$field);
         }
         if(hasJob)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,job$field);
         }
         if(hasForward)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,forward$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc10_:uint = 0;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         var _loc11_:uint = 0;
         var _loc14_:uint = 0;
         var _loc4_:uint = 0;
         var _loc13_:uint = 0;
         var _loc9_:uint = 0;
         var _loc15_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeLogMsg.userId cannot be set twice.");
                  }
                  _loc7_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeLogMsg.result cannot be set twice.");
                  }
                  _loc6_++;
                  result = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeLogMsg.tarUserId cannot be set twice.");
                  }
                  _loc3_++;
                  tarUserId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeLogMsg.tarNickName cannot be set twice.");
                  }
                  _loc10_++;
                  tarNickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeLogMsg.isAttack cannot be set twice.");
                  }
                  _loc8_++;
                  isAttack = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeLogMsg.logDate cannot be set twice.");
                  }
                  _loc5_++;
                  logDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeLogMsg.curRankResult cannot be set twice.");
                  }
                  _loc11_++;
                  curRankResult = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeLogMsg.grades cannot be set twice.");
                  }
                  _loc14_++;
                  grades = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeLogMsg.gpOrder cannot be set twice.");
                  }
                  _loc4_++;
                  gpOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeLogMsg.gp cannot be set twice.");
                  }
                  _loc13_++;
                  gp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeLogMsg.job cannot be set twice.");
                  }
                  _loc9_++;
                  job = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeLogMsg.forward cannot be set twice.");
                  }
                  _loc15_++;
                  forward = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

