package com.road.yishi.proto.theseus
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TheseusUserMsg extends Message implements IExternalizable
   {
      
      private var suite1$field:String;
      
      private var suite2$field:String;
      
      private var suite3$field:String;
      
      private var suite4$field:String;
      
      private var suite5$field:String;
      
      private var suite6$field:String;
      
      private var suite7$field:String;
      
      private var suite8$field:String;
      
      private var suite9$field:String;
      
      private var armour$field:int;
      
      private var hasField$0:uint = 0;
      
      private var level$field:int;
      
      private var hokeInfo$field:String;
      
      private var coreLevel$field:int;
      
      [ArrayElementType("com.road.yishi.proto.theseus.TheseusEquipMsg")]
      public var theseusEquipList:Array = [];
      
      public function TheseusUserMsg()
      {
         super();
      }
      
      public function removeSuite1() : void
      {
         suite1$field = null;
      }
      
      public function get hasSuite1() : Boolean
      {
         return suite1$field != null;
      }
      
      public function set suite1(param1:String) : void
      {
         suite1$field = param1;
      }
      
      public function get suite1() : String
      {
         return suite1$field;
      }
      
      public function removeSuite2() : void
      {
         suite2$field = null;
      }
      
      public function get hasSuite2() : Boolean
      {
         return suite2$field != null;
      }
      
      public function set suite2(param1:String) : void
      {
         suite2$field = param1;
      }
      
      public function get suite2() : String
      {
         return suite2$field;
      }
      
      public function removeSuite3() : void
      {
         suite3$field = null;
      }
      
      public function get hasSuite3() : Boolean
      {
         return suite3$field != null;
      }
      
      public function set suite3(param1:String) : void
      {
         suite3$field = param1;
      }
      
      public function get suite3() : String
      {
         return suite3$field;
      }
      
      public function removeSuite4() : void
      {
         suite4$field = null;
      }
      
      public function get hasSuite4() : Boolean
      {
         return suite4$field != null;
      }
      
      public function set suite4(param1:String) : void
      {
         suite4$field = param1;
      }
      
      public function get suite4() : String
      {
         return suite4$field;
      }
      
      public function removeSuite5() : void
      {
         suite5$field = null;
      }
      
      public function get hasSuite5() : Boolean
      {
         return suite5$field != null;
      }
      
      public function set suite5(param1:String) : void
      {
         suite5$field = param1;
      }
      
      public function get suite5() : String
      {
         return suite5$field;
      }
      
      public function removeSuite6() : void
      {
         suite6$field = null;
      }
      
      public function get hasSuite6() : Boolean
      {
         return suite6$field != null;
      }
      
      public function set suite6(param1:String) : void
      {
         suite6$field = param1;
      }
      
      public function get suite6() : String
      {
         return suite6$field;
      }
      
      public function removeSuite7() : void
      {
         suite7$field = null;
      }
      
      public function get hasSuite7() : Boolean
      {
         return suite7$field != null;
      }
      
      public function set suite7(param1:String) : void
      {
         suite7$field = param1;
      }
      
      public function get suite7() : String
      {
         return suite7$field;
      }
      
      public function removeSuite8() : void
      {
         suite8$field = null;
      }
      
      public function get hasSuite8() : Boolean
      {
         return suite8$field != null;
      }
      
      public function set suite8(param1:String) : void
      {
         suite8$field = param1;
      }
      
      public function get suite8() : String
      {
         return suite8$field;
      }
      
      public function removeSuite9() : void
      {
         suite9$field = null;
      }
      
      public function get hasSuite9() : Boolean
      {
         return suite9$field != null;
      }
      
      public function set suite9(param1:String) : void
      {
         suite9$field = param1;
      }
      
      public function get suite9() : String
      {
         return suite9$field;
      }
      
      public function removeArmour() : void
      {
         hasField$0 &= 4294967294;
         armour$field = new int();
      }
      
      public function get hasArmour() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set armour(param1:int) : void
      {
         hasField$0 |= 1;
         armour$field = param1;
      }
      
      public function get armour() : int
      {
         return armour$field;
      }
      
      public function removeLevel() : void
      {
         hasField$0 &= 4294967293;
         level$field = new int();
      }
      
      public function get hasLevel() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set level(param1:int) : void
      {
         hasField$0 |= 2;
         level$field = param1;
      }
      
      public function get level() : int
      {
         return level$field;
      }
      
      public function removeHokeInfo() : void
      {
         hokeInfo$field = null;
      }
      
      public function get hasHokeInfo() : Boolean
      {
         return hokeInfo$field != null;
      }
      
      public function set hokeInfo(param1:String) : void
      {
         hokeInfo$field = param1;
      }
      
      public function get hokeInfo() : String
      {
         return hokeInfo$field;
      }
      
      public function removeCoreLevel() : void
      {
         hasField$0 &= 4294967291;
         coreLevel$field = new int();
      }
      
      public function get hasCoreLevel() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set coreLevel(param1:int) : void
      {
         hasField$0 |= 4;
         coreLevel$field = param1;
      }
      
      public function get coreLevel() : int
      {
         return coreLevel$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasSuite1)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,suite1$field);
         }
         if(hasSuite2)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,suite2$field);
         }
         if(hasSuite3)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,suite3$field);
         }
         if(hasSuite4)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,suite4$field);
         }
         if(hasSuite5)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,suite5$field);
         }
         if(hasSuite6)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,suite6$field);
         }
         if(hasSuite7)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,suite7$field);
         }
         if(hasSuite8)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,suite8$field);
         }
         if(hasSuite9)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,suite9$field);
         }
         if(hasArmour)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,armour$field);
         }
         if(hasLevel)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,level$field);
         }
         if(hasHokeInfo)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_STRING(param1,hokeInfo$field);
         }
         if(hasCoreLevel)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,coreLevel$field);
         }
         _loc2_ = 0;
         while(_loc2_ < theseusEquipList.length)
         {
            WriteUtils.writeTag(param1,2,14);
            WriteUtils.write$TYPE_MESSAGE(param1,theseusEquipList[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc15_:* = 0;
         var _loc9_:TheseusEquipMsg = null;
         var _loc11_:uint = 0;
         var _loc16_:uint = 0;
         var _loc12_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc13_:uint = 0;
         var _loc17_:uint = 0;
         var _loc10_:uint = 0;
         var _loc8_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc14_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc15_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusUserMsg.suite1 cannot be set twice.");
                  }
                  _loc11_++;
                  suite1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusUserMsg.suite2 cannot be set twice.");
                  }
                  _loc16_++;
                  suite2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusUserMsg.suite3 cannot be set twice.");
                  }
                  _loc12_++;
                  suite3 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusUserMsg.suite4 cannot be set twice.");
                  }
                  _loc3_++;
                  suite4 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusUserMsg.suite5 cannot be set twice.");
                  }
                  _loc5_++;
                  suite5 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusUserMsg.suite6 cannot be set twice.");
                  }
                  _loc13_++;
                  suite6 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusUserMsg.suite7 cannot be set twice.");
                  }
                  _loc17_++;
                  suite7 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusUserMsg.suite8 cannot be set twice.");
                  }
                  _loc10_++;
                  suite8 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusUserMsg.suite9 cannot be set twice.");
                  }
                  _loc8_++;
                  suite9 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusUserMsg.armour cannot be set twice.");
                  }
                  _loc7_++;
                  armour = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusUserMsg.level cannot be set twice.");
                  }
                  _loc4_++;
                  level = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusUserMsg.hokeInfo cannot be set twice.");
                  }
                  _loc6_++;
                  hokeInfo = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 12:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusUserMsg.coreLevel cannot be set twice.");
                  }
                  _loc14_++;
                  coreLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  _loc9_ = new TheseusEquipMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc9_);
                  theseusEquipList.push(_loc9_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc15_ & 7);
            }
         }
      }
   }
}

