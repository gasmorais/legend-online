package dragonBones.objects
{
   import dragonBones.animation.Tween;
   import dragonBones.errors.UnknownDataError;
   import dragonBones.utils.*;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.filters.BitmapFilterQuality;
   import flash.geom.ColorTransform;
   import flash.utils.ByteArray;
   import flash.utils.getTimer;
   
   use namespace dragonBones_internal;
   
   public class XMLDataParser
   {
      
      private static var _currentSkeletonData:SkeletonData;
      
      private static var _filters:XMLList;
      
      private static var _versionNow:Boolean;
      
      private static var _appStage:Stage;
      
      private static var splitSkeletonXMLList:XMLList;
      
      private static var splitSkeletonXML:XML;
      
      private static var splitXMLLength:uint;
      
      private static var splitIndex:uint;
      
      private static const ANGLE_TO_RADIAN:Number = Math.PI / 180;
      
      private static const HALF_PI:Number = Math.PI * 0.5;
      
      private static var _helpNode:BoneTransform = new BoneTransform();
      
      private static var _helpFrameData:FrameData = new FrameData();
      
      public static var maxSplitArmature:uint = 6;
      
      public static var maxSplitAnimation:uint = 2;
      
      public static var maxSplitTime:uint = 10;
      
      public function XMLDataParser()
      {
         super();
      }
      
      public static function step(param1:Stage) : void
      {
         _appStage = param1;
      }
      
      private static function checkSkeletonXMLVersion(param1:XML) : Boolean
      {
         var _loc2_:String = param1[ConstValues.A_VERSION];
         switch(_loc2_)
         {
            case "1.4":
            case "1.5":
            case "2.0":
            case "2.1":
            case "2.1.1":
            case "2.1.2":
            case "2.2":
            case "2.2.1":
            case "2.2.2":
               param1.@version = ConstValues.VERSION;
               return false;
            case ConstValues.VERSION:
               return true;
            default:
               throw new Error("Nonsupport data version!");
         }
      }
      
      public static function getElementsByAttribute(param1:XMLList, param2:String, param3:String) : XMLList
      {
         var _loc7_:XML = null;
         var _loc4_:XMLList = new XMLList();
         if(param3 == null || param3 == "")
         {
            return _loc4_;
         }
         var _loc5_:uint = uint(param1.length());
         var _loc6_:* = 0;
         while(_loc6_ < _loc5_)
         {
            _loc7_ = param1[_loc6_];
            if(_loc7_[param2].toString() == param3)
            {
               _loc4_[_loc4_.length()] = param1[_loc6_];
            }
            _loc6_++;
         }
         return _loc4_;
      }
      
      public static function compressData(param1:XML, param2:XML, param3:ByteArray) : ByteArray
      {
         var _loc4_:ByteArray = new ByteArray();
         _loc4_.writeBytes(param3);
         var _loc5_:ByteArray = new ByteArray();
         _loc5_.writeUTFBytes(param2.toXMLString());
         _loc5_.compress();
         _loc4_.position = _loc4_.length;
         _loc4_.writeBytes(_loc5_);
         _loc4_.writeInt(_loc5_.length);
         _loc5_.length = 0;
         _loc5_.writeUTFBytes(param1.toXMLString());
         _loc5_.compress();
         _loc4_.position = _loc4_.length;
         _loc4_.writeBytes(_loc5_);
         _loc4_.writeInt(_loc5_.length);
         return _loc4_;
      }
      
      public static function decompressData(param1:ByteArray) : DecompressedData
      {
         var decompressedData:DecompressedData = null;
         var strSize:int = 0;
         var position:uint = 0;
         var xmlBytes:ByteArray = null;
         var skeletonXML:XML = null;
         var textureAtlasXML:XML = null;
         var compressedByteArray:ByteArray = param1;
         var dataType:String = BytesType.getType(compressedByteArray);
         switch(dataType)
         {
            case BytesType.SWF:
            case BytesType.PNG:
            case BytesType.JPG:
               try
               {
                  compressedByteArray.position = compressedByteArray.length - 4;
                  strSize = compressedByteArray.readInt();
                  position = compressedByteArray.length - 4 - strSize;
                  xmlBytes = new ByteArray();
                  xmlBytes.writeBytes(compressedByteArray,position,strSize);
                  xmlBytes.uncompress();
                  compressedByteArray.length = position;
                  skeletonXML = XML(xmlBytes.readUTFBytes(xmlBytes.length));
                  compressedByteArray.position = compressedByteArray.length - 4;
                  strSize = compressedByteArray.readInt();
                  position = compressedByteArray.length - 4 - strSize;
                  xmlBytes.length = 0;
                  xmlBytes.writeBytes(compressedByteArray,position,strSize);
                  xmlBytes.uncompress();
                  compressedByteArray.length = position;
                  textureAtlasXML = XML(xmlBytes.readUTFBytes(xmlBytes.length));
               }
               catch(e:Error)
               {
                  throw new Error("Decompress error!");
               }
               decompressedData = new DecompressedData(skeletonXML,textureAtlasXML,compressedByteArray);
               return decompressedData;
            case BytesType.ZIP:
               throw new Error("Can not decompress zip!");
            default:
               throw new UnknownDataError();
         }
      }
      
      public static function parseSkeletonData(param1:XML) : SkeletonData
      {
         var _loc3_:XML = null;
         var _loc4_:XML = null;
         var _loc5_:String = null;
         var _loc6_:ArmatureData = null;
         var _loc7_:String = null;
         var _loc8_:AnimationData = null;
         XMLParserEventUtil.instance.isDispatcher = false;
         _versionNow = checkSkeletonXMLVersion(param1);
         if(!_versionNow)
         {
            changeXmlToNow(param1);
         }
         var _loc2_:SkeletonData = new SkeletonData();
         _loc2_._name = param1[ConstValues.A_NAME];
         _loc2_._frameRate = int(param1[ConstValues.A_FRAME_RATE]);
         _currentSkeletonData = _loc2_;
         if(_appStage)
         {
            splitSkeletonXML = param1;
            splitArmatureFrame();
         }
         else
         {
            for each(_loc3_ in param1.elements(ConstValues.ARMATURES).elements(ConstValues.ARMATURE))
            {
               _loc5_ = _loc3_[ConstValues.A_NAME];
               _loc6_ = _loc2_.getArmatureData(_loc5_);
               if(_loc6_)
               {
                  parseArmatureData(_loc3_,_loc6_);
               }
               else
               {
                  _loc6_ = new ArmatureData();
                  _loc6_.frameRate = _loc2_.frameRate;
                  _loc6_.bloodY = _loc3_[ConstValues.V_ARMATURE_BLOODY];
                  _loc6_.rideBloodY = _loc3_[ConstValues.V_ARMATURE_RIDEBLOODY];
                  _loc6_.scale = _loc3_[ConstValues.V_ARMATURE_SCALE];
                  parseArmatureData(_loc3_,_loc6_);
                  _loc2_._armatureDataList.addData(_loc6_,_loc5_);
               }
            }
            for each(_loc4_ in param1.elements(ConstValues.ANIMATIONS).elements(ConstValues.ANIMATION))
            {
               _loc7_ = _loc4_[ConstValues.A_NAME];
               _loc6_ = _loc2_.getArmatureData(_loc7_);
               _loc8_ = _loc2_.getAnimationData(_loc7_);
               if(_loc8_)
               {
                  parseAnimationData(_loc4_,_loc8_,_loc6_);
               }
               else
               {
                  _loc8_ = new AnimationData();
                  parseAnimationData(_loc4_,_loc8_,_loc6_);
                  _loc2_._animationDataList.addData(_loc8_,_loc7_);
               }
            }
         }
         return _loc2_;
      }
      
      private static function splitArmatureFrame() : void
      {
         splitSkeletonXMLList = splitSkeletonXML.elements(ConstValues.ARMATURES).elements(ConstValues.ARMATURE);
         splitXMLLength = splitSkeletonXMLList.length();
         splitIndex = 0;
         if(_appStage)
         {
            _appStage.addEventListener(Event.ENTER_FRAME,splitArmatureHandle);
            return;
         }
         throw new Error("必须调用XMLDataParser.step()方法");
      }
      
      private static function splitArmatureHandle(param1:Event) : void
      {
         var _loc2_:XML = null;
         var _loc3_:String = null;
         var _loc4_:ArmatureData = null;
         var _loc5_:int = getTimer();
      }
      
      private static function splitAnimationFrame() : void
      {
         _appStage.removeEventListener(Event.ENTER_FRAME,splitArmatureHandle);
         splitSkeletonXMLList = splitSkeletonXML.elements(ConstValues.ANIMATIONS).elements(ConstValues.ANIMATION);
         splitXMLLength = splitSkeletonXMLList.length();
         if(splitXMLLength > 0)
         {
            splitIndex = 0;
            _appStage.addEventListener(Event.ENTER_FRAME,splitAnimationHandle);
         }
         else
         {
            _currentSkeletonData = null;
            parseXMLComplete();
         }
      }
      
      private static function splitAnimationHandle(param1:Event) : void
      {
         var _loc2_:XML = null;
         var _loc3_:String = null;
         var _loc4_:AnimationData = null;
         var _loc5_:ArmatureData = null;
         var _loc6_:int = getTimer();
      }
      
      private static function parseXMLComplete() : void
      {
         if(XMLParserEventUtil.instance.hasEventListener(Event.COMPLETE))
         {
            XMLParserEventUtil.instance.dispatchEvent(new Event(Event.COMPLETE));
         }
         else
         {
            XMLParserEventUtil.instance.isDispatcher = true;
         }
      }
      
      private static function changeXmlToNow(param1:XML) : void
      {
         var _loc2_:XML = null;
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:Number = NaN;
         var _loc13_:String = null;
         var _loc14_:String = null;
         var _loc15_:String = null;
         var _loc16_:String = null;
         var _loc17_:String = null;
         var _loc18_:String = null;
         _filters = param1.filters.fl;
         var _loc4_:Boolean = false;
         var _loc19_:int = _filters.length();
         var _loc20_:* = 0;
         while(_loc20_ < _loc19_)
         {
            _loc2_ = _filters[_loc20_];
            _loc3_ = _loc2_.@classname;
            _loc3_ = lowerToUpperFirst(_loc3_.substring(_loc3_.lastIndexOf(".") + 1));
            _loc2_.@name = _loc3_;
            if(_loc2_.@colorArray != undefined)
            {
               _loc5_ = _loc2_.@colorArray;
               _loc6_ = _loc2_.@alphaArray;
               _loc7_ = 0;
               _loc8_ = 0;
               _loc11_ = "";
               while(1)
               {
                  _loc7_ = _loc5_.indexOf(",");
                  _loc8_ = _loc6_.indexOf(",");
                  if(_loc7_ == -1)
                  {
                     _loc9_ = int(_loc5_).toString(16);
                     if(_loc9_ == "0")
                     {
                        _loc9_ = _loc5_;
                     }
                     _loc10_ = (Number(_loc6_) * 255).toString(16);
                     _loc11_ += setColorAlpha(_loc9_,_loc10_);
                     break;
                  }
                  _loc9_ = int(_loc5_.substring(0,_loc7_)).toString(16);
                  if(_loc9_ == "0")
                  {
                     _loc9_ = _loc5_.substring(0,_loc7_);
                  }
                  _loc10_ = (Number(_loc6_.substring(0,_loc8_)) * 255).toString(16);
                  _loc11_ += setColorAlpha(_loc9_,_loc10_) + ",";
                  _loc5_ = _loc5_.substring(_loc7_ + 1);
                  _loc6_ = _loc6_.substring(_loc8_ + 1);
               }
               _loc2_.@colorArray = _loc11_;
            }
            if(_loc2_.@rationArray != undefined)
            {
               _loc2_.@posArray = _loc2_.@rationArray;
            }
            if(_loc2_.@innerShadow != undefined)
            {
               _loc2_.@inner = _loc2_.@innerShadow;
            }
            if(_loc2_.@innerLight != undefined)
            {
               _loc2_.@inner = _loc2_.@innerLight;
            }
            if(_loc2_.@hideObj != undefined)
            {
               _loc2_.@hideObject = _loc2_.@hideObj;
            }
            if(_loc2_.@strength != undefined)
            {
               _loc12_ = Number(_loc2_.@strength);
               _loc2_.@strength = int(_loc12_ * 100);
            }
            if(_loc2_.@color != undefined)
            {
               _loc13_ = int(_loc2_.@color).toString(16);
               if(_loc13_ == "0")
               {
                  _loc13_ = _loc2_.@color;
               }
               _loc14_ = (Number(_loc2_.@alpla) * 255).toString(16);
               _loc2_.@color = setColorAlpha(_loc13_,_loc14_);
            }
            if(_loc2_.@highlightColor != undefined)
            {
               _loc15_ = int(_loc2_.@highlightColor).toString(16);
               if(_loc15_ == "0")
               {
                  _loc15_ = _loc2_.@highlightColor;
               }
               _loc16_ = (Number(_loc2_.@highlightAlpha) * 255).toString(16);
               _loc2_.@highlightColor = setColorAlpha(_loc15_,_loc16_);
            }
            if(_loc2_.@shadowColor != undefined)
            {
               _loc17_ = int(_loc2_.@shadowColor).toString(16);
               if(_loc17_ == "0")
               {
                  _loc17_ = _loc2_.@shadowColor;
               }
               _loc18_ = (Number(_loc2_.@shadowAlpha) * 255).toString(16);
               if(_loc3_ == "dropShadowFilter")
               {
                  _loc2_.@color = setColorAlpha(_loc17_,_loc18_);
               }
               else
               {
                  _loc2_.@shadowColor = setColorAlpha(_loc17_,_loc18_);
               }
            }
            _loc20_++;
         }
      }
      
      private static function setColorAlpha(param1:String, param2:String) : String
      {
         var _loc3_:int = 6;
         while(_loc3_ > param1.length)
         {
            param1 = "0" + param1;
         }
         var _loc4_:int = 2;
         while(_loc4_ > param2.length)
         {
            param2 = "0" + param2;
         }
         return "#" + param1 + param2;
      }
      
      private static function lowerToUpperFirst(param1:String) : String
      {
         var _loc2_:String = param1.charAt(0).toLowerCase();
         return _loc2_ + param1.substring(1);
      }
      
      private static function parseArmatureData(param1:XML, param2:ArmatureData) : void
      {
         var _loc3_:XMLList = param1.elements(ConstValues.BONE);
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:XML = null;
         var _loc7_:BoneData = null;
         var _loc8_:XML = null;
         for each(_loc8_ in _loc3_)
         {
            _loc4_ = _loc8_[ConstValues.A_NAME];
            _loc5_ = _loc8_[ConstValues.A_PARENT];
            _loc6_ = getElementsByAttribute(_loc3_,ConstValues.A_NAME,_loc5_)[0];
            _loc7_ = param2.getBoneData(_loc4_);
            if(_loc7_)
            {
               parseBoneData(_loc8_,_loc6_,_loc7_);
            }
            else
            {
               _loc7_ = new BoneData();
               parseBoneData(_loc8_,_loc6_,_loc7_);
               param2._boneDataList.addData(_loc7_,_loc4_);
            }
         }
         param2.updateBoneList();
      }
      
      dragonBones_internal static function parseBoneData(param1:XML, param2:XML, param3:BoneData) : void
      {
         var _loc4_:XMLList = null;
         var _loc5_:uint = 0;
         var _loc6_:* = 0;
         var _loc7_:XML = null;
         var _loc8_:String = null;
         var _loc9_:DisplayData = null;
         parseNode(param1,param3.node);
         if(param2)
         {
            param3._parent = param2[ConstValues.A_NAME];
            parseNode(param2,_helpNode);
            TransformUtils.transformPointWithParent(param3.node,_helpNode);
         }
         else
         {
            param3._parent = null;
         }
         if(_currentSkeletonData)
         {
            _loc4_ = param1.elements(ConstValues.DISPLAY);
            _loc5_ = uint(_loc4_.length());
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc7_ = _loc4_[_loc6_];
               _loc8_ = _loc7_[ConstValues.A_NAME];
               param3._displayNames[_loc6_] = _loc8_;
               _loc9_ = _currentSkeletonData.getDisplayData(_loc8_);
               if(_loc9_)
               {
                  parseDisplayData(_loc7_,_loc9_);
               }
               else
               {
                  _loc9_ = new DisplayData();
                  parseDisplayData(_loc7_,_loc9_);
                  _currentSkeletonData._displayDataList.addData(_loc9_,_loc8_);
               }
               _loc6_++;
            }
         }
      }
      
      private static function parseDisplayData(param1:XML, param2:DisplayData) : void
      {
         param2._isArmature = Boolean(int(param1[ConstValues.A_IS_ARMATURE]));
         param2.pivotX = Number(param1[ConstValues.A_PIVOT_X]);
         param2.pivotY = Number(param1[ConstValues.A_PIVOT_Y]);
      }
      
      dragonBones_internal static function parseAnimationData(param1:XML, param2:AnimationData, param3:ArmatureData) : void
      {
         var _loc4_:XML = null;
         var _loc5_:String = null;
         var _loc6_:MovementData = null;
         var _loc7_:XMLList = param1.elements(ConstValues.MOVEMENT);
         for each(_loc4_ in _loc7_)
         {
            _loc5_ = _loc4_[ConstValues.A_NAME];
            _loc6_ = param2.getMovementData(_loc5_);
            if(_loc6_)
            {
               parseMovementData(_loc4_,param3,_loc6_);
            }
            else
            {
               _loc6_ = new MovementData();
               parseMovementData(_loc4_,param3,_loc6_);
               param2._movementDataList.addData(_loc6_,_loc5_);
            }
         }
      }
      
      private static function parseMovementData(param1:XML, param2:ArmatureData, param3:MovementData) : void
      {
         var _loc12_:XMLList = null;
         var _loc13_:uint = 0;
         var _loc14_:Vector.<MovementFrameData> = null;
         var _loc15_:XML = null;
         var _loc16_:MovementFrameData = null;
         var _loc17_:* = 0;
         var _loc18_:uint = 0;
         var _loc19_:int = 0;
         if(_currentSkeletonData)
         {
            _loc18_ = _currentSkeletonData._frameRate;
            _loc19_ = int(param1[ConstValues.A_DURATION]);
            param3.duration = _loc19_ > 1 ? _loc19_ / _loc18_ : 0;
            param3.durationTo = int(param1[ConstValues.A_DURATION_TO]) / _loc18_;
            param3.durationTween = int(param1[ConstValues.A_DURATION_TWEEN]) / _loc18_;
            param3.loop = Boolean(int(param1[ConstValues.A_LOOP]) == 1);
            param3.tweenEasing = Number(param1[ConstValues.A_TWEEN_EASING][0]);
         }
         var _loc4_:Vector.<String> = param2.boneNames;
         var _loc5_:XMLList = param1.elements(ConstValues.BONE);
         var _loc6_:String = null;
         var _loc7_:BoneData = null;
         var _loc8_:XML = null;
         var _loc9_:int = 0;
         var _loc10_:XML = null;
         var _loc11_:MovementBoneData = null;
         for each(_loc10_ in _loc5_)
         {
            _loc6_ = _loc10_[ConstValues.A_NAME];
            _loc7_ = param2.getBoneData(_loc6_);
            _loc8_ = getElementsByAttribute(_loc5_,ConstValues.A_NAME,_loc7_.parent)[0];
            _loc11_ = param3.getMovementBoneData(_loc6_);
            if(_loc10_)
            {
               if(_loc11_)
               {
                  parseMovementBoneData(_loc10_,_loc8_,_loc7_,_loc11_);
               }
               else
               {
                  _loc11_ = new MovementBoneData();
                  parseMovementBoneData(_loc10_,_loc8_,_loc7_,_loc11_);
                  param3._movementBoneDataList.addData(_loc11_,_loc6_);
               }
            }
            _loc9_ = _loc4_.indexOf(_loc6_);
            if(_loc9_ >= 0)
            {
               _loc4_.splice(_loc9_,1);
            }
         }
         for each(_loc6_ in _loc4_)
         {
            param3._movementBoneDataList.addData(MovementBoneData.HIDE_DATA,_loc6_);
         }
         _loc12_ = param1.elements(ConstValues.FRAME);
         _loc13_ = uint(_loc12_.length());
         _loc14_ = param3._movementFrameList;
         _loc15_ = null;
         _loc16_ = null;
         _loc17_ = 0;
         while(_loc17_ < _loc13_)
         {
            _loc15_ = _loc12_[_loc17_];
            _loc16_ = _loc14_.length > _loc17_ ? _loc14_[_loc17_] : null;
            if(_loc16_)
            {
               parseMovementFrameData(_loc15_,_loc16_);
            }
            else
            {
               _loc16_ = new MovementFrameData();
               parseMovementFrameData(_loc15_,_loc16_);
               if(_loc14_.indexOf(_loc16_) < 0)
               {
                  _loc14_.push(_loc16_);
               }
            }
            _loc17_++;
         }
      }
      
      private static function parseMovementBoneData(param1:XML, param2:XML, param3:BoneData, param4:MovementBoneData) : void
      {
         var _loc15_:Number = NaN;
         var _loc17_:XMLList = null;
         var _loc18_:uint = 0;
         var _loc19_:XML = null;
         param4.setValues(Number(param1[ConstValues.A_MOVEMENT_SCALE]),Number(param1[ConstValues.A_MOVEMENT_DELAY]));
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         if(param2)
         {
            _loc17_ = param2.elements(ConstValues.FRAME);
            _loc18_ = uint(_loc17_.length());
         }
         var _loc9_:XMLList = param1.elements(ConstValues.FRAME);
         var _loc10_:uint = uint(_loc9_.length());
         var _loc11_:Vector.<FrameData> = param4._frameList;
         var _loc12_:XML = null;
         var _loc13_:FrameData = null;
         var _loc14_:XML = null;
         var _loc16_:* = 0;
         while(_loc16_ < _loc10_)
         {
            _loc12_ = _loc9_[_loc16_];
            _loc13_ = _loc11_.length > _loc16_ ? _loc11_[_loc16_] : null;
            if(_loc13_)
            {
               parseFrameData(_loc12_,_loc13_);
            }
            else
            {
               _loc13_ = new FrameData();
               parseFrameData(_loc12_,_loc13_);
               if(_loc11_.indexOf(_loc13_) < 0)
               {
                  _loc11_.push(_loc13_);
               }
            }
            if(param2)
            {
               while(_loc5_ < _loc18_ && (_loc19_ ? Boolean(_loc7_ < _loc6_ || _loc7_ >= _loc6_ + _loc8_) : Boolean(true)))
               {
                  _loc19_ = _loc17_[_loc5_];
                  _loc6_ += _loc8_;
                  _loc8_ = uint(int(_loc19_[ConstValues.A_DURATION]));
                  _loc5_++;
               }
               parseFrameData(_loc19_,_helpFrameData);
               _loc14_ = _loc17_[_loc5_];
               if(_loc14_)
               {
                  _loc15_ = (_loc7_ - _loc6_) / _loc8_;
               }
               else
               {
                  _loc14_ = _loc19_;
                  _loc15_ = 0;
               }
               if(isNaN(_helpFrameData.tweenEasing))
               {
                  _loc15_ = 0;
               }
               else
               {
                  _loc15_ = Tween.getEaseValue(_loc15_,_helpFrameData.tweenEasing);
               }
               parseNode(_loc14_,_helpNode);
               TransformUtils.setOffSetNode(_helpFrameData.node,_helpNode,_helpNode,_helpFrameData.tweenRotate);
               _helpNode.setValues(_helpFrameData.node.x + _loc15_ * _helpNode.x,_helpFrameData.node.y + _loc15_ * _helpNode.y,_helpFrameData.node.skewX + _loc15_ * _helpNode.skewX,_helpFrameData.node.skewY + _loc15_ * _helpNode.skewY,_helpFrameData.node.scaleX + _loc15_ * _helpNode.scaleX,_helpFrameData.node.scaleY + _loc15_ * _helpNode.scaleY,_helpFrameData.node.pivotX + _loc15_ * _helpNode.pivotX,_helpFrameData.node.pivotY + _loc15_ * _helpNode.pivotY);
               TransformUtils.transformPointWithParent(_loc13_.node,_helpNode);
            }
            _loc7_ += int(_loc12_[ConstValues.A_DURATION]);
            _loc13_.node.x -= param3.node.x;
            _loc13_.node.y -= param3.node.y;
            _loc13_.node.skewX -= param3.node.skewX;
            _loc13_.node.skewY -= param3.node.skewY;
            _loc13_.node.scaleX -= param3.node.scaleX;
            _loc13_.node.scaleY -= param3.node.scaleY;
            _loc13_.node.pivotX -= param3.node.pivotX;
            _loc13_.node.pivotY -= param3.node.pivotY;
            _loc13_.node.z -= param3.node.z;
            _loc16_++;
         }
      }
      
      private static function parseMovementFrameData(param1:XML, param2:MovementFrameData) : void
      {
         if(_currentSkeletonData)
         {
            param2.setValues(Number(param1[ConstValues.A_DURATION]) / _currentSkeletonData._frameRate,param1[ConstValues.A_MOVEMENT],param1[ConstValues.A_EVENT],param1[ConstValues.A_SOUND]);
         }
      }
      
      dragonBones_internal static function parseFrameData(param1:XML, param2:FrameData) : void
      {
         var colorTransformXML:XML = null;
         var tweenEasing:* = undefined;
         var visibleStr:String = null;
         var fls:String = null;
         var index:int = 0;
         var fl:String = null;
         var frameXML:XML = param1;
         var frameData:FrameData = param2;
         parseNode(frameXML,frameData.node);
         if(_currentSkeletonData)
         {
            colorTransformXML = frameXML.elements(ConstValues.COLOR_TRANSFORM)[0];
            if(colorTransformXML)
            {
               parseColorTransform(colorTransformXML,frameData.colorTransform);
            }
            frameData.duration = int(frameXML[ConstValues.A_DURATION]) / _currentSkeletonData._frameRate;
            tweenEasing = frameXML.attribute(ConstValues.A_TWEEN_EASING);
            if(tweenEasing == 0 || tweenEasing < -0.0001 || tweenEasing > 0.0001)
            {
               frameData.tweenEasing = Number(tweenEasing);
            }
            else
            {
               frameData.tweenEasing = NaN;
            }
            if(frameXML[ConstValues.A_FILTERS] != undefined)
            {
               fls = frameXML[ConstValues.A_FILTERS];
               index = 0;
               fl = "";
               while(1)
               {
                  index = fls.indexOf(",");
                  if(index == -1)
                  {
                     fl = fls;
                     frameXML.appendChild(getFilterXml(fl));
                     break;
                  }
                  fl = fls.substring(0,index);
                  frameXML.appendChild(getFilterXml(fl));
                  fls = fls.substring(index + 1);
               }
            }
            frameData.filterArr = sortFilter(frameXML.(ConstValues.A_FILTERS));
            frameData.label = String(frameXML[ConstValues.A_LABEL]);
            frameData.blendMode = String(frameXML[ConstValues.A_BLENDMODE]);
            frameData.tweenRotate = int(frameXML[ConstValues.A_TWEEN_ROTATE]);
            frameData.displayIndex = int(frameXML[ConstValues.A_DISPLAY_INDEX]);
            frameData.movement = String(frameXML[ConstValues.A_MOVEMENT]);
            frameData.event = String(frameXML[ConstValues.A_EVENT]);
            frameData.sound = String(frameXML[ConstValues.A_SOUND]);
            frameData.soundEffect = String(frameXML[ConstValues.A_SOUND_EFFECT]);
            visibleStr = String(frameXML[ConstValues.A_VISIBLE]);
            frameData.visible = visibleStr == "1" || visibleStr == "";
         }
      }
      
      private static function getFilterXml(param1:String) : XML
      {
         var _loc2_:XML = null;
         var _loc3_:* = 0;
         while(_loc3_ < _filters.length())
         {
            if(_filters[_loc3_].@id == param1)
            {
               _loc2_ = _filters[_loc3_].copy();
               delete _loc2_.@id;
               return _loc2_;
            }
            _loc3_++;
         }
         return null;
      }
      
      private static function parseNode(param1:XML, param2:BoneTransform) : void
      {
         param2.x = Number(param1[ConstValues.A_X]);
         param2.y = Number(param1[ConstValues.A_Y]);
         param2.skewX = Number(param1[ConstValues.A_SKEW_X]) * ANGLE_TO_RADIAN;
         param2.skewY = Number(param1[ConstValues.A_SKEW_Y]) * ANGLE_TO_RADIAN;
         param2.scaleX = Number(param1[ConstValues.A_SCALE_X]);
         param2.scaleY = Number(param1[ConstValues.A_SCALE_Y]);
         param2.pivotX = Number(param1[ConstValues.A_PIVOT_X]);
         param2.pivotY = Number(param1[ConstValues.A_PIVOT_Y]);
         param2.z = int(param1[ConstValues.A_Z]);
      }
      
      private static function parseColorTransform(param1:XML, param2:ColorTransform) : void
      {
         var _loc3_:Number = Number(param1[ConstValues.A_ALPHA_MULTIPLIER]);
         var _loc4_:Number = Number(param1[ConstValues.A_RED_MULTIPLIER]);
         var _loc5_:Number = Number(param1[ConstValues.A_GREEN_MULTIPLIER]);
         var _loc6_:Number = Number(param1[ConstValues.A_BLUE_MULTIPLIER]);
         if(_loc3_ > 1 || _loc4_ > 1 || _loc5_ > 1 || _loc6_ > 1)
         {
            param1[ConstValues.A_ALPHA_MULTIPLIER] = _loc3_ = _loc3_ / 100;
            param1[ConstValues.A_RED_MULTIPLIER] = _loc4_ = _loc4_ / 100;
            param1[ConstValues.A_GREEN_MULTIPLIER] = _loc5_ = _loc5_ / 100;
            param1[ConstValues.A_BLUE_MULTIPLIER] = _loc6_ = _loc6_ / 100;
         }
         param2.alphaOffset = int(param1[ConstValues.A_ALPHA]);
         param2.redOffset = int(param1[ConstValues.A_RED]);
         param2.greenOffset = int(param1[ConstValues.A_GREEN]);
         param2.blueOffset = int(param1[ConstValues.A_BLUE]);
         param2.alphaMultiplier = _loc3_;
         param2.redMultiplier = _loc4_;
         param2.greenMultiplier = _loc5_;
         param2.blueMultiplier = _loc6_;
      }
      
      private static function sortFilter(param1:XMLList) : Array
      {
         var xml:XML = null;
         var quality:int = 0;
         var alphaColor:Number = NaN;
         var alphaHighlightColor:Number = NaN;
         var alphaShadowColor:Number = NaN;
         var coString:String = null;
         var strength:Number = NaN;
         var knockout:Boolean = false;
         var inner:Boolean = false;
         var color:uint = 0;
         var highlightColor:uint = 0;
         var shadowColor:uint = 0;
         var hideObject:Boolean = false;
         var colorsString:String = null;
         var myPattern:RegExp = null;
         var temp:String = null;
         var colors:Array = null;
         var alphas:Array = null;
         var index:int = 0;
         var posString:String = null;
         var poss:Array = null;
         var pos:uint = 0;
         var filterNode:Object = null;
         var filterList:XMLList = param1;
         var getColor:Function = function(param1:uint):uint
         {
            var _loc2_:int = param1 >> 24 & 0xFF;
            var _loc3_:int = param1 >> 16 & 0xFF;
            var _loc4_:int = param1 >> 8 & 0xFF;
            return _loc2_ << 16 | _loc3_ << 8 | _loc4_;
         };
         var filters:Array = new Array();
         var colorTemp:uint = 0;
         var i:int = 0;
         while(i < filterList.fl.length())
         {
            xml = filterList.fl[i];
            filterNode = new Object();
            filterNode.enabled = xml.@enabled == "false" ? false : true;
            if(xml.@strength != undefined)
            {
               strength = Number(xml.@strength) / 100;
            }
            if(xml.@knockout != undefined)
            {
               knockout = xml.@knockout.toString() == "false" ? false : true;
            }
            if(xml.@inner != undefined)
            {
               inner = xml.@inner.toString() == "false" ? false : true;
            }
            if(xml.@color != undefined)
            {
               coString = xml.@color.toString().replace("#","0x");
               if(coString.length == 8)
               {
                  alphaColor = 1;
                  color = uint(coString);
               }
               else if(coString.length == 10)
               {
                  color = uint(coString);
                  alphaColor = (color & 0xFF) / 255;
                  color = getColor(color);
               }
            }
            if(xml.@highlightColor != undefined)
            {
               coString = xml.@highlightColor.toString().replace("#","0x");
               if(coString.length == 8)
               {
                  alphaHighlightColor = 1;
                  highlightColor = uint(coString);
               }
               else if(coString.length == 10)
               {
                  highlightColor = uint(coString);
                  alphaHighlightColor = (highlightColor & 0xFF) / 255;
                  highlightColor = getColor(highlightColor);
               }
            }
            if(xml.@shadowColor != undefined)
            {
               coString = xml.@shadowColor.toString().replace("#","0x");
               if(coString.length == 8)
               {
                  alphaShadowColor = 1;
                  shadowColor = uint(coString);
               }
               else if(coString.length == 10)
               {
                  shadowColor = uint(coString);
                  alphaShadowColor = (shadowColor & 0xFF) / 255;
                  shadowColor = getColor(shadowColor);
               }
            }
            if(xml.@hideObject != undefined)
            {
               hideObject = xml.@hideObject.toString() == "false" ? false : true;
            }
            if(xml.@quality != undefined)
            {
               quality = int(xml.@quality);
               switch(xml.@quality.toString())
               {
                  case "low":
                     quality = BitmapFilterQuality.LOW;
                     break;
                  case "medium":
                     quality = BitmapFilterQuality.MEDIUM;
                     break;
                  case "high":
                     quality = BitmapFilterQuality.HIGH;
               }
            }
            if(xml.@colorArray != undefined)
            {
               colorsString = xml.@colorArray;
               myPattern = /#/g;
               temp = colorsString.replace(myPattern,"0x");
               colors = new Array();
               alphas = new Array();
               colorTemp = 0;
               while(1)
               {
                  index = temp.indexOf(",");
                  if(index == -1)
                  {
                     colorsString = temp;
                     if(colorsString.length == 8)
                     {
                        alphas.push(1);
                        colorTemp = uint(colorsString);
                        colors.push(colorTemp);
                     }
                     else if(colorsString.length == 10)
                     {
                        colorTemp = uint(colorsString);
                        alphas.push((colorTemp & 0xFF) / 255);
                        colors.push(getColor(colorTemp));
                     }
                     break;
                  }
                  colorsString = temp.substring(0,index);
                  if(colorsString.length == 8)
                  {
                     alphas.push(1);
                     colorTemp = uint(colorsString);
                     colors.push(colorTemp);
                  }
                  else if(colorsString.length == 10)
                  {
                     colorTemp = uint(colorsString);
                     alphas.push((colorTemp & 0xFF) / 255);
                     colors.push(getColor(colorTemp));
                  }
                  temp = temp.substring(index + 1);
               }
            }
            if(xml.@posArray != undefined)
            {
               posString = xml.@posArray;
               poss = new Array();
               while(1)
               {
                  index = posString.indexOf(",");
                  if(index == -1)
                  {
                     pos = uint(posString);
                     poss.push(pos);
                     break;
                  }
                  pos = uint(posString.substring(0,index));
                  poss.push(pos);
                  posString = posString.substring(index + 1);
               }
            }
            filterNode.className = xml.@name.toString();
            filterNode.distance = Number(xml.@distance);
            filterNode.angle = Number(xml.@angle);
            filterNode.highlightColor = highlightColor;
            filterNode.highlightAlpha = alphaHighlightColor;
            filterNode.shadowColor = shadowColor;
            filterNode.shadowAlpha = alphaShadowColor;
            filterNode.blurX = Number(xml.@blurX);
            filterNode.blurY = Number(xml.@blurY);
            filterNode.strength = strength;
            filterNode.quality = quality;
            filterNode.type = xml.@type;
            filterNode.knockout = knockout;
            filterNode.brightness = Number(xml.@brightness);
            filterNode.contrast = Number(xml.@contrast);
            filterNode.saturation = Number(xml.@saturation);
            filterNode.hue = Number(xml.@hue);
            filterNode.hideObject = hideObject;
            filterNode.color = color;
            filterNode.alpha = alphaColor;
            filterNode.inner = inner;
            filterNode.colors = colors;
            filterNode.alphas = alphas;
            filterNode.ratios = poss;
            filters.push(filterNode);
            i++;
         }
         if(filters.length == 0)
         {
            return null;
         }
         return filters;
      }
      
      public static function get versionNow() : Boolean
      {
         return _versionNow;
      }
   }
}

