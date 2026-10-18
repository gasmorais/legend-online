package com.road.yishi.proto.secretwar
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SecretWarInfoMsg extends Message implements IExternalizable
   {
      
      private var blueScore$field:int;
      
      private var hasField$0:uint = 0;
      
      private var bluePlayerCount$field:int;
      
      private var blueNodeCount$field:int;
      
      private var redScore$field:int;
      
      private var redPlayerCount$field:int;
      
      private var redNodeCount$field:int;
      
      private var curTime$field:String;
      
      private var preTime$field:String;
      
      private var stopTime$field:String;
      
      public function SecretWarInfoMsg()
      {
         super();
      }
      
      public function removeBlueScore() : void
      {
         hasField$0 &= 4294967294;
         blueScore$field = new int();
      }
      
      public function get hasBlueScore() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set blueScore(param1:int) : void
      {
         hasField$0 |= 1;
         blueScore$field = param1;
      }
      
      public function get blueScore() : int
      {
         return blueScore$field;
      }
      
      public function removeBluePlayerCount() : void
      {
         hasField$0 &= 4294967293;
         bluePlayerCount$field = new int();
      }
      
      public function get hasBluePlayerCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set bluePlayerCount(param1:int) : void
      {
         hasField$0 |= 2;
         bluePlayerCount$field = param1;
      }
      
      public function get bluePlayerCount() : int
      {
         return bluePlayerCount$field;
      }
      
      public function removeBlueNodeCount() : void
      {
         hasField$0 &= 4294967291;
         blueNodeCount$field = new int();
      }
      
      public function get hasBlueNodeCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set blueNodeCount(param1:int) : void
      {
         hasField$0 |= 4;
         blueNodeCount$field = param1;
      }
      
      public function get blueNodeCount() : int
      {
         return blueNodeCount$field;
      }
      
      public function removeRedScore() : void
      {
         hasField$0 &= 4294967287;
         redScore$field = new int();
      }
      
      public function get hasRedScore() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set redScore(param1:int) : void
      {
         hasField$0 |= 8;
         redScore$field = param1;
      }
      
      public function get redScore() : int
      {
         return redScore$field;
      }
      
      public function removeRedPlayerCount() : void
      {
         hasField$0 &= 4294967279;
         redPlayerCount$field = new int();
      }
      
      public function get hasRedPlayerCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set redPlayerCount(param1:int) : void
      {
         hasField$0 |= 16;
         redPlayerCount$field = param1;
      }
      
      public function get redPlayerCount() : int
      {
         return redPlayerCount$field;
      }
      
      public function removeRedNodeCount() : void
      {
         hasField$0 &= 4294967263;
         redNodeCount$field = new int();
      }
      
      public function get hasRedNodeCount() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set redNodeCount(param1:int) : void
      {
         hasField$0 |= 32;
         redNodeCount$field = param1;
      }
      
      public function get redNodeCount() : int
      {
         return redNodeCount$field;
      }
      
      public function removeCurTime() : void
      {
         curTime$field = null;
      }
      
      public function get hasCurTime() : Boolean
      {
         return curTime$field != null;
      }
      
      public function set curTime(param1:String) : void
      {
         curTime$field = param1;
      }
      
      public function get curTime() : String
      {
         return curTime$field;
      }
      
      public function removePreTime() : void
      {
         preTime$field = null;
      }
      
      public function get hasPreTime() : Boolean
      {
         return preTime$field != null;
      }
      
      public function set preTime(param1:String) : void
      {
         preTime$field = param1;
      }
      
      public function get preTime() : String
      {
         return preTime$field;
      }
      
      public function removeStopTime() : void
      {
         stopTime$field = null;
      }
      
      public function get hasStopTime() : Boolean
      {
         return stopTime$field != null;
      }
      
      public function set stopTime(param1:String) : void
      {
         stopTime$field = param1;
      }
      
      public function get stopTime() : String
      {
         return stopTime$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasBlueScore)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,blueScore$field);
         }
         if(hasBluePlayerCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,bluePlayerCount$field);
         }
         if(hasBlueNodeCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,blueNodeCount$field);
         }
         if(hasRedScore)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,redScore$field);
         }
         if(hasRedPlayerCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,redPlayerCount$field);
         }
         if(hasRedNodeCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,redNodeCount$field);
         }
         if(hasCurTime)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,curTime$field);
         }
         if(hasPreTime)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,preTime$field);
         }
         if(hasStopTime)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,stopTime$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarInfoMsg.blueScore cannot be set twice.");
                  }
                  _loc5_++;
                  blueScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarInfoMsg.bluePlayerCount cannot be set twice.");
                  }
                  _loc9_++;
                  bluePlayerCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarInfoMsg.blueNodeCount cannot be set twice.");
                  }
                  _loc11_++;
                  blueNodeCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarInfoMsg.redScore cannot be set twice.");
                  }
                  _loc12_++;
                  redScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarInfoMsg.redPlayerCount cannot be set twice.");
                  }
                  _loc7_++;
                  redPlayerCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarInfoMsg.redNodeCount cannot be set twice.");
                  }
                  _loc6_++;
                  redNodeCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarInfoMsg.curTime cannot be set twice.");
                  }
                  _loc3_++;
                  curTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarInfoMsg.preTime cannot be set twice.");
                  }
                  _loc8_++;
                  preTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarInfoMsg.stopTime cannot be set twice.");
                  }
                  _loc4_++;
                  stopTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

