package com.road.yishi.proto.active
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MvpShopMsg extends Message implements IExternalizable
   {
      
      private var id$field:String;
      
      private var begin$field:String;
      
      private var end$field:String;
      
      private var isopen$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.active.MvpShopItemInfoMsg")]
      public var showitems:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.active.MvpShopItemInfoMsg")]
      public var myitems:Array = [];
      
      private var mymvppoint$field:int;
      
      private var nexttime$field:Int64;
      
      public function MvpShopMsg()
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
      
      public function removeIsopen() : void
      {
         hasField$0 &= 4294967294;
         isopen$field = new Boolean();
      }
      
      public function get hasIsopen() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set isopen(param1:Boolean) : void
      {
         hasField$0 |= 1;
         isopen$field = param1;
      }
      
      public function get isopen() : Boolean
      {
         return isopen$field;
      }
      
      public function removeMymvppoint() : void
      {
         hasField$0 &= 4294967293;
         mymvppoint$field = new int();
      }
      
      public function get hasMymvppoint() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set mymvppoint(param1:int) : void
      {
         hasField$0 |= 2;
         mymvppoint$field = param1;
      }
      
      public function get mymvppoint() : int
      {
         return mymvppoint$field;
      }
      
      public function removeNexttime() : void
      {
         nexttime$field = null;
      }
      
      public function get hasNexttime() : Boolean
      {
         return nexttime$field != null;
      }
      
      public function set nexttime(param1:Int64) : void
      {
         nexttime$field = param1;
      }
      
      public function get nexttime() : Int64
      {
         return nexttime$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
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
         if(hasIsopen)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,isopen$field);
         }
         _loc2_ = 0;
         while(_loc2_ < showitems.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,showitems[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < myitems.length)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,myitems[_loc3_]);
            _loc3_++;
         }
         if(hasMymvppoint)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,mymvppoint$field);
         }
         if(hasNexttime)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT64(param1,nexttime$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc11_:MvpShopItemInfoMsg = null;
         var _loc6_:MvpShopItemInfoMsg = null;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: MvpShopMsg.id cannot be set twice.");
                  }
                  _loc7_++;
                  id = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: MvpShopMsg.begin cannot be set twice.");
                  }
                  _loc8_++;
                  begin = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MvpShopMsg.end cannot be set twice.");
                  }
                  _loc3_++;
                  end = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MvpShopMsg.isopen cannot be set twice.");
                  }
                  _loc5_++;
                  isopen = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 4:
                  _loc11_ = new MvpShopItemInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc11_);
                  showitems.push(_loc11_);
                  break;
               case 5:
                  _loc6_ = new MvpShopItemInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  myitems.push(_loc6_);
                  break;
               case 6:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: MvpShopMsg.mymvppoint cannot be set twice.");
                  }
                  _loc10_++;
                  mymvppoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MvpShopMsg.nexttime cannot be set twice.");
                  }
                  _loc4_++;
                  nexttime = ReadUtils.read$TYPE_INT64(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

