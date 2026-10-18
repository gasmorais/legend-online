package com.road.yishi.proto.simple
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PropertyMsg extends Message implements IExternalizable
   {
      
      private var param1$field:int;
      
      private var hasField$0:uint = 0;
      
      private var param2$field:int;
      
      private var param3$field:int;
      
      private var param4$field:String;
      
      private var param5$field:String;
      
      private var param6$field:String;
      
      private var param7$field:Boolean;
      
      private var param8$field:Boolean;
      
      private var param9$field:Boolean;
      
      private var param10$field:int;
      
      private var param11$field:int;
      
      private var param12$field:String;
      
      public function PropertyMsg()
      {
         super();
      }
      
      public function removeParam1() : void
      {
         hasField$0 &= 4294967294;
         param1$field = new int();
      }
      
      public function get hasParam1() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set param1(param1:int) : void
      {
         hasField$0 |= 1;
         param1$field = param1;
      }
      
      public function get param1() : int
      {
         return param1$field;
      }
      
      public function removeParam2() : void
      {
         hasField$0 &= 4294967293;
         param2$field = new int();
      }
      
      public function get hasParam2() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set param2(param1:int) : void
      {
         hasField$0 |= 2;
         param2$field = param1;
      }
      
      public function get param2() : int
      {
         return param2$field;
      }
      
      public function removeParam3() : void
      {
         hasField$0 &= 4294967291;
         param3$field = new int();
      }
      
      public function get hasParam3() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set param3(param1:int) : void
      {
         hasField$0 |= 4;
         param3$field = param1;
      }
      
      public function get param3() : int
      {
         return param3$field;
      }
      
      public function removeParam4() : void
      {
         param4$field = null;
      }
      
      public function get hasParam4() : Boolean
      {
         return param4$field != null;
      }
      
      public function set param4(param1:String) : void
      {
         param4$field = param1;
      }
      
      public function get param4() : String
      {
         return param4$field;
      }
      
      public function removeParam5() : void
      {
         param5$field = null;
      }
      
      public function get hasParam5() : Boolean
      {
         return param5$field != null;
      }
      
      public function set param5(param1:String) : void
      {
         param5$field = param1;
      }
      
      public function get param5() : String
      {
         return param5$field;
      }
      
      public function removeParam6() : void
      {
         param6$field = null;
      }
      
      public function get hasParam6() : Boolean
      {
         return param6$field != null;
      }
      
      public function set param6(param1:String) : void
      {
         param6$field = param1;
      }
      
      public function get param6() : String
      {
         return param6$field;
      }
      
      public function removeParam7() : void
      {
         hasField$0 &= 4294967287;
         param7$field = new Boolean();
      }
      
      public function get hasParam7() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set param7(param1:Boolean) : void
      {
         hasField$0 |= 8;
         param7$field = param1;
      }
      
      public function get param7() : Boolean
      {
         return param7$field;
      }
      
      public function removeParam8() : void
      {
         hasField$0 &= 4294967279;
         param8$field = new Boolean();
      }
      
      public function get hasParam8() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set param8(param1:Boolean) : void
      {
         hasField$0 |= 16;
         param8$field = param1;
      }
      
      public function get param8() : Boolean
      {
         return param8$field;
      }
      
      public function removeParam9() : void
      {
         hasField$0 &= 4294967263;
         param9$field = new Boolean();
      }
      
      public function get hasParam9() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set param9(param1:Boolean) : void
      {
         hasField$0 |= 32;
         param9$field = param1;
      }
      
      public function get param9() : Boolean
      {
         return param9$field;
      }
      
      public function removeParam10() : void
      {
         hasField$0 &= 4294967231;
         param10$field = new int();
      }
      
      public function get hasParam10() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set param10(param1:int) : void
      {
         hasField$0 |= 64;
         param10$field = param1;
      }
      
      public function get param10() : int
      {
         return param10$field;
      }
      
      public function removeParam11() : void
      {
         hasField$0 &= 4294967167;
         param11$field = new int();
      }
      
      public function get hasParam11() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set param11(param1:int) : void
      {
         hasField$0 |= 128;
         param11$field = param1;
      }
      
      public function get param11() : int
      {
         return param11$field;
      }
      
      public function removeParam12() : void
      {
         param12$field = null;
      }
      
      public function get hasParam12() : Boolean
      {
         return param12$field != null;
      }
      
      public function set param12(param1:String) : void
      {
         param12$field = param1;
      }
      
      public function get param12() : String
      {
         return param12$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,param1$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,param2$field);
         }
         if(hasParam3)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,param3$field);
         }
         if(hasParam4)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,param4$field);
         }
         if(hasParam5)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,param5$field);
         }
         if(hasParam6)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,param6$field);
         }
         if(hasParam7)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,param7$field);
         }
         if(hasParam8)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_BOOL(param1,param8$field);
         }
         if(hasParam9)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_BOOL(param1,param9$field);
         }
         if(hasParam10)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,param10$field);
         }
         if(hasParam11)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,param11$field);
         }
         if(hasParam12)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_STRING(param1,param12$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc5_:uint = 0;
         var _loc15_:uint = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc13_:uint = 0;
         var _loc11_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc14_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PropertyMsg.param1 cannot be set twice.");
                  }
                  _loc5_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: PropertyMsg.param2 cannot be set twice.");
                  }
                  _loc15_++;
                  param2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PropertyMsg.param3 cannot be set twice.");
                  }
                  _loc6_++;
                  param3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PropertyMsg.param4 cannot be set twice.");
                  }
                  _loc9_++;
                  param4 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PropertyMsg.param5 cannot be set twice.");
                  }
                  _loc10_++;
                  param5 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: PropertyMsg.param6 cannot be set twice.");
                  }
                  _loc13_++;
                  param6 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: PropertyMsg.param7 cannot be set twice.");
                  }
                  _loc11_++;
                  param7 = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 7:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PropertyMsg.param8 cannot be set twice.");
                  }
                  _loc4_++;
                  param8 = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 8:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PropertyMsg.param9 cannot be set twice.");
                  }
                  _loc8_++;
                  param9 = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 9:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: PropertyMsg.param10 cannot be set twice.");
                  }
                  _loc14_++;
                  param10 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PropertyMsg.param11 cannot be set twice.");
                  }
                  _loc7_++;
                  param11 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PropertyMsg.param12 cannot be set twice.");
                  }
                  _loc3_++;
                  param12 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

