package theseus.war.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class TheseusWarMaxItem extends Sprite
   {
      
      private var _leftBit:Bitmap;
      
      private var _rightBit:Bitmap;
      
      private var _redTxt:FilterFrameText;
      
      private var _titleTxt:GradientText;
      
      public function TheseusWarMaxItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _leftBit = ComponentFactory.Instance.creatBitmap("asset.theseus.warWen1");
         _rightBit = ComponentFactory.Instance.creatBitmap("asset.theseus.warWen2");
         _redTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.MaxredTip");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.MaxTitile");
         addChild(_leftBit);
         addChild(_rightBit);
         addChild(_redTxt);
         addChild(_titleTxt);
      }
      
      public function hideTbg() : void
      {
         _leftBit.visible = _rightBit.visible = false;
      }
      
      public function titleStr(param1:String) : void
      {
         _titleTxt.text = param1;
      }
      
      public function redStr(param1:String) : void
      {
         _redTxt.text = param1;
      }
      
      public function set isShowRedTip(param1:Boolean) : void
      {
         _redTxt.visible = param1;
      }
      
      public function updateTitlePos(param1:int, param2:int) : void
      {
         _titleTxt.x = param1;
         _titleTxt.y = param2;
      }
      
      public function updateRightBitPos(param1:int, param2:int) : void
      {
         _rightBit.x = param1;
         _rightBit.y = param2;
      }
      
      public function updateleftBitPos(param1:int, param2:int) : void
      {
         _leftBit.x = param1;
         _leftBit.y = param2;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_leftBit);
         _leftBit = null;
         ObjectUtils.disposeObject(_rightBit);
         _rightBit = null;
         ObjectUtils.disposeObject(_redTxt);
         _redTxt = null;
         ObjectUtils.disposeObject(_titleTxt);
         _titleTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

