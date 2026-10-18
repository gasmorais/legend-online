package com.road.yishi.proto.apex
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ApexStateMsg extends Message implements IExternalizable
   {
      
      private var signUpStartTime$field:String;
      
      private var signUpEndTime$field:String;
      
      private var betStartTime$field:String;
      
      private var betEndTime$field:String;
      
      private var fightStartTime$field:String;
      
      private var fightEndTime$field:String;
      
      private var index$field:int;
      
      private var hasField$0:uint = 0;
      
      private var stage$field:int;
      
      private var state$field:int;
      
      public function ApexStateMsg()
      {
         super();
      }
      
      public function removeSignUpStartTime() : void
      {
         signUpStartTime$field = null;
      }
      
      public function get hasSignUpStartTime() : Boolean
      {
         return signUpStartTime$field != null;
      }
      
      public function set signUpStartTime(param1:String) : void
      {
         signUpStartTime$field = param1;
      }
      
      public function get signUpStartTime() : String
      {
         return signUpStartTime$field;
      }
      
      public function removeSignUpEndTime() : void
      {
         signUpEndTime$field = null;
      }
      
      public function get hasSignUpEndTime() : Boolean
      {
         return signUpEndTime$field != null;
      }
      
      public function set signUpEndTime(param1:String) : void
      {
         signUpEndTime$field = param1;
      }
      
      public function get signUpEndTime() : String
      {
         return signUpEndTime$field;
      }
      
      public function removeBetStartTime() : void
      {
         betStartTime$field = null;
      }
      
      public function get hasBetStartTime() : Boolean
      {
         return betStartTime$field != null;
      }
      
      public function set betStartTime(param1:String) : void
      {
         betStartTime$field = param1;
      }
      
      public function get betStartTime() : String
      {
         return betStartTime$field;
      }
      
      public function removeBetEndTime() : void
      {
         betEndTime$field = null;
      }
      
      public function get hasBetEndTime() : Boolean
      {
         return betEndTime$field != null;
      }
      
      public function set betEndTime(param1:String) : void
      {
         betEndTime$field = param1;
      }
      
      public function get betEndTime() : String
      {
         return betEndTime$field;
      }
      
      public function removeFightStartTime() : void
      {
         fightStartTime$field = null;
      }
      
      public function get hasFightStartTime() : Boolean
      {
         return fightStartTime$field != null;
      }
      
      public function set fightStartTime(param1:String) : void
      {
         fightStartTime$field = param1;
      }
      
      public function get fightStartTime() : String
      {
         return fightStartTime$field;
      }
      
      public function removeFightEndTime() : void
      {
         fightEndTime$field = null;
      }
      
      public function get hasFightEndTime() : Boolean
      {
         return fightEndTime$field != null;
      }
      
      public function set fightEndTime(param1:String) : void
      {
         fightEndTime$field = param1;
      }
      
      public function get fightEndTime() : String
      {
         return fightEndTime$field;
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
      
      public function removeStage() : void
      {
         hasField$0 &= 4294967293;
         stage$field = new int();
      }
      
      public function get hasStage() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set stage(param1:int) : void
      {
         hasField$0 |= 2;
         stage$field = param1;
      }
      
      public function get stage() : int
      {
         return stage$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967291;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 4;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasSignUpStartTime)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,signUpStartTime$field);
         }
         if(hasSignUpEndTime)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,signUpEndTime$field);
         }
         if(hasBetStartTime)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,betStartTime$field);
         }
         if(hasBetEndTime)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,betEndTime$field);
         }
         if(hasFightStartTime)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,fightStartTime$field);
         }
         if(hasFightEndTime)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,fightEndTime$field);
         }
         if(hasIndex)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,index$field);
         }
         if(hasStage)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,stage$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc9_:uint = 0;
         var _loc12_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc11_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ApexStateMsg.signUpStartTime cannot be set twice.");
                  }
                  _loc6_++;
                  signUpStartTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ApexStateMsg.signUpEndTime cannot be set twice.");
                  }
                  _loc3_++;
                  signUpEndTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ApexStateMsg.betStartTime cannot be set twice.");
                  }
                  _loc7_++;
                  betStartTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ApexStateMsg.betEndTime cannot be set twice.");
                  }
                  _loc9_++;
                  betEndTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: ApexStateMsg.fightStartTime cannot be set twice.");
                  }
                  _loc12_++;
                  fightStartTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ApexStateMsg.fightEndTime cannot be set twice.");
                  }
                  _loc5_++;
                  fightEndTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ApexStateMsg.index cannot be set twice.");
                  }
                  _loc4_++;
                  index = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ApexStateMsg.stage cannot be set twice.");
                  }
                  _loc11_++;
                  stage = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ApexStateMsg.state cannot be set twice.");
                  }
                  _loc8_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

