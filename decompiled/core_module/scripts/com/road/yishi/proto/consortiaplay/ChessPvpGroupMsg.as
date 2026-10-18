package com.road.yishi.proto.consortiaplay
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChessPvpGroupMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var currTime$field:String;
      
      private var beginTime$field:String;
      
      private var endTime$field:String;
      
      private var group$field:int;
      
      private var score$field:int;
      
      private var state$field:int;
      
      private var rivalName$field:String;
      
      private var rivalServerName$field:String;
      
      private var rivalScore$field:int;
      
      private var isSignUp$field:Boolean;
      
      private var rank$field:int;
      
      public function ChessPvpGroupMsg()
      {
         super();
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967294;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 1;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removeCurrTime() : void
      {
         currTime$field = null;
      }
      
      public function get hasCurrTime() : Boolean
      {
         return currTime$field != null;
      }
      
      public function set currTime(param1:String) : void
      {
         currTime$field = param1;
      }
      
      public function get currTime() : String
      {
         return currTime$field;
      }
      
      public function removeBeginTime() : void
      {
         beginTime$field = null;
      }
      
      public function get hasBeginTime() : Boolean
      {
         return beginTime$field != null;
      }
      
      public function set beginTime(param1:String) : void
      {
         beginTime$field = param1;
      }
      
      public function get beginTime() : String
      {
         return beginTime$field;
      }
      
      public function removeEndTime() : void
      {
         endTime$field = null;
      }
      
      public function get hasEndTime() : Boolean
      {
         return endTime$field != null;
      }
      
      public function set endTime(param1:String) : void
      {
         endTime$field = param1;
      }
      
      public function get endTime() : String
      {
         return endTime$field;
      }
      
      public function removeGroup() : void
      {
         hasField$0 &= 4294967293;
         group$field = new int();
      }
      
      public function get hasGroup() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set group(param1:int) : void
      {
         hasField$0 |= 2;
         group$field = param1;
      }
      
      public function get group() : int
      {
         return group$field;
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
      
      public function removeState() : void
      {
         hasField$0 &= 4294967287;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 8;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeRivalName() : void
      {
         rivalName$field = null;
      }
      
      public function get hasRivalName() : Boolean
      {
         return rivalName$field != null;
      }
      
      public function set rivalName(param1:String) : void
      {
         rivalName$field = param1;
      }
      
      public function get rivalName() : String
      {
         return rivalName$field;
      }
      
      public function removeRivalServerName() : void
      {
         rivalServerName$field = null;
      }
      
      public function get hasRivalServerName() : Boolean
      {
         return rivalServerName$field != null;
      }
      
      public function set rivalServerName(param1:String) : void
      {
         rivalServerName$field = param1;
      }
      
      public function get rivalServerName() : String
      {
         return rivalServerName$field;
      }
      
      public function removeRivalScore() : void
      {
         hasField$0 &= 4294967279;
         rivalScore$field = new int();
      }
      
      public function get hasRivalScore() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set rivalScore(param1:int) : void
      {
         hasField$0 |= 16;
         rivalScore$field = param1;
      }
      
      public function get rivalScore() : int
      {
         return rivalScore$field;
      }
      
      public function removeIsSignUp() : void
      {
         hasField$0 &= 4294967263;
         isSignUp$field = new Boolean();
      }
      
      public function get hasIsSignUp() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set isSignUp(param1:Boolean) : void
      {
         hasField$0 |= 32;
         isSignUp$field = param1;
      }
      
      public function get isSignUp() : Boolean
      {
         return isSignUp$field;
      }
      
      public function removeRank() : void
      {
         hasField$0 &= 4294967231;
         rank$field = new int();
      }
      
      public function get hasRank() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set rank(param1:int) : void
      {
         hasField$0 |= 64;
         rank$field = param1;
      }
      
      public function get rank() : int
      {
         return rank$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasCurrTime)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,currTime$field);
         }
         if(hasBeginTime)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,beginTime$field);
         }
         if(hasEndTime)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,endTime$field);
         }
         if(hasGroup)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,group$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasRivalName)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,rivalName$field);
         }
         if(hasRivalServerName)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,rivalServerName$field);
         }
         if(hasRivalScore)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,rivalScore$field);
         }
         if(hasIsSignUp)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_BOOL(param1,isSignUp$field);
         }
         if(hasRank)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,rank$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc15_:uint = 0;
         var _loc11_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc14_:uint = 0;
         var _loc10_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc13_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpGroupMsg.op cannot be set twice.");
                  }
                  _loc15_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpGroupMsg.currTime cannot be set twice.");
                  }
                  _loc11_++;
                  currTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpGroupMsg.beginTime cannot be set twice.");
                  }
                  _loc7_++;
                  beginTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpGroupMsg.endTime cannot be set twice.");
                  }
                  _loc4_++;
                  endTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpGroupMsg.group cannot be set twice.");
                  }
                  _loc9_++;
                  group = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpGroupMsg.score cannot be set twice.");
                  }
                  _loc14_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpGroupMsg.state cannot be set twice.");
                  }
                  _loc10_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpGroupMsg.rivalName cannot be set twice.");
                  }
                  _loc8_++;
                  rivalName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpGroupMsg.rivalServerName cannot be set twice.");
                  }
                  _loc3_++;
                  rivalServerName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpGroupMsg.rivalScore cannot be set twice.");
                  }
                  _loc13_++;
                  rivalScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpGroupMsg.isSignUp cannot be set twice.");
                  }
                  _loc6_++;
                  isSignUp = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 11:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpGroupMsg.rank cannot be set twice.");
                  }
                  _loc5_++;
                  rank = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

