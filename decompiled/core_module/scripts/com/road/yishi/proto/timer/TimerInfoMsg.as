package com.road.yishi.proto.timer
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TimerInfoMsg extends Message implements IExternalizable
   {
      
      private var type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var index$field:int;
      
      private var name$field:String;
      
      private var readyOpen$field:String;
      
      private var readyStop$field:String;
      
      private var finalOpen$field:String;
      
      private var finalStop$field:String;
      
      private var param1$field:String;
      
      private var param2$field:String;
      
      private var param3$field:String;
      
      private var signupTime$field:String;
      
      public function TimerInfoMsg()
      {
         super();
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967294;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 1;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeIndex() : void
      {
         hasField$0 &= 4294967293;
         index$field = new int();
      }
      
      public function get hasIndex() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set index(param1:int) : void
      {
         hasField$0 |= 2;
         index$field = param1;
      }
      
      public function get index() : int
      {
         return index$field;
      }
      
      public function removeName() : void
      {
         name$field = null;
      }
      
      public function get hasName() : Boolean
      {
         return name$field != null;
      }
      
      public function set name(param1:String) : void
      {
         name$field = param1;
      }
      
      public function get name() : String
      {
         return name$field;
      }
      
      public function removeReadyOpen() : void
      {
         readyOpen$field = null;
      }
      
      public function get hasReadyOpen() : Boolean
      {
         return readyOpen$field != null;
      }
      
      public function set readyOpen(param1:String) : void
      {
         readyOpen$field = param1;
      }
      
      public function get readyOpen() : String
      {
         return readyOpen$field;
      }
      
      public function removeReadyStop() : void
      {
         readyStop$field = null;
      }
      
      public function get hasReadyStop() : Boolean
      {
         return readyStop$field != null;
      }
      
      public function set readyStop(param1:String) : void
      {
         readyStop$field = param1;
      }
      
      public function get readyStop() : String
      {
         return readyStop$field;
      }
      
      public function removeFinalOpen() : void
      {
         finalOpen$field = null;
      }
      
      public function get hasFinalOpen() : Boolean
      {
         return finalOpen$field != null;
      }
      
      public function set finalOpen(param1:String) : void
      {
         finalOpen$field = param1;
      }
      
      public function get finalOpen() : String
      {
         return finalOpen$field;
      }
      
      public function removeFinalStop() : void
      {
         finalStop$field = null;
      }
      
      public function get hasFinalStop() : Boolean
      {
         return finalStop$field != null;
      }
      
      public function set finalStop(param1:String) : void
      {
         finalStop$field = param1;
      }
      
      public function get finalStop() : String
      {
         return finalStop$field;
      }
      
      public function removeParam1() : void
      {
         param1$field = null;
      }
      
      public function get hasParam1() : Boolean
      {
         return param1$field != null;
      }
      
      public function set param1(param1:String) : void
      {
         param1$field = param1;
      }
      
      public function get param1() : String
      {
         return param1$field;
      }
      
      public function removeParam2() : void
      {
         param2$field = null;
      }
      
      public function get hasParam2() : Boolean
      {
         return param2$field != null;
      }
      
      public function set param2(param1:String) : void
      {
         param2$field = param1;
      }
      
      public function get param2() : String
      {
         return param2$field;
      }
      
      public function removeParam3() : void
      {
         param3$field = null;
      }
      
      public function get hasParam3() : Boolean
      {
         return param3$field != null;
      }
      
      public function set param3(param1:String) : void
      {
         param3$field = param1;
      }
      
      public function get param3() : String
      {
         return param3$field;
      }
      
      public function removeSignupTime() : void
      {
         signupTime$field = null;
      }
      
      public function get hasSignupTime() : Boolean
      {
         return signupTime$field != null;
      }
      
      public function set signupTime(param1:String) : void
      {
         signupTime$field = param1;
      }
      
      public function get signupTime() : String
      {
         return signupTime$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasIndex)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,index$field);
         }
         if(hasName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,name$field);
         }
         if(hasReadyOpen)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,readyOpen$field);
         }
         if(hasReadyStop)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,readyStop$field);
         }
         if(hasFinalOpen)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,finalOpen$field);
         }
         if(hasFinalStop)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,finalStop$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,param1$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,param2$field);
         }
         if(hasParam3)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,param3$field);
         }
         if(hasSignupTime)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,signupTime$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         var _loc8_:uint = 0;
         var _loc11_:uint = 0;
         var _loc7_:uint = 0;
         var _loc12_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc14_:uint = 0;
         var _loc5_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: TimerInfoMsg.type cannot be set twice.");
                  }
                  _loc6_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: TimerInfoMsg.index cannot be set twice.");
                  }
                  _loc9_++;
                  index = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: TimerInfoMsg.name cannot be set twice.");
                  }
                  _loc8_++;
                  name = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: TimerInfoMsg.readyOpen cannot be set twice.");
                  }
                  _loc11_++;
                  readyOpen = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: TimerInfoMsg.readyStop cannot be set twice.");
                  }
                  _loc7_++;
                  readyStop = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: TimerInfoMsg.finalOpen cannot be set twice.");
                  }
                  _loc12_++;
                  finalOpen = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TimerInfoMsg.finalStop cannot be set twice.");
                  }
                  _loc3_++;
                  finalStop = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TimerInfoMsg.param1 cannot be set twice.");
                  }
                  _loc4_++;
                  param1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: TimerInfoMsg.param2 cannot be set twice.");
                  }
                  _loc14_++;
                  param2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TimerInfoMsg.param3 cannot be set twice.");
                  }
                  _loc5_++;
                  param3 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: TimerInfoMsg.signupTime cannot be set twice.");
                  }
                  _loc10_++;
                  signupTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

