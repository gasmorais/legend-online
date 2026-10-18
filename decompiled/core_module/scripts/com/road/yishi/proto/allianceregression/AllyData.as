package com.road.yishi.proto.allianceregression
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class AllyData extends Message implements IExternalizable
   {
      
      private var player$field:SimplePlayerInfoMsg;
      
      private var isBinding$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var myAllianceExp$field:int;
      
      private var myContractExp$field:int;
      
      private var allyContractExp$field:int;
      
      private var contractLevel$field:int;
      
      private var contractCurExp$field:int;
      
      private var contractNeedExp$field:int;
      
      private var privilegeProcess$field:String;
      
      public function AllyData()
      {
         super();
      }
      
      public function removePlayer() : void
      {
         player$field = null;
      }
      
      public function get hasPlayer() : Boolean
      {
         return player$field != null;
      }
      
      public function set player(param1:SimplePlayerInfoMsg) : void
      {
         player$field = param1;
      }
      
      public function get player() : SimplePlayerInfoMsg
      {
         return player$field;
      }
      
      public function removeIsBinding() : void
      {
         hasField$0 &= 4294967294;
         isBinding$field = new Boolean();
      }
      
      public function get hasIsBinding() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set isBinding(param1:Boolean) : void
      {
         hasField$0 |= 1;
         isBinding$field = param1;
      }
      
      public function get isBinding() : Boolean
      {
         return isBinding$field;
      }
      
      public function removeMyAllianceExp() : void
      {
         hasField$0 &= 4294967293;
         myAllianceExp$field = new int();
      }
      
      public function get hasMyAllianceExp() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set myAllianceExp(param1:int) : void
      {
         hasField$0 |= 2;
         myAllianceExp$field = param1;
      }
      
      public function get myAllianceExp() : int
      {
         return myAllianceExp$field;
      }
      
      public function removeMyContractExp() : void
      {
         hasField$0 &= 4294967291;
         myContractExp$field = new int();
      }
      
      public function get hasMyContractExp() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set myContractExp(param1:int) : void
      {
         hasField$0 |= 4;
         myContractExp$field = param1;
      }
      
      public function get myContractExp() : int
      {
         return myContractExp$field;
      }
      
      public function removeAllyContractExp() : void
      {
         hasField$0 &= 4294967287;
         allyContractExp$field = new int();
      }
      
      public function get hasAllyContractExp() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set allyContractExp(param1:int) : void
      {
         hasField$0 |= 8;
         allyContractExp$field = param1;
      }
      
      public function get allyContractExp() : int
      {
         return allyContractExp$field;
      }
      
      public function removeContractLevel() : void
      {
         hasField$0 &= 4294967279;
         contractLevel$field = new int();
      }
      
      public function get hasContractLevel() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set contractLevel(param1:int) : void
      {
         hasField$0 |= 16;
         contractLevel$field = param1;
      }
      
      public function get contractLevel() : int
      {
         return contractLevel$field;
      }
      
      public function removeContractCurExp() : void
      {
         hasField$0 &= 4294967263;
         contractCurExp$field = new int();
      }
      
      public function get hasContractCurExp() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set contractCurExp(param1:int) : void
      {
         hasField$0 |= 32;
         contractCurExp$field = param1;
      }
      
      public function get contractCurExp() : int
      {
         return contractCurExp$field;
      }
      
      public function removeContractNeedExp() : void
      {
         hasField$0 &= 4294967231;
         contractNeedExp$field = new int();
      }
      
      public function get hasContractNeedExp() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set contractNeedExp(param1:int) : void
      {
         hasField$0 |= 64;
         contractNeedExp$field = param1;
      }
      
      public function get contractNeedExp() : int
      {
         return contractNeedExp$field;
      }
      
      public function removePrivilegeProcess() : void
      {
         privilegeProcess$field = null;
      }
      
      public function get hasPrivilegeProcess() : Boolean
      {
         return privilegeProcess$field != null;
      }
      
      public function set privilegeProcess(param1:String) : void
      {
         privilegeProcess$field = param1;
      }
      
      public function get privilegeProcess() : String
      {
         return privilegeProcess$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPlayer)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,player$field);
         }
         if(hasIsBinding)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,isBinding$field);
         }
         if(hasMyAllianceExp)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,myAllianceExp$field);
         }
         if(hasMyContractExp)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,myContractExp$field);
         }
         if(hasAllyContractExp)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,allyContractExp$field);
         }
         if(hasContractLevel)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,contractLevel$field);
         }
         if(hasContractCurExp)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,contractCurExp$field);
         }
         if(hasContractNeedExp)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,contractNeedExp$field);
         }
         if(hasPrivilegeProcess)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,privilegeProcess$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc12_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc11_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: AllyData.player cannot be set twice.");
                  }
                  _loc12_++;
                  player = new SimplePlayerInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,player);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: AllyData.isBinding cannot be set twice.");
                  }
                  _loc4_++;
                  isBinding = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: AllyData.myAllianceExp cannot be set twice.");
                  }
                  _loc6_++;
                  myAllianceExp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: AllyData.myContractExp cannot be set twice.");
                  }
                  _loc3_++;
                  myContractExp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: AllyData.allyContractExp cannot be set twice.");
                  }
                  _loc7_++;
                  allyContractExp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: AllyData.contractLevel cannot be set twice.");
                  }
                  _loc8_++;
                  contractLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: AllyData.contractCurExp cannot be set twice.");
                  }
                  _loc9_++;
                  contractCurExp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: AllyData.contractNeedExp cannot be set twice.");
                  }
                  _loc5_++;
                  contractNeedExp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: AllyData.privilegeProcess cannot be set twice.");
                  }
                  _loc11_++;
                  privilegeProcess = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

