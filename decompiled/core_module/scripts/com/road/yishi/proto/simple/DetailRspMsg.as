package com.road.yishi.proto.simple
{
   import com.netease.protobuf.*;
   import com.road.yishi.proto.avenger.AvengerMsg;
   import com.road.yishi.proto.campaign.MountInfoMsg;
   import com.road.yishi.proto.children.ChildrenInfoMsg;
   import com.road.yishi.proto.dragontalker.DragonTalkerInfoMsg;
   import com.road.yishi.proto.dragontalker.TalismanMsg;
   import com.road.yishi.proto.goddess.GoddessInfoMsg;
   import com.road.yishi.proto.monster.MonsterMsg;
   import com.road.yishi.proto.pet.PetHallowInfoMsg;
   import com.road.yishi.proto.pet.PlayerPetMsg;
   import com.road.yishi.proto.player.ArtifactInfoMsg;
   import com.road.yishi.proto.tattoo.TattooEnhanceListMsg;
   import com.road.yishi.proto.tattoo.TattooHoleMsg;
   import com.road.yishi.proto.theseus.TheseusRageListMsg;
   import com.road.yishi.proto.theseus.TheseusUserMsg;
   import com.road.yishi.proto.theseus.WarSoulListMsg;
   import com.road.yishi.proto.titan.TitanDataMsg;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class DetailRspMsg extends Message implements IExternalizable
   {
      
      private var other_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var server_name$field:String;
      
      [ArrayElementType("com.road.yishi.proto.simple.SimpleItemInfoMsg")]
      public var item:Array = [];
      
      private var army$field:SimpleArmyMsg;
      
      [ArrayElementType("com.road.yishi.proto.simple.SimpleStarInfoMsg")]
      public var star:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.simple.SimpleStarAdditionMsg")]
      public var starAdd:Array = [];
      
      private var hide_fashion$field:Boolean;
      
      [ArrayElementType("com.road.yishi.proto.simple.SimpleWatchMsg")]
      public var watch:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.simple.SimpleMagicCardInfoMsg")]
      public var cardInfos:Array = [];
      
      private var grade$field:int;
      
      private var fightCapacity$field:int;
      
      private var mount$field:MountInfoMsg;
      
      private var fightPet$field:PlayerPetMsg;
      
      private var fightChild$field:ChildrenInfoMsg;
      
      [ArrayElementType("com.road.yishi.proto.tattoo.TattooHoleMsg")]
      public var holeInfo:Array = [];
      
      private var titanInfo$field:TitanDataMsg;
      
      private var tattooEnhanceInfo$field:TattooEnhanceListMsg;
      
      [ArrayElementType("com.road.yishi.proto.pet.PetHallowInfoMsg")]
      public var petHallowInfo:Array = [];
      
      private var artifactInfo$field:ArtifactInfoMsg;
      
      private var dragonTalkerInfo$field:DragonTalkerInfoMsg;
      
      [ArrayElementType("com.road.yishi.proto.dragontalker.TalismanMsg")]
      public var talismanInfo:Array = [];
      
      private var goddessInfo$field:GoddessInfoMsg;
      
      private var monsterInfo$field:MonsterMsg;
      
      private var avengerInfo$field:AvengerMsg;
      
      private var theseusInfo$field:TheseusUserMsg;
      
      private var rageInfo$field:TheseusRageListMsg;
      
      private var warSoulInfo$field:WarSoulListMsg;
      
      public function DetailRspMsg()
      {
         super();
      }
      
      public function removeOtherId() : void
      {
         hasField$0 &= 4294967294;
         other_id$field = new int();
      }
      
      public function get hasOtherId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set otherId(param1:int) : void
      {
         hasField$0 |= 1;
         other_id$field = param1;
      }
      
      public function get otherId() : int
      {
         return other_id$field;
      }
      
      public function removeServerName() : void
      {
         server_name$field = null;
      }
      
      public function get hasServerName() : Boolean
      {
         return server_name$field != null;
      }
      
      public function set serverName(param1:String) : void
      {
         server_name$field = param1;
      }
      
      public function get serverName() : String
      {
         return server_name$field;
      }
      
      public function removeArmy() : void
      {
         army$field = null;
      }
      
      public function get hasArmy() : Boolean
      {
         return army$field != null;
      }
      
      public function set army(param1:SimpleArmyMsg) : void
      {
         army$field = param1;
      }
      
      public function get army() : SimpleArmyMsg
      {
         return army$field;
      }
      
      public function removeHideFashion() : void
      {
         hasField$0 &= 4294967293;
         hide_fashion$field = new Boolean();
      }
      
      public function get hasHideFashion() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set hideFashion(param1:Boolean) : void
      {
         hasField$0 |= 2;
         hide_fashion$field = param1;
      }
      
      public function get hideFashion() : Boolean
      {
         return hide_fashion$field;
      }
      
      public function removeGrade() : void
      {
         hasField$0 &= 4294967291;
         grade$field = new int();
      }
      
      public function get hasGrade() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set grade(param1:int) : void
      {
         hasField$0 |= 4;
         grade$field = param1;
      }
      
      public function get grade() : int
      {
         return grade$field;
      }
      
      public function removeFightCapacity() : void
      {
         hasField$0 &= 4294967287;
         fightCapacity$field = new int();
      }
      
      public function get hasFightCapacity() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set fightCapacity(param1:int) : void
      {
         hasField$0 |= 8;
         fightCapacity$field = param1;
      }
      
      public function get fightCapacity() : int
      {
         return fightCapacity$field;
      }
      
      public function removeMount() : void
      {
         mount$field = null;
      }
      
      public function get hasMount() : Boolean
      {
         return mount$field != null;
      }
      
      public function set mount(param1:MountInfoMsg) : void
      {
         mount$field = param1;
      }
      
      public function get mount() : MountInfoMsg
      {
         return mount$field;
      }
      
      public function removeFightPet() : void
      {
         fightPet$field = null;
      }
      
      public function get hasFightPet() : Boolean
      {
         return fightPet$field != null;
      }
      
      public function set fightPet(param1:PlayerPetMsg) : void
      {
         fightPet$field = param1;
      }
      
      public function get fightPet() : PlayerPetMsg
      {
         return fightPet$field;
      }
      
      public function removeFightChild() : void
      {
         fightChild$field = null;
      }
      
      public function get hasFightChild() : Boolean
      {
         return fightChild$field != null;
      }
      
      public function set fightChild(param1:ChildrenInfoMsg) : void
      {
         fightChild$field = param1;
      }
      
      public function get fightChild() : ChildrenInfoMsg
      {
         return fightChild$field;
      }
      
      public function removeTitanInfo() : void
      {
         titanInfo$field = null;
      }
      
      public function get hasTitanInfo() : Boolean
      {
         return titanInfo$field != null;
      }
      
      public function set titanInfo(param1:TitanDataMsg) : void
      {
         titanInfo$field = param1;
      }
      
      public function get titanInfo() : TitanDataMsg
      {
         return titanInfo$field;
      }
      
      public function removeTattooEnhanceInfo() : void
      {
         tattooEnhanceInfo$field = null;
      }
      
      public function get hasTattooEnhanceInfo() : Boolean
      {
         return tattooEnhanceInfo$field != null;
      }
      
      public function set tattooEnhanceInfo(param1:TattooEnhanceListMsg) : void
      {
         tattooEnhanceInfo$field = param1;
      }
      
      public function get tattooEnhanceInfo() : TattooEnhanceListMsg
      {
         return tattooEnhanceInfo$field;
      }
      
      public function removeArtifactInfo() : void
      {
         artifactInfo$field = null;
      }
      
      public function get hasArtifactInfo() : Boolean
      {
         return artifactInfo$field != null;
      }
      
      public function set artifactInfo(param1:ArtifactInfoMsg) : void
      {
         artifactInfo$field = param1;
      }
      
      public function get artifactInfo() : ArtifactInfoMsg
      {
         return artifactInfo$field;
      }
      
      public function removeDragonTalkerInfo() : void
      {
         dragonTalkerInfo$field = null;
      }
      
      public function get hasDragonTalkerInfo() : Boolean
      {
         return dragonTalkerInfo$field != null;
      }
      
      public function set dragonTalkerInfo(param1:DragonTalkerInfoMsg) : void
      {
         dragonTalkerInfo$field = param1;
      }
      
      public function get dragonTalkerInfo() : DragonTalkerInfoMsg
      {
         return dragonTalkerInfo$field;
      }
      
      public function removeGoddessInfo() : void
      {
         goddessInfo$field = null;
      }
      
      public function get hasGoddessInfo() : Boolean
      {
         return goddessInfo$field != null;
      }
      
      public function set goddessInfo(param1:GoddessInfoMsg) : void
      {
         goddessInfo$field = param1;
      }
      
      public function get goddessInfo() : GoddessInfoMsg
      {
         return goddessInfo$field;
      }
      
      public function removeMonsterInfo() : void
      {
         monsterInfo$field = null;
      }
      
      public function get hasMonsterInfo() : Boolean
      {
         return monsterInfo$field != null;
      }
      
      public function set monsterInfo(param1:MonsterMsg) : void
      {
         monsterInfo$field = param1;
      }
      
      public function get monsterInfo() : MonsterMsg
      {
         return monsterInfo$field;
      }
      
      public function removeAvengerInfo() : void
      {
         avengerInfo$field = null;
      }
      
      public function get hasAvengerInfo() : Boolean
      {
         return avengerInfo$field != null;
      }
      
      public function set avengerInfo(param1:AvengerMsg) : void
      {
         avengerInfo$field = param1;
      }
      
      public function get avengerInfo() : AvengerMsg
      {
         return avengerInfo$field;
      }
      
      public function removeTheseusInfo() : void
      {
         theseusInfo$field = null;
      }
      
      public function get hasTheseusInfo() : Boolean
      {
         return theseusInfo$field != null;
      }
      
      public function set theseusInfo(param1:TheseusUserMsg) : void
      {
         theseusInfo$field = param1;
      }
      
      public function get theseusInfo() : TheseusUserMsg
      {
         return theseusInfo$field;
      }
      
      public function removeRageInfo() : void
      {
         rageInfo$field = null;
      }
      
      public function get hasRageInfo() : Boolean
      {
         return rageInfo$field != null;
      }
      
      public function set rageInfo(param1:TheseusRageListMsg) : void
      {
         rageInfo$field = param1;
      }
      
      public function get rageInfo() : TheseusRageListMsg
      {
         return rageInfo$field;
      }
      
      public function removeWarSoulInfo() : void
      {
         warSoulInfo$field = null;
      }
      
      public function get hasWarSoulInfo() : Boolean
      {
         return warSoulInfo$field != null;
      }
      
      public function set warSoulInfo(param1:WarSoulListMsg) : void
      {
         warSoulInfo$field = param1;
      }
      
      public function get warSoulInfo() : WarSoulListMsg
      {
         return warSoulInfo$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc6_:* = 0;
         var _loc4_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc5_:* = 0;
         var _loc9_:* = 0;
         if(hasOtherId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,other_id$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
         _loc6_ = 0;
         while(_loc6_ < item.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,item[_loc6_]);
            _loc6_++;
         }
         if(hasArmy)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,army$field);
         }
         _loc4_ = 0;
         while(_loc4_ < star.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,star[_loc4_]);
            _loc4_++;
         }
         _loc2_ = 0;
         while(_loc2_ < starAdd.length)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,starAdd[_loc2_]);
            _loc2_++;
         }
         if(hasHideFashion)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,hide_fashion$field);
         }
         _loc3_ = 0;
         while(_loc3_ < watch.length)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_MESSAGE(param1,watch[_loc3_]);
            _loc3_++;
         }
         _loc7_ = 0;
         while(_loc7_ < cardInfos.length)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_MESSAGE(param1,cardInfos[_loc7_]);
            _loc7_++;
         }
         if(hasGrade)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,grade$field);
         }
         if(hasFightCapacity)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,fightCapacity$field);
         }
         if(hasMount)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_MESSAGE(param1,mount$field);
         }
         if(hasFightPet)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_MESSAGE(param1,fightPet$field);
         }
         if(hasFightChild)
         {
            WriteUtils.writeTag(param1,2,14);
            WriteUtils.write$TYPE_MESSAGE(param1,fightChild$field);
         }
         _loc8_ = 0;
         while(_loc8_ < holeInfo.length)
         {
            WriteUtils.writeTag(param1,2,15);
            WriteUtils.write$TYPE_MESSAGE(param1,holeInfo[_loc8_]);
            _loc8_++;
         }
         if(hasTitanInfo)
         {
            WriteUtils.writeTag(param1,2,16);
            WriteUtils.write$TYPE_MESSAGE(param1,titanInfo$field);
         }
         if(hasTattooEnhanceInfo)
         {
            WriteUtils.writeTag(param1,2,17);
            WriteUtils.write$TYPE_MESSAGE(param1,tattooEnhanceInfo$field);
         }
         _loc5_ = 0;
         while(_loc5_ < petHallowInfo.length)
         {
            WriteUtils.writeTag(param1,2,18);
            WriteUtils.write$TYPE_MESSAGE(param1,petHallowInfo[_loc5_]);
            _loc5_++;
         }
         if(hasArtifactInfo)
         {
            WriteUtils.writeTag(param1,2,19);
            WriteUtils.write$TYPE_MESSAGE(param1,artifactInfo$field);
         }
         if(hasDragonTalkerInfo)
         {
            WriteUtils.writeTag(param1,2,20);
            WriteUtils.write$TYPE_MESSAGE(param1,dragonTalkerInfo$field);
         }
         _loc9_ = 0;
         while(_loc9_ < talismanInfo.length)
         {
            WriteUtils.writeTag(param1,2,21);
            WriteUtils.write$TYPE_MESSAGE(param1,talismanInfo[_loc9_]);
            _loc9_++;
         }
         if(hasGoddessInfo)
         {
            WriteUtils.writeTag(param1,2,22);
            WriteUtils.write$TYPE_MESSAGE(param1,goddessInfo$field);
         }
         if(hasMonsterInfo)
         {
            WriteUtils.writeTag(param1,2,23);
            WriteUtils.write$TYPE_MESSAGE(param1,monsterInfo$field);
         }
         if(hasAvengerInfo)
         {
            WriteUtils.writeTag(param1,2,24);
            WriteUtils.write$TYPE_MESSAGE(param1,avengerInfo$field);
         }
         if(hasTheseusInfo)
         {
            WriteUtils.writeTag(param1,2,25);
            WriteUtils.write$TYPE_MESSAGE(param1,theseusInfo$field);
         }
         if(hasRageInfo)
         {
            WriteUtils.writeTag(param1,2,26);
            WriteUtils.write$TYPE_MESSAGE(param1,rageInfo$field);
         }
         if(hasWarSoulInfo)
         {
            WriteUtils.writeTag(param1,2,27);
            WriteUtils.write$TYPE_MESSAGE(param1,warSoulInfo$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc3_:SimpleItemInfoMsg = null;
         var _loc17_:SimpleStarInfoMsg = null;
         var _loc13_:SimpleStarAdditionMsg = null;
         var _loc30_:SimpleWatchMsg = null;
         var _loc20_:SimpleMagicCardInfoMsg = null;
         var _loc25_:TattooHoleMsg = null;
         var _loc23_:PetHallowInfoMsg = null;
         var _loc11_:TalismanMsg = null;
         var _loc28_:uint = 0;
         var _loc5_:uint = 0;
         var _loc14_:uint = 0;
         var _loc22_:uint = 0;
         var _loc4_:uint = 0;
         var _loc18_:uint = 0;
         var _loc19_:uint = 0;
         var _loc29_:uint = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc15_:uint = 0;
         var _loc21_:uint = 0;
         var _loc24_:uint = 0;
         var _loc7_:uint = 0;
         var _loc26_:uint = 0;
         var _loc16_:uint = 0;
         var _loc8_:uint = 0;
         var _loc27_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc28_ != 0)
                  {
                     throw new IOError("Bad data format: DetailRspMsg.otherId cannot be set twice.");
                  }
                  _loc28_++;
                  otherId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: DetailRspMsg.serverName cannot be set twice.");
                  }
                  _loc5_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  _loc3_ = new SimpleItemInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  item.push(_loc3_);
                  break;
               case 4:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: DetailRspMsg.army cannot be set twice.");
                  }
                  _loc14_++;
                  army = new SimpleArmyMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,army);
                  break;
               case 5:
                  _loc17_ = new SimpleStarInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc17_);
                  star.push(_loc17_);
                  break;
               case 6:
                  _loc13_ = new SimpleStarAdditionMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc13_);
                  starAdd.push(_loc13_);
                  break;
               case 7:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: DetailRspMsg.hideFashion cannot be set twice.");
                  }
                  _loc22_++;
                  hideFashion = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 8:
                  _loc30_ = new SimpleWatchMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc30_);
                  watch.push(_loc30_);
                  break;
               case 9:
                  _loc20_ = new SimpleMagicCardInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc20_);
                  cardInfos.push(_loc20_);
                  break;
               case 10:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: DetailRspMsg.grade cannot be set twice.");
                  }
                  _loc4_++;
                  grade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: DetailRspMsg.fightCapacity cannot be set twice.");
                  }
                  _loc18_++;
                  fightCapacity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: DetailRspMsg.mount cannot be set twice.");
                  }
                  _loc19_++;
                  mount = new MountInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,mount);
                  break;
               case 13:
                  if(_loc29_ != 0)
                  {
                     throw new IOError("Bad data format: DetailRspMsg.fightPet cannot be set twice.");
                  }
                  _loc29_++;
                  fightPet = new PlayerPetMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,fightPet);
                  break;
               case 14:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: DetailRspMsg.fightChild cannot be set twice.");
                  }
                  _loc6_++;
                  fightChild = new ChildrenInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,fightChild);
                  break;
               case 15:
                  _loc25_ = new TattooHoleMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc25_);
                  holeInfo.push(_loc25_);
                  break;
               case 16:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: DetailRspMsg.titanInfo cannot be set twice.");
                  }
                  _loc9_++;
                  titanInfo = new TitanDataMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,titanInfo);
                  break;
               case 17:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: DetailRspMsg.tattooEnhanceInfo cannot be set twice.");
                  }
                  _loc10_++;
                  tattooEnhanceInfo = new TattooEnhanceListMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,tattooEnhanceInfo);
                  break;
               case 18:
                  _loc23_ = new PetHallowInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc23_);
                  petHallowInfo.push(_loc23_);
                  break;
               case 19:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: DetailRspMsg.artifactInfo cannot be set twice.");
                  }
                  _loc15_++;
                  artifactInfo = new ArtifactInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,artifactInfo);
                  break;
               case 20:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: DetailRspMsg.dragonTalkerInfo cannot be set twice.");
                  }
                  _loc21_++;
                  dragonTalkerInfo = new DragonTalkerInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,dragonTalkerInfo);
                  break;
               case 21:
                  _loc11_ = new TalismanMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc11_);
                  talismanInfo.push(_loc11_);
                  break;
               case 22:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: DetailRspMsg.goddessInfo cannot be set twice.");
                  }
                  _loc24_++;
                  goddessInfo = new GoddessInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,goddessInfo);
                  break;
               case 23:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: DetailRspMsg.monsterInfo cannot be set twice.");
                  }
                  _loc7_++;
                  monsterInfo = new MonsterMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,monsterInfo);
                  break;
               case 24:
                  if(_loc26_ != 0)
                  {
                     throw new IOError("Bad data format: DetailRspMsg.avengerInfo cannot be set twice.");
                  }
                  _loc26_++;
                  avengerInfo = new AvengerMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,avengerInfo);
                  break;
               case 25:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: DetailRspMsg.theseusInfo cannot be set twice.");
                  }
                  _loc16_++;
                  theseusInfo = new TheseusUserMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,theseusInfo);
                  break;
               case 26:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: DetailRspMsg.rageInfo cannot be set twice.");
                  }
                  _loc8_++;
                  rageInfo = new TheseusRageListMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,rageInfo);
                  break;
               case 27:
                  if(_loc27_ != 0)
                  {
                     throw new IOError("Bad data format: DetailRspMsg.warSoulInfo cannot be set twice.");
                  }
                  _loc27_++;
                  warSoulInfo = new WarSoulListMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,warSoulInfo);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

