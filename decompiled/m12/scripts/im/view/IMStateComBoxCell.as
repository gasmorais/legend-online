package im.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.AbstractTextButton;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import mvc.module.friends.IMStateInfo;
   
   public class IMStateComBoxCell extends AbstractTextButton implements IListCell
   {
      
      private var _frameImage:ScaleFrameImage;
      
      private var _frameImageStyle:String;
      
      private var _data:IMStateInfo;
      
      public function IMStateComBoxCell()
      {
         super();
      }
      
      public function set frameImageStyle(param1:String) : void
      {
         if(_frameImageStyle == param1)
         {
            return;
         }
         _frameImageStyle = param1;
         _frameImage = ComponentFactory.Instance.creat(_frameImageStyle);
      }
      
      public function get frameImage() : ScaleFrameImage
      {
         return _frameImage;
      }
      
      public function get stateId() : int
      {
         if(_data)
         {
            return _data.id;
         }
         return 1;
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
      }
      
      public function getCellValue() : *
      {
         return _data;
      }
      
      public function setCellValue(param1:*) : void
      {
         if(_data == param1)
         {
            return;
         }
         _data = param1 as IMStateInfo;
         if(_data)
         {
            text = _data.name;
            if(_frameImage)
            {
               _frameImage.setFrame(_data.id);
            }
            tipData = _data.name;
         }
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_frameImage)
         {
            addChild(_frameImage);
         }
      }
      
      override public function dispose() : void
      {
         if(_frameImage)
         {
            _frameImage.dispose();
         }
         _frameImage = null;
         _data = null;
         super.dispose();
      }
   }
}

