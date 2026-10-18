package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   
   public class RemainsExploreTip extends BaseTip
   {
      
      private var _titleTxt:FilterFrameText;
      
      private var _contentTxt:FilterFrameText;
      
      private var _line:ScaleBitmapImage;
      
      public function RemainsExploreTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("core.commonTipText");
         _line = ComponentFactory.Instance.creatComponentByStylename("tips.HeroTipLine1");
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("core.commonTipText");
         _titleTxt.x = 10;
         _titleTxt.y = 8;
         _line.x = 5;
         _line.y = 49;
         _contentTxt.x = 10;
         _contentTxt.y = 57;
         addChild(_titleTxt);
         addChild(_line);
         addChild(_contentTxt);
      }
      
      override protected function updateTransform() : void
      {
         if(tipData)
         {
            _titleTxt.text = tipData.title;
            _contentTxt.htmlText = tipData.content;
            _contentTxt.height = _contentTxt.textHeight + 10;
            _contentTxt.width = _contentTxt.textWidth + 10;
            _bg.height = _contentTxt.y + _contentTxt.textHeight + 10;
            _bg.width = _contentTxt.x + _contentTxt.textWidth + 25;
            _line.width = _bg.width - 15;
         }
      }
      
      override public function dispose() : void
      {
         if(_titleTxt)
         {
            ObjectUtils.disposeObject(_titleTxt);
         }
         _titleTxt = null;
         if(_contentTxt)
         {
            ObjectUtils.disposeObject(_contentTxt);
         }
         _contentTxt = null;
         if(_line)
         {
            ObjectUtils.disposeObject(_line);
         }
         _line = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

