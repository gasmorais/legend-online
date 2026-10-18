package com.road.yishi.proto.cccactive
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ActiveInfoPB extends Message implements IExternalizable
   {
      
      private var uuid$field:String;
      
      private var hasField$0:uint = 0;
      
      private var type$field:int;
      
      private var start_time$field:String;
      
      private var end_time$field:String;
      
      private var show_time$field:String;
      
      private var param1$field:int;
      
      private var param2$field:int;
      
      private var param3$field:int;
      
      private var param4$field:int;
      
      private var hasField$1:uint = 0;
      
      private var param5$field:String;
      
      private var param6$field:String;
      
      private var desc$field:String;
      
      [ArrayElementType("com.road.yishi.proto.cccactive.ActiveAwardTemplatePB")]
      public var awardTemp:Array = [];
      
      public function ActiveInfoPB()
      {
         super();
      }
      
      public function removeUuid() : void
      {
         hasField$0 &= 4294967294;
         uuid$field = new String();
      }
      
      public function get hasUuid() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set uuid(param1:String) : void
      {
         hasField$0 |= 1;
         uuid$field = param1;
      }
      
      public function get uuid() : String
      {
         return uuid$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967293;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 2;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeStartTime() : void
      {
         hasField$0 &= 4294967291;
         start_time$field = new String();
      }
      
      public function get hasStartTime() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set startTime(param1:String) : void
      {
         hasField$0 |= 4;
         start_time$field = param1;
      }
      
      public function get startTime() : String
      {
         return start_time$field;
      }
      
      public function removeEndTime() : void
      {
         hasField$0 &= 4294967287;
         end_time$field = new String();
      }
      
      public function get hasEndTime() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set endTime(param1:String) : void
      {
         hasField$0 |= 8;
         end_time$field = param1;
      }
      
      public function get endTime() : String
      {
         return end_time$field;
      }
      
      public function removeShowTime() : void
      {
         hasField$0 &= 4294967279;
         show_time$field = new String();
      }
      
      public function get hasShowTime() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set showTime(param1:String) : void
      {
         hasField$0 |= 16;
         show_time$field = param1;
      }
      
      public function get showTime() : String
      {
         return show_time$field;
      }
      
      public function removeParam1() : void
      {
         hasField$0 &= 4294967263;
         param1$field = new int();
      }
      
      public function get hasParam1() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set param1(param1:int) : void
      {
         hasField$0 |= 32;
         param1$field = param1;
      }
      
      public function get param1() : int
      {
         return param1$field;
      }
      
      public function removeParam2() : void
      {
         hasField$0 &= 4294967231;
         param2$field = new int();
      }
      
      public function get hasParam2() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set param2(param1:int) : void
      {
         hasField$0 |= 64;
         param2$field = param1;
      }
      
      public function get param2() : int
      {
         return param2$field;
      }
      
      public function removeParam3() : void
      {
         hasField$0 &= 4294967167;
         param3$field = new int();
      }
      
      public function get hasParam3() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set param3(param1:int) : void
      {
         hasField$0 |= 128;
         param3$field = param1;
      }
      
      public function get param3() : int
      {
         return param3$field;
      }
      
      public function removeParam4() : void
      {
         hasField$1 &= 4294967294;
         param4$field = new int();
      }
      
      public function get hasParam4() : Boolean
      {
         return (hasField$1 & 1) != 0;
      }
      
      public function set param4(param1:int) : void
      {
         hasField$1 |= 1;
         param4$field = param1;
      }
      
      public function get param4() : int
      {
         return param4$field;
      }
      
      public function removeParam5() : void
      {
         hasField$1 &= 4294967293;
         param5$field = new String();
      }
      
      public function get hasParam5() : Boolean
      {
         return (hasField$1 & 2) != 0;
      }
      
      public function set param5(param1:String) : void
      {
         hasField$1 |= 2;
         param5$field = param1;
      }
      
      public function get param5() : String
      {
         return param5$field;
      }
      
      public function removeParam6() : void
      {
         hasField$1 &= 4294967291;
         param6$field = new String();
      }
      
      public function get hasParam6() : Boolean
      {
         return (hasField$1 & 4) != 0;
      }
      
      public function set param6(param1:String) : void
      {
         hasField$1 |= 4;
         param6$field = param1;
      }
      
      public function get param6() : String
      {
         return param6$field;
      }
      
      public function removeDesc() : void
      {
         hasField$1 &= 4294967287;
         desc$field = new String();
      }
      
      public function get hasDesc() : Boolean
      {
         return (hasField$1 & 8) != 0;
      }
      
      public function set desc(param1:String) : void
      {
         hasField$1 |= 8;
         desc$field = param1;
      }
      
      public function get desc() : String
      {
         return desc$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasUuid)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,uuid$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasStartTime)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,start_time$field);
         }
         if(hasEndTime)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,end_time$field);
         }
         if(hasShowTime)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,show_time$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,param1$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,param2$field);
         }
         if(hasParam3)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,param3$field);
         }
         if(hasParam4)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,param4$field);
         }
         if(hasParam5)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,param5$field);
         }
         if(hasParam6)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,param6$field);
         }
         if(hasDesc)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_STRING(param1,desc$field);
         }
         _loc2_ = 0;
         while(_loc2_ < awardTemp.length)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_MESSAGE(param1,awardTemp[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc14_:* = 0;
         var _loc3_:ActiveAwardTemplatePB = null;
         var _loc12_:uint = 0;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc16_:uint = 0;
         var _loc6_:uint = 0;
         var _loc11_:uint = 0;
         var _loc13_:uint = 0;
         var _loc15_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc14_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveInfoPB.uuid cannot be set twice.");
                  }
                  _loc12_++;
                  uuid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveInfoPB.type cannot be set twice.");
                  }
                  _loc10_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveInfoPB.startTime cannot be set twice.");
                  }
                  _loc4_++;
                  startTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveInfoPB.endTime cannot be set twice.");
                  }
                  _loc7_++;
                  endTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveInfoPB.showTime cannot be set twice.");
                  }
                  _loc9_++;
                  showTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveInfoPB.param1 cannot be set twice.");
                  }
                  _loc5_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveInfoPB.param2 cannot be set twice.");
                  }
                  _loc16_++;
                  param2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveInfoPB.param3 cannot be set twice.");
                  }
                  _loc6_++;
                  param3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveInfoPB.param4 cannot be set twice.");
                  }
                  _loc11_++;
                  param4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveInfoPB.param5 cannot be set twice.");
                  }
                  _loc13_++;
                  param5 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveInfoPB.param6 cannot be set twice.");
                  }
                  _loc15_++;
                  param6 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 11:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveInfoPB.desc cannot be set twice.");
                  }
                  _loc8_++;
                  desc = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 12:
                  _loc3_ = new ActiveAwardTemplatePB();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  awardTemp.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc14_ & 7);
            }
         }
      }
   }
}

