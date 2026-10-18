package com.road.yishi.proto.answerquestion
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class AnswerQuestionPlayerMsg extends Message implements IExternalizable
   {
      
      private var rank$field:int;
      
      private var hasField$0:uint = 0;
      
      private var point$field:int;
      
      private var rightCount$field:int;
      
      private var totalCount$field:int;
      
      private var rankGolden$field:int;
      
      private var exp$field:int;
      
      private var golden$field:int;
      
      public function AnswerQuestionPlayerMsg()
      {
         super();
      }
      
      public function removeRank() : void
      {
         hasField$0 &= 4294967294;
         rank$field = new int();
      }
      
      public function get hasRank() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set rank(param1:int) : void
      {
         hasField$0 |= 1;
         rank$field = param1;
      }
      
      public function get rank() : int
      {
         return rank$field;
      }
      
      public function removePoint() : void
      {
         hasField$0 &= 4294967293;
         point$field = new int();
      }
      
      public function get hasPoint() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set point(param1:int) : void
      {
         hasField$0 |= 2;
         point$field = param1;
      }
      
      public function get point() : int
      {
         return point$field;
      }
      
      public function removeRightCount() : void
      {
         hasField$0 &= 4294967291;
         rightCount$field = new int();
      }
      
      public function get hasRightCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set rightCount(param1:int) : void
      {
         hasField$0 |= 4;
         rightCount$field = param1;
      }
      
      public function get rightCount() : int
      {
         return rightCount$field;
      }
      
      public function removeTotalCount() : void
      {
         hasField$0 &= 4294967287;
         totalCount$field = new int();
      }
      
      public function get hasTotalCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set totalCount(param1:int) : void
      {
         hasField$0 |= 8;
         totalCount$field = param1;
      }
      
      public function get totalCount() : int
      {
         return totalCount$field;
      }
      
      public function removeRankGolden() : void
      {
         hasField$0 &= 4294967279;
         rankGolden$field = new int();
      }
      
      public function get hasRankGolden() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set rankGolden(param1:int) : void
      {
         hasField$0 |= 16;
         rankGolden$field = param1;
      }
      
      public function get rankGolden() : int
      {
         return rankGolden$field;
      }
      
      public function removeExp() : void
      {
         hasField$0 &= 4294967263;
         exp$field = new int();
      }
      
      public function get hasExp() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set exp(param1:int) : void
      {
         hasField$0 |= 32;
         exp$field = param1;
      }
      
      public function get exp() : int
      {
         return exp$field;
      }
      
      public function removeGolden() : void
      {
         hasField$0 &= 4294967231;
         golden$field = new int();
      }
      
      public function get hasGolden() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set golden(param1:int) : void
      {
         hasField$0 |= 64;
         golden$field = param1;
      }
      
      public function get golden() : int
      {
         return golden$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRank)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,rank$field);
         }
         if(hasPoint)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,point$field);
         }
         if(hasRightCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,rightCount$field);
         }
         if(hasTotalCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,totalCount$field);
         }
         if(hasRankGolden)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,rankGolden$field);
         }
         if(hasExp)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,exp$field);
         }
         if(hasGolden)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,golden$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: AnswerQuestionPlayerMsg.rank cannot be set twice.");
                  }
                  _loc5_++;
                  rank = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: AnswerQuestionPlayerMsg.point cannot be set twice.");
                  }
                  _loc9_++;
                  point = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: AnswerQuestionPlayerMsg.rightCount cannot be set twice.");
                  }
                  _loc4_++;
                  rightCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: AnswerQuestionPlayerMsg.totalCount cannot be set twice.");
                  }
                  _loc6_++;
                  totalCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: AnswerQuestionPlayerMsg.rankGolden cannot be set twice.");
                  }
                  _loc8_++;
                  rankGolden = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: AnswerQuestionPlayerMsg.exp cannot be set twice.");
                  }
                  _loc7_++;
                  exp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: AnswerQuestionPlayerMsg.golden cannot be set twice.");
                  }
                  _loc3_++;
                  golden = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

