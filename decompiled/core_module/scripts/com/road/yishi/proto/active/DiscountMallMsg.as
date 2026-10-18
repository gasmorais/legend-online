package com.road.yishi.proto.active
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class DiscountMallMsg extends Message implements IExternalizable
   {
      
      private var id$field:String;
      
      private var begin$field:String;
      
      private var end$field:String;
      
      private var logo$field:String;
      
      [ArrayElementType("com.road.yishi.proto.active.DiscountMallItemInfo")]
      public var items:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.active.DiscountMallScoreInfo")]
      public var scores:Array = [];
      
      private var myscore$field:int;
      
      private var hasField$0:uint = 0;
      
      private var myDisc$field:int;
      
      public function DiscountMallMsg()
      {
         super();
      }
      
      public function removeId() : void
      {
         id$field = null;
      }
      
      public function get hasId() : Boolean
      {
         return id$field != null;
      }
      
      public function set id(param1:String) : void
      {
         id$field = param1;
      }
      
      public function get id() : String
      {
         return id$field;
      }
      
      public function removeBegin() : void
      {
         begin$field = null;
      }
      
      public function get hasBegin() : Boolean
      {
         return begin$field != null;
      }
      
      public function set begin(param1:String) : void
      {
         begin$field = param1;
      }
      
      public function get begin() : String
      {
         return begin$field;
      }
      
      public function removeEnd() : void
      {
         end$field = null;
      }
      
      public function get hasEnd() : Boolean
      {
         return end$field != null;
      }
      
      public function set end(param1:String) : void
      {
         end$field = param1;
      }
      
      public function get end() : String
      {
         return end$field;
      }
      
      public function removeLogo() : void
      {
         logo$field = null;
      }
      
      public function get hasLogo() : Boolean
      {
         return logo$field != null;
      }
      
      public function set logo(param1:String) : void
      {
         logo$field = param1;
      }
      
      public function get logo() : String
      {
         return logo$field;
      }
      
      public function removeMyscore() : void
      {
         hasField$0 &= 4294967294;
         myscore$field = new int();
      }
      
      public function get hasMyscore() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set myscore(param1:int) : void
      {
         hasField$0 |= 1;
         myscore$field = param1;
      }
      
      public function get myscore() : int
      {
         return myscore$field;
      }
      
      public function removeMyDisc() : void
      {
         hasField$0 &= 4294967293;
         myDisc$field = new int();
      }
      
      public function get hasMyDisc() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set myDisc(param1:int) : void
      {
         hasField$0 |= 2;
         myDisc$field = param1;
      }
      
      public function get myDisc() : int
      {
         return myDisc$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasId)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,id$field);
         }
         if(hasBegin)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,begin$field);
         }
         if(hasEnd)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,end$field);
         }
         if(hasLogo)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,logo$field);
         }
         _loc3_ = 0;
         while(_loc3_ < items.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,items[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < scores.length)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,scores[_loc2_]);
            _loc2_++;
         }
         if(hasMyscore)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,myscore$field);
         }
         if(hasMyDisc)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,myDisc$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc11_:DiscountMallItemInfo = null;
         var _loc8_:DiscountMallScoreInfo = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: DiscountMallMsg.id cannot be set twice.");
                  }
                  _loc5_++;
                  id = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: DiscountMallMsg.begin cannot be set twice.");
                  }
                  _loc6_++;
                  begin = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: DiscountMallMsg.end cannot be set twice.");
                  }
                  _loc3_++;
                  end = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: DiscountMallMsg.logo cannot be set twice.");
                  }
                  _loc10_++;
                  logo = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  _loc11_ = new DiscountMallItemInfo();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc11_);
                  items.push(_loc11_);
                  break;
               case 5:
                  _loc8_ = new DiscountMallScoreInfo();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc8_);
                  scores.push(_loc8_);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: DiscountMallMsg.myscore cannot be set twice.");
                  }
                  _loc4_++;
                  myscore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: DiscountMallMsg.myDisc cannot be set twice.");
                  }
                  _loc7_++;
                  myDisc = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

