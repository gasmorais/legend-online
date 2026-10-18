package simplegame.roses
{
   import com.greensock.TweenLite;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   
   public class PetalFlyView extends Sprite implements Disposeable
   {
      
      public const INTERVALTIME:int = 150;
      
      public const FADEOUT_TIME:int = 2000;
      
      private var _timerId:uint;
      
      private var _petalNum:int;
      
      private var _popNum:int;
      
      private var _bombNum:int;
      
      private var _showTime:int;
      
      private var _popProbability:int;
      
      private var _type:int;
      
      private var _petalList:Vector.<FlyPetal>;
      
      private var _popList:Vector.<MovieClip>;
      
      private var _bombList:Vector.<BombPrtal>;
      
      private var _tempPetal:FlyPetal;
      
      private var _tempPetalII:FlyPetal;
      
      private var _tempBomb:BombPrtal;
      
      private var _tempBombII:BombPrtal;
      
      private var _tempPop:MovieClip;
      
      private var _tempPopII:MovieClip;
      
      private var _curPopIndex:int = 1;
      
      private var _maxPopIndex:int = 3;
      
      private var _isDisposing:Boolean = false;
      
      private var _redHeart:MovieClip;
      
      public function PetalFlyView(param1:int, param2:int, param3:int = 1, param4:int = 3, param5:int = 5, param6:int = 0)
      {
         super();
         this.mouseEnabled = this.mouseChildren = false;
         _type = param3;
         _petalNum = param1;
         _showTime = param2 * 1000;
         _popNum = param4;
         _bombNum = param6;
         _popProbability = param5;
         _petalList = new Vector.<FlyPetal>();
         _popList = new Vector.<MovieClip>();
         _bombList = new Vector.<BombPrtal>();
         _timerId = setInterval(update,150);
         addEvent();
      }
      
      private function update() : void
      {
         if(_showTime <= 0 && !_isDisposing)
         {
            dispose();
            return;
         }
         _showTime -= 150;
         addPetal();
         addBomb();
         addPop();
      }
      
      private function addPop() : void
      {
         _tempPop = null;
         if(Math.random() * 100 <= _popProbability)
         {
            if(_popList.length < _popNum)
            {
               _tempPop = createPopEffect();
               _popList.push(_tempPop);
            }
            else
            {
               for each(_tempPop in _popList)
               {
                  if(!_tempPop.parent)
                  {
                     break;
                  }
                  _tempPop = null;
               }
            }
            if(_tempPop)
            {
               switch(_type - 1)
               {
                  case 0:
                  case 1:
                  case 13:
                     _tempPop.x = Math.random() * 300 + StageReferance.stageWidth / 2 - 150;
                     _tempPop.y = Math.random() * 250;
                     break;
                  case 10:
                     _tempPop.x = Math.random() * 1000 + StageReferance.stageWidth / 2 - 500;
                     _tempPop.y = Math.random() * StageReferance.stageHeight / 2;
                     break;
                  default:
                     _tempPop.x = Math.random() * 700 + StageReferance.stageWidth / 2 - 500;
                     _tempPop.y = Math.random() * 300;
               }
               _tempPop.gotoAndPlay(1);
               addChild(_tempPop);
            }
         }
      }
      
      private function addBomb() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _tempBomb = null;
            if(_bombList.length < _bombNum)
            {
               _tempBomb = createBomb();
               _bombList.push(_tempBomb);
            }
            else
            {
               for each(_tempBomb in _bombList)
               {
                  if(!_tempBomb.parent)
                  {
                     break;
                  }
                  _tempBomb = null;
               }
            }
            if(_tempBomb)
            {
               _tempBomb.play();
               addChild(_tempBomb);
            }
            _loc1_++;
         }
      }
      
      private function addPetal() : void
      {
         _tempPetal = null;
         if(_petalList.length < _petalNum)
         {
            _tempPetal = createPetal();
            _petalList.push(_tempPetal);
         }
         else
         {
            for each(_tempPetal in _petalList)
            {
               if(!_tempPetal.parent)
               {
                  break;
               }
               _tempPetal = null;
            }
         }
         if(_tempPetal)
         {
            _tempPetal.x = Math.random() * StageReferance.stageWidth;
            _tempPetal.y = 0;
            _tempPetal.play();
            addChild(_tempPetal);
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("enterFrame",__enterFrameHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("enterFrame",__enterFrameHandler);
      }
      
      private function __enterFrameHandler(param1:Event) : void
      {
         for each(_tempPetalII in _petalList)
         {
            if(_tempPetalII.parent)
            {
               if(_tempPetalII.x > -50 && _tempPetalII.x < StageReferance.stageWidth + 50 && _tempPetalII.y < StageReferance.stageHeight + 50)
               {
                  _tempPetalII.drop();
               }
               else
               {
                  _tempPetalII.stop();
                  if(_tempPetalII.parent)
                  {
                     _tempPetalII.parent.removeChild(_tempPetalII);
                  }
               }
            }
         }
         for each(_tempPopII in _popList)
         {
            if(_tempPopII.parent)
            {
               if(_tempPopII.currentFrame >= _tempPopII.totalFrames && _type != 11)
               {
                  _tempPopII.stop();
                  if(_tempPopII.parent)
                  {
                     _tempPopII.parent.removeChild(_tempPopII);
                  }
               }
            }
         }
         for each(_tempBombII in _bombList)
         {
            if(_tempBombII.parent)
            {
               if(_tempBombII.currentFrame >= _tempBombII.totalFrames)
               {
                  _tempBombII.stop();
                  if(_tempBombII.parent)
                  {
                     _tempBombII.parent.removeChild(_tempBombII);
                  }
               }
            }
         }
      }
      
      private function createPetal() : FlyPetal
      {
         return new FlyPetal(_type);
      }
      
      private function createBomb() : BombPrtal
      {
         return new BombPrtal(_type);
      }
      
      private function createPopEffect() : MovieClip
      {
         var _loc1_:MovieClip = null;
         if(_curPopIndex > _maxPopIndex)
         {
            _curPopIndex = 1;
         }
         switch(_type - 1)
         {
            case 0:
               _loc1_ = ClassUtils.CreatInstance("asset.core.PetalPinkPopEffect") as MovieClip;
               break;
            case 1:
            case 5:
            case 8:
               _loc1_ = ClassUtils.CreatInstance("asset.core.PetalPopEffect") as MovieClip;
               break;
            case 2:
               _maxPopIndex = 3;
               _loc1_ = ClassUtils.CreatInstance("asset.warlords.FireworkStyle" + _curPopIndex) as MovieClip;
               break;
            case 3:
               _loc1_ = ClassUtils.CreatInstance("asset.core.RoseEffect") as MovieClip;
               break;
            case 4:
               _loc1_ = ClassUtils.CreatInstance("asset.warlords.FireworkStyle4") as MovieClip;
               break;
            case 10:
               _maxPopIndex = 4;
               _loc1_ = ClassUtils.CreatInstance("asset.warlords.FireworkMarryTask" + _curPopIndex) as MovieClip;
               break;
            case 13:
               _loc1_ = ClassUtils.CreatInstance("asset.core.PetalSnowSmall") as MovieClip;
               break;
            default:
               _loc1_ = new MovieClip();
         }
         _loc1_.stop();
         _curPopIndex = _curPopIndex + 1;
         return _loc1_;
      }
      
      public function show(param1:Sprite = null) : void
      {
         if(param1)
         {
            param1.addChild(this);
         }
         else
         {
            LayerManager.Instance.addToLayer(this,2,false,false);
         }
         if(_type == 8)
         {
            _redHeart = ClassUtils.CreatInstance("asset.wedding.redHeart") as MovieClip;
            _redHeart.mouseEnabled = false;
            _redHeart.mouseChildren = false;
            _redHeart.x = StageReferance.stageWidth / 2 - _redHeart.width;
            _redHeart.y = StageReferance.stageHeight / 2 - _redHeart.height;
            LayerManager.Instance.addToLayer(_redHeart,2,true,false);
         }
      }
      
      public function dispose() : void
      {
         if(_isDisposing)
         {
            return;
         }
         _isDisposing = true;
         ObjectUtils.disposeViolentMc(_redHeart);
         _redHeart = null;
         TweenLite.to(this,2000 / 1000,{
            "alpha":0,
            "onComplete":disposeCall
         });
      }
      
      private function disposeCall() : void
      {
         TweenLite.killTweensOf(this);
         clearInterval(_timerId);
         removeEvent();
         for each(_tempPetal in _petalList)
         {
            _tempPetal.dispose();
         }
         for each(_tempBomb in _bombList)
         {
            _tempBomb.dispose();
         }
         for each(_tempPop in _popList)
         {
            _tempPop.stop();
            if(_tempPop.parent)
            {
               _tempPop.parent.removeChild(_tempPop);
            }
         }
         if(_petalList)
         {
            _petalList.length = 0;
         }
         _petalList = null;
         if(_popList)
         {
            _popList.length = 0;
         }
         _popList = null;
         _tempPetal = _tempPetalII = null;
         _tempPop = _tempPopII = null;
         _tempBomb = _tempBombII = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

