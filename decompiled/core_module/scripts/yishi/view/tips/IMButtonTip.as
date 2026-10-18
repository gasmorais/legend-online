package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import yishi.utils.StringHelper;
   
   public class IMButtonTip extends BaseTip
   {
      
      protected var _enableHtml:Boolean = false;
      
      protected var _contentTxt:FilterFrameText;
      
      public function IMButtonTip()
      {
         super();
      }
      
      public function set enableHtml(param1:Boolean) : void
      {
         _enableHtml = param1;
      }
      
      override protected function init() : void
      {
         super.init();
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("core.IMButtonTipText");
         addChild(_contentTxt);
      }
      
      override protected function updateTransform() : void
      {
         if(String(_data).indexOf("</") >= 0 || _enableHtml)
         {
            _contentTxt.htmlText = StringHelper.trim(String(_data));
         }
         else
         {
            _contentTxt.text = StringHelper.trim(String(_data));
         }
         _bg.width = _contentTxt.width + 4;
         _bg.height = _contentTxt.height + 2;
         _contentTxt.x = _bg.x + 2;
         _contentTxt.y = _bg.y + 1;
      }
      
      override public function dispose() : void
      {
         if(_contentTxt)
         {
            if(_contentTxt.parent)
            {
               _contentTxt.parent.removeChild(_contentTxt);
            }
            _contentTxt.dispose();
         }
         _contentTxt = null;
         super.dispose();
      }
   }
}

