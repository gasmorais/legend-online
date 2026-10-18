package com.road.yishi.proto.questionnarie
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class QuestionnarieInfoMsg extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var title$field:String;
      
      private var content$field:String;
      
      private var itemId1$field:int;
      
      private var count1$field:int;
      
      private var itemId2$field:int;
      
      private var count2$field:int;
      
      private var itemId3$field:int;
      
      private var count3$field:int;
      
      private var itemId4$field:int;
      
      private var count4$field:int;
      
      [ArrayElementType("com.road.yishi.proto.questionnarie.QuestionInfoMsg")]
      public var questiones:Array = [];
      
      public function QuestionnarieInfoMsg()
      {
         super();
      }
      
      public function removeId() : void
      {
         hasField$0 &= 4294967294;
         id$field = new int();
      }
      
      public function get hasId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set id(param1:int) : void
      {
         hasField$0 |= 1;
         id$field = param1;
      }
      
      public function get id() : int
      {
         return id$field;
      }
      
      public function removeTitle() : void
      {
         title$field = null;
      }
      
      public function get hasTitle() : Boolean
      {
         return title$field != null;
      }
      
      public function set title(param1:String) : void
      {
         title$field = param1;
      }
      
      public function get title() : String
      {
         return title$field;
      }
      
      public function removeContent() : void
      {
         content$field = null;
      }
      
      public function get hasContent() : Boolean
      {
         return content$field != null;
      }
      
      public function set content(param1:String) : void
      {
         content$field = param1;
      }
      
      public function get content() : String
      {
         return content$field;
      }
      
      public function removeItemId1() : void
      {
         hasField$0 &= 4294967293;
         itemId1$field = new int();
      }
      
      public function get hasItemId1() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set itemId1(param1:int) : void
      {
         hasField$0 |= 2;
         itemId1$field = param1;
      }
      
      public function get itemId1() : int
      {
         return itemId1$field;
      }
      
      public function removeCount1() : void
      {
         hasField$0 &= 4294967291;
         count1$field = new int();
      }
      
      public function get hasCount1() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set count1(param1:int) : void
      {
         hasField$0 |= 4;
         count1$field = param1;
      }
      
      public function get count1() : int
      {
         return count1$field;
      }
      
      public function removeItemId2() : void
      {
         hasField$0 &= 4294967287;
         itemId2$field = new int();
      }
      
      public function get hasItemId2() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set itemId2(param1:int) : void
      {
         hasField$0 |= 8;
         itemId2$field = param1;
      }
      
      public function get itemId2() : int
      {
         return itemId2$field;
      }
      
      public function removeCount2() : void
      {
         hasField$0 &= 4294967279;
         count2$field = new int();
      }
      
      public function get hasCount2() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set count2(param1:int) : void
      {
         hasField$0 |= 16;
         count2$field = param1;
      }
      
      public function get count2() : int
      {
         return count2$field;
      }
      
      public function removeItemId3() : void
      {
         hasField$0 &= 4294967263;
         itemId3$field = new int();
      }
      
      public function get hasItemId3() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set itemId3(param1:int) : void
      {
         hasField$0 |= 32;
         itemId3$field = param1;
      }
      
      public function get itemId3() : int
      {
         return itemId3$field;
      }
      
      public function removeCount3() : void
      {
         hasField$0 &= 4294967231;
         count3$field = new int();
      }
      
      public function get hasCount3() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set count3(param1:int) : void
      {
         hasField$0 |= 64;
         count3$field = param1;
      }
      
      public function get count3() : int
      {
         return count3$field;
      }
      
      public function removeItemId4() : void
      {
         hasField$0 &= 4294967167;
         itemId4$field = new int();
      }
      
      public function get hasItemId4() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set itemId4(param1:int) : void
      {
         hasField$0 |= 128;
         itemId4$field = param1;
      }
      
      public function get itemId4() : int
      {
         return itemId4$field;
      }
      
      public function removeCount4() : void
      {
         hasField$0 &= 4294967039;
         count4$field = new int();
      }
      
      public function get hasCount4() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set count4(param1:int) : void
      {
         hasField$0 |= 256;
         count4$field = param1;
      }
      
      public function get count4() : int
      {
         return count4$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasTitle)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,title$field);
         }
         if(hasContent)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,content$field);
         }
         if(hasItemId1)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,itemId1$field);
         }
         if(hasCount1)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,count1$field);
         }
         if(hasItemId2)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,itemId2$field);
         }
         if(hasCount2)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,count2$field);
         }
         if(hasItemId3)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,itemId3$field);
         }
         if(hasCount3)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,count3$field);
         }
         if(hasItemId4)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,itemId4$field);
         }
         if(hasCount4)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,count4$field);
         }
         _loc2_ = 0;
         while(_loc2_ < questiones.length)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_MESSAGE(param1,questiones[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc14_:QuestionInfoMsg = null;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc10_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc11_:uint = 0;
         var _loc15_:uint = 0;
         var _loc13_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionnarieInfoMsg.id cannot be set twice.");
                  }
                  _loc5_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionnarieInfoMsg.title cannot be set twice.");
                  }
                  _loc9_++;
                  title = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionnarieInfoMsg.content cannot be set twice.");
                  }
                  _loc3_++;
                  content = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionnarieInfoMsg.itemId1 cannot be set twice.");
                  }
                  _loc10_++;
                  itemId1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionnarieInfoMsg.count1 cannot be set twice.");
                  }
                  _loc7_++;
                  count1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionnarieInfoMsg.itemId2 cannot be set twice.");
                  }
                  _loc8_++;
                  itemId2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionnarieInfoMsg.count2 cannot be set twice.");
                  }
                  _loc4_++;
                  count2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionnarieInfoMsg.itemId3 cannot be set twice.");
                  }
                  _loc11_++;
                  itemId3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionnarieInfoMsg.count3 cannot be set twice.");
                  }
                  _loc15_++;
                  count3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionnarieInfoMsg.itemId4 cannot be set twice.");
                  }
                  _loc13_++;
                  itemId4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionnarieInfoMsg.count4 cannot be set twice.");
                  }
                  _loc6_++;
                  count4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  _loc14_ = new QuestionInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc14_);
                  questiones.push(_loc14_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

