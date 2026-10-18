package com.road.yishi.proto.consortiawar
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaWarDataMsg extends Message implements IExternalizable
   {
      
      private var opType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var defendBuffer$field:int;
      
      [ArrayElementType("int")]
      public var userBuffers:Array = [];
      
      private var score$field:int;
      
      private var isBye$field:Boolean;
      
      private var isValid$field:Boolean;
      
      private var rivalConsortiaName$field:String;
      
      private var rivalServerName$field:String;
      
      private var rivalScore$field:int;
      
      [ArrayElementType("com.road.yishi.proto.consortiawar.ConsortiaWarDefenderMsg")]
      public var defenderList:Array = [];
      
      public function ConsortiaWarDataMsg()
      {
         super();
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294967294;
         opType$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 1;
         opType$field = param1;
      }
      
      public function get opType() : int
      {
         return opType$field;
      }
      
      public function removeDefendBuffer() : void
      {
         hasField$0 &= 4294967293;
         defendBuffer$field = new int();
      }
      
      public function get hasDefendBuffer() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set defendBuffer(param1:int) : void
      {
         hasField$0 |= 2;
         defendBuffer$field = param1;
      }
      
      public function get defendBuffer() : int
      {
         return defendBuffer$field;
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
      
      public function removeIsBye() : void
      {
         hasField$0 &= 4294967287;
         isBye$field = new Boolean();
      }
      
      public function get hasIsBye() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set isBye(param1:Boolean) : void
      {
         hasField$0 |= 8;
         isBye$field = param1;
      }
      
      public function get isBye() : Boolean
      {
         return isBye$field;
      }
      
      public function removeIsValid() : void
      {
         hasField$0 &= 4294967279;
         isValid$field = new Boolean();
      }
      
      public function get hasIsValid() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set isValid(param1:Boolean) : void
      {
         hasField$0 |= 16;
         isValid$field = param1;
      }
      
      public function get isValid() : Boolean
      {
         return isValid$field;
      }
      
      public function removeRivalConsortiaName() : void
      {
         rivalConsortiaName$field = null;
      }
      
      public function get hasRivalConsortiaName() : Boolean
      {
         return rivalConsortiaName$field != null;
      }
      
      public function set rivalConsortiaName(param1:String) : void
      {
         rivalConsortiaName$field = param1;
      }
      
      public function get rivalConsortiaName() : String
      {
         return rivalConsortiaName$field;
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
         hasField$0 &= 4294967263;
         rivalScore$field = new int();
      }
      
      public function get hasRivalScore() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set rivalScore(param1:int) : void
      {
         hasField$0 |= 32;
         rivalScore$field = param1;
      }
      
      public function get rivalScore() : int
      {
         return rivalScore$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,opType$field);
         }
         if(hasDefendBuffer)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,defendBuffer$field);
         }
         _loc3_ = 0;
         while(_loc3_ < userBuffers.length)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,userBuffers[_loc3_]);
            _loc3_++;
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasIsBye)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_BOOL(param1,isBye$field);
         }
         if(hasIsValid)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_BOOL(param1,isValid$field);
         }
         if(hasRivalConsortiaName)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,rivalConsortiaName$field);
         }
         if(hasRivalServerName)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,rivalServerName$field);
         }
         if(hasRivalScore)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,rivalScore$field);
         }
         _loc2_ = 0;
         while(_loc2_ < defenderList.length)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_MESSAGE(param1,defenderList[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc4_:ConsortiaWarDefenderMsg = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc10_:uint = 0;
         var _loc7_:uint = 0;
         var _loc12_:uint = 0;
         var _loc11_:uint = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarDataMsg.opType cannot be set twice.");
                  }
                  _loc5_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarDataMsg.defendBuffer cannot be set twice.");
                  }
                  _loc6_++;
                  defendBuffer = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if((_loc8_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,userBuffers);
                  }
                  else
                  {
                     userBuffers.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 3:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarDataMsg.score cannot be set twice.");
                  }
                  _loc10_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarDataMsg.isBye cannot be set twice.");
                  }
                  _loc7_++;
                  isBye = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 5:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarDataMsg.isValid cannot be set twice.");
                  }
                  _loc12_++;
                  isValid = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 6:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarDataMsg.rivalConsortiaName cannot be set twice.");
                  }
                  _loc11_++;
                  rivalConsortiaName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarDataMsg.rivalServerName cannot be set twice.");
                  }
                  _loc3_++;
                  rivalServerName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarDataMsg.rivalScore cannot be set twice.");
                  }
                  _loc9_++;
                  rivalScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  _loc4_ = new ConsortiaWarDefenderMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  defenderList.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

