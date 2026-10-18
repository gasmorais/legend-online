package com.pickgliss.ui.controls.cell
{
   import com.pickgliss.ui.image.ScaleFrameImage;
   import flash.display.Sprite;
   
   public interface ITreeListCell extends ICell
   {
      
      function setCellOverStatus(param1:Boolean) : void;
      
      function setCellSelectStatus(param1:Boolean) : void;
      
      function get arrow() : ScaleFrameImage;
      
      function get container() : Sprite;
   }
}

