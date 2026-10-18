package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   
   public class WaterTreeTip extends BaseTip
   {
      
      private var _name:FilterFrameText;
      
      private var _contentTxt:FilterFrameText;
      
      private var _line1:ScaleBitmapImage;
      
      public function WaterTreeTip()
      {
         super();
         _name = ComponentFactory.Instance.creatComponentByStylename("tips.BuildNameText");
         _line1 = ComponentFactory.Instance.creatComponentByStylename("tips.HeroTipLine1");
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("tips.BuildEffectText");
         _name.y = 8;
         _line1.y = 34;
         _contentTxt.y = 42;
         addChild(_name);
         addChild(_line1);
         addChild(_contentTxt);
      }
      
      override protected function updateTransform() : void
      {
         if(tipData)
         {
            _line1.width = _bg.displayWidth - 15;
            _contentTxt.width = _bg.displayWidth - 16;
            _name.text = tipData.title;
            _contentTxt.text = tipData.content;
            _contentTxt.height = _contentTxt.textHeight + 10;
            _bg.height = _contentTxt.y + _contentTxt.textHeight + 20;
         }
      }
      
      override public function dispose() : void
      {
         if(_name)
         {
            ObjectUtils.disposeObject(_name);
         }
         _name = null;
         if(_contentTxt)
         {
            ObjectUtils.disposeObject(_contentTxt);
         }
         _contentTxt = null;
         if(_line1)
         {
            ObjectUtils.disposeObject(_line1);
         }
         _line1 = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

