package simplegame.roses
{
   import com.pickgliss.utils.ClassUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class FlyPetal extends Sprite
   {
      
      private var _petal:MovieClip;
      
      private var _xSpeed:int;
      
      private var _ySpeed:int;
      
      private var _rotation:int;
      
      private var _type:int;
      
      public function FlyPetal(param1:int = 1)
      {
         super();
         this.mouseEnabled = this.mouseChildren = false;
         _type = param1;
         switch(_type - 1)
         {
            case 0:
               _petal = ClassUtils.CreatInstance("asset.core.PetalPink") as MovieClip;
               break;
            case 1:
            case 5:
            case 8:
               _petal = ClassUtils.CreatInstance("asset.core.Petal") as MovieClip;
               break;
            case 2:
               _petal = ClassUtils.CreatInstance("asset.warlords.Star") as MovieClip;
               break;
            case 6:
            case 7:
               _petal = ClassUtils.CreatInstance("asset.wedding.flower1") as MovieClip;
               break;
            case 13:
               _petal = ClassUtils.CreatInstance("asset.core.PetalSnowSmall") as MovieClip;
               break;
            case 14:
               _petal = ClassUtils.CreatInstance("asset.common.snow") as MovieClip;
               break;
            default:
               _petal = new MovieClip();
         }
         _petal.gotoAndPlay(int(Math.random() * _petal.totalFrames) + 1);
         addChild(_petal);
         this.scaleX = this.scaleY = Math.random() * 0.3 + 0.8;
         _xSpeed = Math.random() * 4 - 2;
         _ySpeed = Math.random() * 2 + 5;
         _rotation = Math.random() * 10 - 5;
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      public function drop() : void
      {
         this.x += _xSpeed;
         this.y += _ySpeed;
         this.rotation += _rotation;
      }
      
      public function play() : void
      {
         if(_petal)
         {
            _petal.play();
         }
      }
      
      public function stop() : void
      {
         if(_petal)
         {
            _petal.stop();
         }
      }
      
      public function dispose() : void
      {
         if(_petal)
         {
            _petal.stop();
            if(_petal.parent)
            {
               _petal.parent.removeChild(_petal);
            }
            _petal = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

