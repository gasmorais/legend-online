package cell.view.playerequip
{
   import com.pickgliss.ui.image.ScaleFrameImage;
   
   public class RunesCell extends PlayerEquipCell
   {
      
      private var _backLock:Boolean;
      
      public function RunesCell()
      {
         super();
         bagType = 2;
      }
      
      public function set lock(param1:Boolean) : void
      {
         _backLock = param1;
         if(param1)
         {
            (_back as ScaleFrameImage).mouseEnabled = (_back as ScaleFrameImage).mouseChildren = true;
            (_back as ScaleFrameImage).setFrame(1);
         }
         else
         {
            (_back as ScaleFrameImage).mouseEnabled = (_back as ScaleFrameImage).mouseChildren = false;
            (_back as ScaleFrameImage).setFrame(2);
         }
      }
      
      public function get lock() : Boolean
      {
         return _backLock;
      }
      
      public function setTipDate(param1:String) : void
      {
         (_back as ScaleFrameImage).tipData = param1;
      }
      
      override public function setFocus() : void
      {
         if(_activeBack && !_backLock)
         {
            _activeBack.visible = true;
            _activeBack.movie.play();
         }
      }
   }
}

