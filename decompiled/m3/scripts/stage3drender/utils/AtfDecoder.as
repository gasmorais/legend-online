package stage3drender.utils
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import stage3drender.Global;
   import starling.textures.SubTexture;
   import starling.textures.Texture;
   
   public class AtfDecoder
   {
      
      public function AtfDecoder()
      {
         super();
      }
      
      public static function decode(param1:String, param2:Texture, param3:Object) : void
      {
         var _loc6_:Dictionary = null;
         var _loc7_:Object = null;
         var _loc4_:Vector.<Texture> = new Vector.<Texture>();
         Global.avatarTextureDic[param1] = _loc4_;
         _loc6_ = Global.avatarPartPostion[param1];
         if(!_loc6_)
         {
            _loc6_ = new Dictionary();
            Global.avatarPartPostion[param1] = _loc6_;
         }
         var _loc8_:Object = param3.data;
         for(var _loc5_:String in _loc8_)
         {
            _loc7_ = _loc8_[_loc5_].position;
            _loc4_[_loc5_] = new SubTexture(param2,new Rectangle(_loc7_.x,_loc7_.y,_loc7_.w,_loc7_.h));
            _loc6_[_loc5_] = new Point(_loc7_.px,_loc7_.py);
         }
      }
      
      public static function avatarAtfDecode(param1:String, param2:Texture, param3:Object) : int
      {
         var _loc13_:* = null;
         var _loc14_:Object = null;
         var _loc6_:String = null;
         var _loc21_:String = null;
         var _loc16_:String = null;
         var _loc17_:int = 0;
         var _loc19_:* = undefined;
         var _loc18_:Dictionary = null;
         var _loc11_:Dictionary = null;
         var _loc4_:Array = null;
         var _loc9_:int = 0;
         var _loc7_:String = null;
         var _loc15_:Texture = null;
         var _loc12_:Object = param3.data.pic;
         var _loc8_:RegExp = /\//g;
         var _loc10_:String = param1.replace(_loc8_,"_");
         var _loc5_:Object = {};
         for(var _loc20_:String in _loc12_)
         {
            _loc6_ = _loc20_.substr(_loc20_.lastIndexOf("/") + 1,_loc20_.length);
            _loc4_ = _loc6_.split("_");
            _loc16_ = _loc4_[0];
            _loc21_ = _loc4_[1];
            _loc19_ = Global.avatarTextureDic[_loc10_ + "_" + _loc16_ + "_" + _loc21_];
            _loc18_ = Global.avatarPartPostion[_loc10_ + "_" + _loc16_ + "_" + _loc21_];
            _loc11_ = Global.avatarHitData[_loc10_ + "_" + _loc16_ + "_" + _loc21_];
            if(!_loc19_)
            {
               _loc19_ = new Vector.<Texture>();
               Global.avatarTextureDic[_loc10_ + "_" + _loc16_ + "_" + _loc21_] = _loc19_;
               if(!_loc18_)
               {
                  _loc18_ = new Dictionary();
                  Global.avatarPartPostion[_loc10_ + "_" + _loc16_ + "_" + _loc21_] = _loc18_;
               }
               if(!_loc11_)
               {
                  _loc11_ = new Dictionary();
                  Global.avatarHitData[_loc10_ + "_" + _loc16_ + "_" + _loc21_] = _loc11_;
               }
               if(_loc16_ == "S")
               {
                  _loc17_ = int(param3.data.totalFrame.stand);
               }
               else
               {
                  _loc17_ = int(param3.data.totalFrame.walk);
               }
               if(_loc12_[_loc20_].hasOwnProperty("sizeType"))
               {
                  _loc5_["sizeType"] = _loc12_[_loc20_].sizeType;
               }
               if(_loc12_[_loc20_].hasOwnProperty("showNamePosY"))
               {
                  _loc5_["showNamePosY"] = _loc12_[_loc20_].showNamePosY;
               }
               if(_loc12_[_loc20_].hasOwnProperty("curTotalFrameX"))
               {
                  _loc5_["curTotalFrameX"] = _loc12_[_loc20_].curTotalFrameX;
               }
               if(_loc12_[_loc20_].hasOwnProperty("offsetY"))
               {
                  _loc5_["offsetY"] = _loc12_[_loc20_].offsetY;
               }
               if(_loc12_[_loc20_].hasOwnProperty("attackPara"))
               {
                  _loc5_["attackPara"] = _loc12_[_loc20_].attackPara;
               }
               if(_loc12_[_loc20_].hasOwnProperty("flight"))
               {
                  _loc5_["flight"] = _loc12_[_loc20_].flight;
               }
               Global.avatarPartParams[param1] = _loc5_;
               _loc9_ = 0;
               while(_loc9_ < _loc17_)
               {
                  _loc7_ = _loc20_.substr(0,_loc20_.lastIndexOf("_")) + "_" + _loc9_;
                  _loc14_ = _loc12_[_loc7_].position;
                  _loc15_ = new SubTexture(param2,new Rectangle(_loc14_.x,_loc14_.y,_loc14_.w,_loc14_.h));
                  _loc19_.push(_loc15_);
                  _loc18_[_loc9_] = new Point(_loc14_.px,_loc14_.py);
                  _loc11_[_loc9_] = _loc12_[_loc7_].hitPointArr;
                  _loc9_++;
               }
            }
         }
         return _loc12_[_loc20_].sizeType;
      }
   }
}

