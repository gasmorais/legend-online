package simplegame.roses
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.utils.ClassUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class BombPrtal extends Sprite
   {
      
      private var _bomb:MovieClip;
      
      private var _rotation:Number;
      
      private var _type:int;
      
      public function BombPrtal(param1:int = 8)
      {
         super();
         this.mouseEnabled = this.mouseChildren = false;
         _type = param1;
         switch(_type - 8)
         {
            case 0:
               _bomb = ClassUtils.CreatInstance("asset.chatII.MarryBomb_01") as MovieClip;
               break;
            default:
               _bomb = new MovieClip();
         }
         _bomb.gotoAndPlay(1);
         addChild(_bomb);
         _rotation = Math.random() * 360 - 180;
         _bomb.rotation = _rotation;
         this.x = StageReferance.stageWidth / 2;
         this.y = StageReferance.stageHeight / 2;
         this.mouseEnabled = false;
         this.mouseChildren = false;
      }
      
      public function get currentFrame() : int
      {
         if(_bomb)
         {
            return _bomb.currentFrame;
         }
         return 0;
      }
      
      public function get totalFrames() : int
      {
         if(_bomb)
         {
            return _bomb.totalFrames;
         }
         return 0;
      }
      
      public function play() : void
      {
         if(_bomb)
         {
            _bomb.play();
         }
      }
      
      public function stop() : void
      {
         if(_bomb)
         {
            _bomb.stop();
         }
      }
      
      public function dispose() : void
      {
         if(_bomb)
         {
            _bomb.stop();
            if(_bomb.parent)
            {
               _bomb.parent.removeChild(_bomb);
            }
            _bomb = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

