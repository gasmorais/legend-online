package com.road.yishi.proto.module
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class EvilLandMsg extends Message implements IExternalizable
   {
      
      private var type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var chapterId$field:int;
      
      private var nodeId$field:int;
      
      private var star$field:int;
      
      private var goddessTear$field:int;
      
      private var buyCount$field:int;
      
      private var updateTime$field:String;
      
      private var boxState$field:String;
      
      private var nodeUpdate$field:EvilLandNodeMsg;
      
      [ArrayElementType("com.road.yishi.proto.module.EvilLandNodeMsg")]
      public var nodeList:Array = [];
      
      public function EvilLandMsg()
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
      
      public function removeChapterId() : void
      {
         hasField$0 &= 4294967293;
         chapterId$field = new int();
      }
      
      public function get hasChapterId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set chapterId(param1:int) : void
      {
         hasField$0 |= 2;
         chapterId$field = param1;
      }
      
      public function get chapterId() : int
      {
         return chapterId$field;
      }
      
      public function removeNodeId() : void
      {
         hasField$0 &= 4294967291;
         nodeId$field = new int();
      }
      
      public function get hasNodeId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set nodeId(param1:int) : void
      {
         hasField$0 |= 4;
         nodeId$field = param1;
      }
      
      public function get nodeId() : int
      {
         return nodeId$field;
      }
      
      public function removeStar() : void
      {
         hasField$0 &= 4294967287;
         star$field = new int();
      }
      
      public function get hasStar() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set star(param1:int) : void
      {
         hasField$0 |= 8;
         star$field = param1;
      }
      
      public function get star() : int
      {
         return star$field;
      }
      
      public function removeGoddessTear() : void
      {
         hasField$0 &= 4294967279;
         goddessTear$field = new int();
      }
      
      public function get hasGoddessTear() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set goddessTear(param1:int) : void
      {
         hasField$0 |= 16;
         goddessTear$field = param1;
      }
      
      public function get goddessTear() : int
      {
         return goddessTear$field;
      }
      
      public function removeBuyCount() : void
      {
         hasField$0 &= 4294967263;
         buyCount$field = new int();
      }
      
      public function get hasBuyCount() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set buyCount(param1:int) : void
      {
         hasField$0 |= 32;
         buyCount$field = param1;
      }
      
      public function get buyCount() : int
      {
         return buyCount$field;
      }
      
      public function removeUpdateTime() : void
      {
         updateTime$field = null;
      }
      
      public function get hasUpdateTime() : Boolean
      {
         return updateTime$field != null;
      }
      
      public function set updateTime(param1:String) : void
      {
         updateTime$field = param1;
      }
      
      public function get updateTime() : String
      {
         return updateTime$field;
      }
      
      public function removeBoxState() : void
      {
         boxState$field = null;
      }
      
      public function get hasBoxState() : Boolean
      {
         return boxState$field != null;
      }
      
      public function set boxState(param1:String) : void
      {
         boxState$field = param1;
      }
      
      public function get boxState() : String
      {
         return boxState$field;
      }
      
      public function removeNodeUpdate() : void
      {
         nodeUpdate$field = null;
      }
      
      public function get hasNodeUpdate() : Boolean
      {
         return nodeUpdate$field != null;
      }
      
      public function set nodeUpdate(param1:EvilLandNodeMsg) : void
      {
         nodeUpdate$field = param1;
      }
      
      public function get nodeUpdate() : EvilLandNodeMsg
      {
         return nodeUpdate$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasChapterId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,chapterId$field);
         }
         if(hasNodeId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,nodeId$field);
         }
         if(hasStar)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,star$field);
         }
         if(hasGoddessTear)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,goddessTear$field);
         }
         if(hasBuyCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,buyCount$field);
         }
         if(hasUpdateTime)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,updateTime$field);
         }
         if(hasBoxState)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,boxState$field);
         }
         if(hasNodeUpdate)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_MESSAGE(param1,nodeUpdate$field);
         }
         _loc2_ = 0;
         while(_loc2_ < nodeList.length)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_MESSAGE(param1,nodeList[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc5_:EvilLandNodeMsg = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc11_:uint = 0;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         var _loc12_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: EvilLandMsg.type cannot be set twice.");
                  }
                  _loc6_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: EvilLandMsg.chapterId cannot be set twice.");
                  }
                  _loc7_++;
                  chapterId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: EvilLandMsg.nodeId cannot be set twice.");
                  }
                  _loc3_++;
                  nodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: EvilLandMsg.star cannot be set twice.");
                  }
                  _loc8_++;
                  star = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: EvilLandMsg.goddessTear cannot be set twice.");
                  }
                  _loc11_++;
                  goddessTear = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: EvilLandMsg.buyCount cannot be set twice.");
                  }
                  _loc10_++;
                  buyCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: EvilLandMsg.updateTime cannot be set twice.");
                  }
                  _loc4_++;
                  updateTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: EvilLandMsg.boxState cannot be set twice.");
                  }
                  _loc12_++;
                  boxState = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: EvilLandMsg.nodeUpdate cannot be set twice.");
                  }
                  _loc9_++;
                  nodeUpdate = new EvilLandNodeMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,nodeUpdate);
                  break;
               case 9:
                  _loc5_ = new EvilLandNodeMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  nodeList.push(_loc5_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

