package com.road.yishi.proto.marriage
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MarriageProMsg extends Message implements IExternalizable
   {
      
      private var userId_a$field:int;
      
      private var hasField$0:uint = 0;
      
      private var nickName_a$field:String;
      
      private var job_a$field:int;
      
      private var userId_b$field:int;
      
      private var nickName_b$field:String;
      
      private var job_b$field:int;
      
      private var property1$field:Boolean;
      
      private var property2$field:int;
      
      private var property3$field:int;
      
      private var property4$field:String;
      
      private var property5$field:String;
      
      private var property6$field:int;
      
      private var property7$field:int;
      
      private var property8$field:int;
      
      private var property9$field:int;
      
      private var property10$field:int;
      
      public function MarriageProMsg()
      {
         super();
      }
      
      public function removeUserIdA() : void
      {
         hasField$0 &= 4294967294;
         userId_a$field = new int();
      }
      
      public function get hasUserIdA() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userIdA(param1:int) : void
      {
         hasField$0 |= 1;
         userId_a$field = param1;
      }
      
      public function get userIdA() : int
      {
         return userId_a$field;
      }
      
      public function removeNickNameA() : void
      {
         nickName_a$field = null;
      }
      
      public function get hasNickNameA() : Boolean
      {
         return nickName_a$field != null;
      }
      
      public function set nickNameA(param1:String) : void
      {
         nickName_a$field = param1;
      }
      
      public function get nickNameA() : String
      {
         return nickName_a$field;
      }
      
      public function removeJobA() : void
      {
         hasField$0 &= 4294967293;
         job_a$field = new int();
      }
      
      public function get hasJobA() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set jobA(param1:int) : void
      {
         hasField$0 |= 2;
         job_a$field = param1;
      }
      
      public function get jobA() : int
      {
         return job_a$field;
      }
      
      public function removeUserIdB() : void
      {
         hasField$0 &= 4294967291;
         userId_b$field = new int();
      }
      
      public function get hasUserIdB() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set userIdB(param1:int) : void
      {
         hasField$0 |= 4;
         userId_b$field = param1;
      }
      
      public function get userIdB() : int
      {
         return userId_b$field;
      }
      
      public function removeNickNameB() : void
      {
         nickName_b$field = null;
      }
      
      public function get hasNickNameB() : Boolean
      {
         return nickName_b$field != null;
      }
      
      public function set nickNameB(param1:String) : void
      {
         nickName_b$field = param1;
      }
      
      public function get nickNameB() : String
      {
         return nickName_b$field;
      }
      
      public function removeJobB() : void
      {
         hasField$0 &= 4294967287;
         job_b$field = new int();
      }
      
      public function get hasJobB() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set jobB(param1:int) : void
      {
         hasField$0 |= 8;
         job_b$field = param1;
      }
      
      public function get jobB() : int
      {
         return job_b$field;
      }
      
      public function removeProperty1() : void
      {
         hasField$0 &= 4294967279;
         property1$field = new Boolean();
      }
      
      public function get hasProperty1() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set property1(param1:Boolean) : void
      {
         hasField$0 |= 16;
         property1$field = param1;
      }
      
      public function get property1() : Boolean
      {
         return property1$field;
      }
      
      public function removeProperty2() : void
      {
         hasField$0 &= 4294967263;
         property2$field = new int();
      }
      
      public function get hasProperty2() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set property2(param1:int) : void
      {
         hasField$0 |= 32;
         property2$field = param1;
      }
      
      public function get property2() : int
      {
         return property2$field;
      }
      
      public function removeProperty3() : void
      {
         hasField$0 &= 4294967231;
         property3$field = new int();
      }
      
      public function get hasProperty3() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set property3(param1:int) : void
      {
         hasField$0 |= 64;
         property3$field = param1;
      }
      
      public function get property3() : int
      {
         return property3$field;
      }
      
      public function removeProperty4() : void
      {
         property4$field = null;
      }
      
      public function get hasProperty4() : Boolean
      {
         return property4$field != null;
      }
      
      public function set property4(param1:String) : void
      {
         property4$field = param1;
      }
      
      public function get property4() : String
      {
         return property4$field;
      }
      
      public function removeProperty5() : void
      {
         property5$field = null;
      }
      
      public function get hasProperty5() : Boolean
      {
         return property5$field != null;
      }
      
      public function set property5(param1:String) : void
      {
         property5$field = param1;
      }
      
      public function get property5() : String
      {
         return property5$field;
      }
      
      public function removeProperty6() : void
      {
         hasField$0 &= 4294967167;
         property6$field = new int();
      }
      
      public function get hasProperty6() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set property6(param1:int) : void
      {
         hasField$0 |= 128;
         property6$field = param1;
      }
      
      public function get property6() : int
      {
         return property6$field;
      }
      
      public function removeProperty7() : void
      {
         hasField$0 &= 4294967039;
         property7$field = new int();
      }
      
      public function get hasProperty7() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set property7(param1:int) : void
      {
         hasField$0 |= 256;
         property7$field = param1;
      }
      
      public function get property7() : int
      {
         return property7$field;
      }
      
      public function removeProperty8() : void
      {
         hasField$0 &= 4294966783;
         property8$field = new int();
      }
      
      public function get hasProperty8() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set property8(param1:int) : void
      {
         hasField$0 |= 512;
         property8$field = param1;
      }
      
      public function get property8() : int
      {
         return property8$field;
      }
      
      public function removeProperty9() : void
      {
         hasField$0 &= 4294966271;
         property9$field = new int();
      }
      
      public function get hasProperty9() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set property9(param1:int) : void
      {
         hasField$0 |= 1024;
         property9$field = param1;
      }
      
      public function get property9() : int
      {
         return property9$field;
      }
      
      public function removeProperty10() : void
      {
         hasField$0 &= 4294965247;
         property10$field = new int();
      }
      
      public function get hasProperty10() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set property10(param1:int) : void
      {
         hasField$0 |= 2048;
         property10$field = param1;
      }
      
      public function get property10() : int
      {
         return property10$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserIdA)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,userId_a$field);
         }
         if(hasNickNameA)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,nickName_a$field);
         }
         if(hasJobA)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,job_a$field);
         }
         if(hasUserIdB)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,userId_b$field);
         }
         if(hasNickNameB)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,nickName_b$field);
         }
         if(hasJobB)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,job_b$field);
         }
         if(hasProperty1)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,property1$field);
         }
         if(hasProperty2)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,property2$field);
         }
         if(hasProperty3)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,property3$field);
         }
         if(hasProperty4)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,property4$field);
         }
         if(hasProperty5)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,property5$field);
         }
         if(hasProperty6)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,property6$field);
         }
         if(hasProperty7)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,property7$field);
         }
         if(hasProperty8)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,property8$field);
         }
         if(hasProperty9)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,property9$field);
         }
         if(hasProperty10)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,property10$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc17_:* = 0;
         var _loc4_:uint = 0;
         var _loc15_:uint = 0;
         var _loc10_:uint = 0;
         var _loc7_:uint = 0;
         var _loc13_:uint = 0;
         var _loc8_:uint = 0;
         var _loc14_:uint = 0;
         var _loc19_:uint = 0;
         var _loc11_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc18_:uint = 0;
         var _loc16_:uint = 0;
         var _loc9_:uint = 0;
         var _loc6_:uint = 0;
         var _loc12_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc17_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageProMsg.userIdA cannot be set twice.");
                  }
                  _loc4_++;
                  userIdA = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageProMsg.nickNameA cannot be set twice.");
                  }
                  _loc15_++;
                  nickNameA = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageProMsg.jobA cannot be set twice.");
                  }
                  _loc10_++;
                  jobA = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageProMsg.userIdB cannot be set twice.");
                  }
                  _loc7_++;
                  userIdB = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageProMsg.nickNameB cannot be set twice.");
                  }
                  _loc13_++;
                  nickNameB = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageProMsg.jobB cannot be set twice.");
                  }
                  _loc8_++;
                  jobB = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageProMsg.property1 cannot be set twice.");
                  }
                  _loc14_++;
                  property1 = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 7:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageProMsg.property2 cannot be set twice.");
                  }
                  _loc19_++;
                  property2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageProMsg.property3 cannot be set twice.");
                  }
                  _loc11_++;
                  property3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageProMsg.property4 cannot be set twice.");
                  }
                  _loc5_++;
                  property4 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageProMsg.property5 cannot be set twice.");
                  }
                  _loc3_++;
                  property5 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 11:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageProMsg.property6 cannot be set twice.");
                  }
                  _loc18_++;
                  property6 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageProMsg.property7 cannot be set twice.");
                  }
                  _loc16_++;
                  property7 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageProMsg.property8 cannot be set twice.");
                  }
                  _loc9_++;
                  property8 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageProMsg.property9 cannot be set twice.");
                  }
                  _loc6_++;
                  property9 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageProMsg.property10 cannot be set twice.");
                  }
                  _loc12_++;
                  property10 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc17_ & 7);
            }
         }
      }
   }
}

