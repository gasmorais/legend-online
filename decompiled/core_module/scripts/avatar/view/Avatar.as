package avatar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.TempleteManager;
   
   public class Avatar extends Sprite implements Disposeable
   {
      
      public static const SIZETYPE_CHANGE:String = "sizeTypeChange";
      
      public static const WALK:int = 4;
      
      public static const JUMP:int = 1;
      
      public static const ATTACK:int = 2;
      
      public static const STAND:int = 3;
      
      private static var _isInitRet9:Boolean = false;
      
      private static var _isInitRet10:Boolean = false;
      
      private static var standBitData:BitmapData;
      
      private static var mountBitData:BitmapData;
      
      public static var sizeMaxNew:Object = {
         "1":{
            "x":-89,
            "y":-145,
            "width":178,
            "height":200,
            "size":1,
            "sizeType":1
         },
         "2":{
            "x":-185,
            "y":-264,
            "width":370,
            "height":339,
            "size":3,
            "sizeType":2
         },
         "3":{
            "x":-130,
            "y":-205,
            "width":260,
            "height":250,
            "size":2,
            "sizeType":3
         },
         "4":{
            "x":-200,
            "y":-200,
            "width":400,
            "height":400,
            "size":4,
            "sizeType":4
         },
         "5":{
            "x":-250,
            "y":-292,
            "width":500,
            "height":417,
            "size":6,
            "sizeType":5
         },
         "6":{
            "x":-240,
            "y":-270,
            "width":450,
            "height":400,
            "size":5,
            "sizeType":6
         },
         "7":{
            "x":-45,
            "y":-92,
            "width":90,
            "height":112,
            "size":-7,
            "sizeType":7
         },
         "8":{
            "x":-65,
            "y":-117,
            "width":130,
            "height":162,
            "size":-6,
            "sizeType":8
         },
         "9":{
            "x":-420,
            "y":-450,
            "width":740,
            "height":678,
            "size":7,
            "sizeType":9
         },
         "10":{
            "x":-377,
            "y":-650,
            "width":800,
            "height":1000,
            "size":8,
            "sizeType":10
         },
         "11":{
            "x":-110,
            "y":-191,
            "width":220,
            "height":247,
            "size":1.5,
            "sizeType":11
         },
         "12":{
            "x":-120,
            "y":-191,
            "width":240,
            "height":247,
            "size":1.6,
            "sizeType":12
         },
         "13":{
            "x":-165,
            "y":-351,
            "width":330,
            "height":371,
            "size":2.5,
            "sizeType":13
         },
         "14":{
            "x":-332,
            "y":-379,
            "width":740,
            "height":678,
            "size":7,
            "sizeType":14
         }
      };
      
      public static var sizeMaxOld:Object = {
         "1":{
            "x":-89,
            "y":-145,
            "width":178,
            "height":200,
            "size":1,
            "sizeType":1
         },
         "2":{
            "x":-185,
            "y":-264,
            "width":370,
            "height":339,
            "size":3,
            "sizeType":2
         },
         "3":{
            "x":-130,
            "y":-205,
            "width":260,
            "height":250,
            "size":2,
            "sizeType":3
         },
         "4":{
            "x":-200,
            "y":-200,
            "width":400,
            "height":400,
            "size":4,
            "sizeType":4
         },
         "5":{
            "x":-250,
            "y":-292,
            "width":500,
            "height":417,
            "size":6,
            "sizeType":5
         },
         "6":{
            "x":-320,
            "y":-350,
            "width":450,
            "height":400,
            "size":5,
            "sizeType":6
         },
         "7":{
            "x":-45,
            "y":-92,
            "width":90,
            "height":112,
            "size":-7,
            "sizeType":7
         },
         "8":{
            "x":-65,
            "y":-117,
            "width":130,
            "height":162,
            "size":-6,
            "sizeType":8
         },
         "9":{
            "x":-332,
            "y":-379,
            "width":740,
            "height":678,
            "size":7,
            "sizeType":9
         },
         "10":{
            "x":-377,
            "y":-650,
            "width":800,
            "height":1000,
            "size":8,
            "sizeType":10
         },
         "11":{
            "x":-110,
            "y":-191,
            "width":220,
            "height":247,
            "size":1.5,
            "sizeType":11
         },
         "12":{
            "x":-120,
            "y":-191,
            "width":240,
            "height":247,
            "size":1.6,
            "sizeType":12
         },
         "13":{
            "x":-165,
            "y":-351,
            "width":330,
            "height":371,
            "size":2.5,
            "sizeType":13
         }
      };
      
      private static var _ret9:Array = [8138,8098,8175,8144,8132,8169,8187,8168,8183,8167,8188,8114,8270,8329];
      
      private static var _ret10:Array = [8316];
      
      protected var _state:int;
      
      private var _frameX:int;
      
      private var _frameY:int = -10000;
      
      private var _totalFrameX:int = 6;
      
      private var _totalFrameY:int;
      
      protected var _body:String;
      
      protected var _unitWidth:Number;
      
      protected var _unitHeight:Number;
      
      protected var _face:Boolean;
      
      protected var _drawRect:Rectangle;
      
      protected var _angle:Number;
      
      protected var _bitmap:Bitmap;
      
      protected var _clearRect:Rectangle;
      
      protected var _isStop:Boolean;
      
      protected var _standPos:Bitmap;
      
      protected var _mountStandPos:Bitmap;
      
      private var _type:int;
      
      protected var _sizeType:int = 0;
      
      protected var _pixelSnapping:String;
      
      protected var _smoothing:Boolean;
      
      protected var _isInit:Boolean;
      
      public var curTotalFrameX:int = 6;
      
      protected var _cleanBitmapData:Boolean = true;
      
      protected var _noShadow:Boolean = false;
      
      protected var _showMountShadow:Boolean = false;
      
      private var _currentMountId:int;
      
      protected var size:Point = new Point();
      
      public var flight:int = 0;
      
      private var _footPrintLayer:Sprite;
      
      private var _isRending:Boolean = true;
      
      public function Avatar(param1:String, param2:Boolean, param3:String = "auto", param4:Boolean = true)
      {
         super();
         _pixelSnapping = param3;
         _smoothing = param4;
         _bitmap = new Bitmap();
         addChild(_bitmap);
         _drawRect = new Rectangle();
         _isStop = false;
         if(param2)
         {
            sizeType = 1;
         }
         _body = param1;
         if(!Avatar.standBitData)
         {
            Avatar.standBitData = ComponentFactory.Instance.creatBitmap("asset.core.StandShadowAsset").bitmapData;
         }
         if(!Avatar.mountBitData)
         {
            Avatar.mountBitData = ComponentFactory.Instance.creatBitmap("asset.core.MountStandShadowAsset").bitmapData;
         }
         _standPos = new Bitmap(Avatar.standBitData);
         _standPos.x = -45;
         _standPos.y = -32;
         addChildAt(_standPos,0);
         _mountStandPos = new Bitmap(Avatar.mountBitData);
         _mountStandPos.x = -91;
         _mountStandPos.y = -33;
         addChildAt(_mountStandPos,0);
         showMountShadow = false;
         initBitmapData();
      }
      
      public static function get oldMountId() : Array
      {
         var _loc1_:ConfigInfosTempInfo = null;
         var _loc2_:int = 0;
         if(!_isInitRet9)
         {
            _loc1_ = TempleteManager.instance.getConfigInfoByConfigName("config_9mount_ids");
            if(_loc1_)
            {
               _ret9 = _loc1_.ConfigValue.split(",");
               _loc2_ = 0;
               while(_loc2_ < _ret9.length)
               {
                  _ret9[_loc2_] = int(_ret9[_loc2_]);
                  _loc2_++;
               }
               _isInitRet9 = true;
            }
         }
         return _ret9;
      }
      
      protected static function get SizeType_NEW10() : Array
      {
         var _loc1_:ConfigInfosTempInfo = null;
         var _loc2_:int = 0;
         if(!_isInitRet10)
         {
            _loc1_ = TempleteManager.instance.getConfigInfoByConfigName("config_10mount_ids");
            if(_loc1_)
            {
               _ret10 = _loc1_.ConfigValue.split(",");
               _loc2_ = 0;
               while(_loc2_ < _ret10.length)
               {
                  _ret10[_loc2_] = int(_ret10[_loc2_]);
                  _loc2_++;
               }
               _isInitRet10 = true;
            }
         }
         return _ret10;
      }
      
      public function get currentMountId() : int
      {
         return _currentMountId;
      }
      
      public function set currentMountId(param1:int) : void
      {
         _currentMountId = param1;
      }
      
      public function get sizeMax() : Object
      {
         var _loc1_:int = oldMountId.indexOf(currentMountId);
         if(_loc1_ != -1)
         {
            return sizeMaxOld;
         }
         return sizeMaxNew;
      }
      
      public function get footPrintLayer() : Sprite
      {
         return _footPrintLayer;
      }
      
      public function set footPrintLayer(param1:Sprite) : void
      {
         _footPrintLayer = param1;
      }
      
      public function get bitmap() : Bitmap
      {
         return _bitmap;
      }
      
      public function get clearRect() : Rectangle
      {
         return _clearRect;
      }
      
      public function set showMountShadow(param1:Boolean) : void
      {
         if(param1 && _standPos && _mountStandPos)
         {
            _standPos.visible = false;
            _mountStandPos.visible = true;
         }
         else
         {
            _standPos.visible = true;
            _mountStandPos.visible = false;
         }
         _showMountShadow = param1;
      }
      
      public function get showMountShadow() : Boolean
      {
         return _showMountShadow;
      }
      
      public function set noShadow(param1:Boolean) : void
      {
         if(_standPos && _mountStandPos)
         {
            if(param1)
            {
               if(_standPos.parent)
               {
                  _standPos.parent.removeChild(_standPos);
               }
               if(_mountStandPos.parent)
               {
                  _mountStandPos.parent.removeChild(_mountStandPos);
               }
            }
            else
            {
               addChildAt(_standPos,0);
               addChildAt(_mountStandPos,0);
            }
         }
         _noShadow = param1;
      }
      
      public function get noShadow() : Boolean
      {
         return _noShadow;
      }
      
      public function set shadowScaleX(param1:Number) : void
      {
         if(_standPos)
         {
            _standPos.scaleX = param1;
         }
      }
      
      public function moveShadow(param1:Number, param2:Number) : void
      {
         if(_standPos)
         {
            _standPos.x = param1;
            _standPos.y = param2;
         }
      }
      
      public function set shadowScaleY(param1:Number) : void
      {
         if(_standPos)
         {
            _standPos.scaleY = param1;
         }
      }
      
      public function get totalFrameY() : int
      {
         return _totalFrameY;
      }
      
      public function set totalFrameY(param1:int) : void
      {
         _totalFrameY = param1;
      }
      
      public function get totalFrameX() : int
      {
         return _totalFrameX;
      }
      
      public function set totalFrameX(param1:int) : void
      {
         _totalFrameX = param1;
      }
      
      public function set sizeType(param1:int) : void
      {
         if(_sizeType == param1)
         {
            return;
         }
         _sizeType = param1;
         _isInit = true;
         if(_bitmap)
         {
            if(_bitmap.bitmapData)
            {
               _bitmap.bitmapData.dispose();
            }
            if(_bitmap.parent)
            {
               _bitmap.parent.removeChild(_bitmap);
            }
            _bitmap.bitmapData = null;
         }
         var _loc2_:Object = sizeMax[sizeType];
         _loc2_ = sizeMax[1];
         _loc2_ || (_loc2_);
         size.setTo(_loc2_.width,_loc2_.height);
         _bitmap.x = _loc2_.x;
         _bitmap.y = _loc2_.y;
         _unitWidth = _loc2_.width;
         _unitHeight = _loc2_.height;
         _drawRect = new Rectangle(0,0,_unitWidth,_unitHeight);
         _clearRect = new Rectangle(0,0,_unitWidth,_unitHeight);
         addChild(_bitmap);
         dispatchEvent(new Event("sizeTypeChange"));
      }
      
      public function get sizeType() : int
      {
         return _sizeType;
      }
      
      public function get contentBitmap() : Bitmap
      {
         return _bitmap;
      }
      
      public function get frameX() : int
      {
         return _frameX;
      }
      
      public function set frameX(param1:int) : void
      {
         _frameX = param1;
      }
      
      public function get frameY() : int
      {
         return _frameY;
      }
      
      public function set frameY(param1:int) : void
      {
         _frameY = param1;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
      }
      
      protected function initBitmapData() : void
      {
      }
      
      public function removeAllAvatar() : void
      {
      }
      
      public function removeAvatar(param1:String) : void
      {
      }
      
      public function updateAvatar(param1:String, param2:Array, param3:Array, param4:String, param5:Function = null, param6:int = 1, param7:int = -1, param8:int = -1) : void
      {
      }
      
      public function run() : void
      {
         if(_isStop)
         {
            return;
         }
         draw();
         nextFrameX();
      }
      
      public function stop() : void
      {
         _isStop = true;
      }
      
      public function play() : void
      {
         _isStop = false;
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function set state(param1:int) : void
      {
         _state = param1;
      }
      
      public function set angle(param1:Number) : void
      {
         _angle = param1;
      }
      
      public function get angle() : Number
      {
         return _angle;
      }
      
      public function isReverse() : Boolean
      {
         return _face;
      }
      
      protected function draw() : void
      {
         if(!_isInit)
         {
            return;
         }
         switch(_state - 1)
         {
            case 0:
               drawJump();
               break;
            case 1:
               drawAttack();
               break;
            case 2:
               drawStand();
               break;
            case 3:
               darwWalk();
         }
      }
      
      public function nextFramePrepare() : void
      {
         if(!_isInit)
         {
            return;
         }
         switch(_state - 1)
         {
            case 0:
               drawJumpPrepare();
               break;
            case 1:
               drawAttackPrepare();
               break;
            case 2:
               drawStandPrepare();
               break;
            case 3:
               darwWalkPrepare();
         }
      }
      
      protected function darwWalkPrepare() : void
      {
      }
      
      protected function drawStandPrepare() : void
      {
      }
      
      protected function drawJumpPrepare() : void
      {
      }
      
      protected function drawAttackPrepare() : void
      {
      }
      
      protected function drawStand() : void
      {
      }
      
      protected function nextFrameX() : void
      {
         _frameX = _frameX + 1;
      }
      
      protected function darwWalk() : void
      {
      }
      
      protected function drawJump() : void
      {
      }
      
      protected function drawAttack() : void
      {
      }
      
      public function dispose() : void
      {
         if(_standPos)
         {
            _standPos.bitmapData = null;
            if(_standPos.parent)
            {
               _standPos.parent.removeChild(_standPos);
            }
         }
         _standPos = null;
         if(_mountStandPos)
         {
            _mountStandPos.bitmapData = null;
            if(_mountStandPos.parent)
            {
               _mountStandPos.parent.removeChild(_mountStandPos);
            }
         }
         _mountStandPos = null;
         if(_bitmap)
         {
            if(_bitmap.bitmapData && _cleanBitmapData)
            {
               _bitmap.bitmapData.dispose();
            }
            if(_bitmap.parent)
            {
               _bitmap.parent.removeChild(_bitmap);
            }
         }
         _clearRect = null;
         _bitmap = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      public function get body() : String
      {
         return _body;
      }
      
      public function set body(param1:String) : void
      {
         _body = param1;
      }
      
      public function get isRending() : Boolean
      {
         return _isRending;
      }
      
      public function set isRending(param1:Boolean) : void
      {
         _isRending = param1;
         if(_bitmap)
         {
            _bitmap.visible = param1;
         }
      }
   }
}

