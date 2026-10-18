package yishi.view.tips
{
   import yishi.utils.StringHelper;
   
   public class MultipleLineTip extends OneLineTip
   {
      
      public function MultipleLineTip()
      {
         super();
         _contentTxt.wordWrap = true;
         _contentTxt.multiline = true;
      }
      
      public function set contentWidth(param1:Number) : void
      {
         _contentTxt.width = param1;
      }
      
      override protected function updateTransform() : void
      {
         if(_enableHtml)
         {
            _contentTxt.htmlText = StringHelper.trim(String(_data));
         }
         else
         {
            _contentTxt.text = StringHelper.trim(String(_data));
         }
         if(_tipWidth > 0 && _contentTxt.textWidth > _tipWidth - 20)
         {
            _contentTxt.width = _tipWidth - 16;
         }
         _bg.width = _contentTxt.textWidth + 20;
         _bg.height = _contentTxt.height + 8;
         _contentTxt.x = _bg.x + 8;
         _contentTxt.y = _bg.y + 4;
      }
   }
}

