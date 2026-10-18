package yishi.view.newGuildHelp
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   
   public class NewGuildItem extends Sprite implements Disposeable
   {
      
      private static const WIDTH:int = 215;
      
      private var _arrowImage:ScaleFrameImage;
      
      private var _contentImage:ScaleBitmapImage;
      
      private var _describeText:FilterFrameText;
      
      private var _stepText:FilterFrameText;
      
      private var _content:String;
      
      private var _width:int;
      
      private var _isShow:Boolean;
      
      private var _step:String;
      
      private var _lineType:int;
      
      private var _curItemData:XML;
      
      private var _frameName:String;
      
      public function NewGuildItem(param1:String)
      {
         super();
         _frameName = param1;
         initView();
      }
      
      private function initView() : void
      {
         if(_frameName == "treasuremap.NewGuildFrame")
         {
            _arrowImage = ComponentFactory.Instance.creatComponentByStylename("core.commonArrowImage2");
            _stepText = ComponentFactory.Instance.creatComponentByStylename("core.newGuildFrame.stepText");
         }
         else
         {
            _arrowImage = ComponentFactory.Instance.creatComponentByStylename("core.commonlineImage");
         }
         _contentImage = ComponentFactory.Instance.creatComponentByStylename("core.commonTipBg");
         _describeText = ComponentFactory.Instance.creatComponentByStylename("core.SimpleHelpText");
         if(_arrowImage)
         {
            addChild(_arrowImage);
         }
         if(_contentImage)
         {
            addChild(_contentImage);
         }
         if(_describeText)
         {
            addChild(_describeText);
         }
         if(_stepText)
         {
            addChild(_stepText);
         }
      }
      
      public function set data(param1:XML) : void
      {
         if(_curItemData == param1)
         {
            return;
         }
         _curItemData = param1;
         _isShow = _curItemData.@isShow;
         _arrowImage.rotation = _curItemData.@angle;
         _content = _curItemData.@content;
         _step = _curItemData.@stepTxt;
         _width = _curItemData.@width;
         _lineType = _curItemData.@lineType;
         _describeText.htmlText = LanguageMgr.GetTranslation(_content);
         if(_step != "")
         {
            _stepText.text = LanguageMgr.GetTranslation(_step);
         }
         setPosition();
      }
      
      private function setPosition() : void
      {
         _arrowImage.setFrame(_lineType);
         _contentImage.x = _curItemData.@x;
         _contentImage.y = _curItemData.@y;
         _arrowImage.x = _curItemData.@ax;
         _arrowImage.y = _curItemData.@ay;
         _describeText.width = _width == 0 ? 215 : _width;
         _describeText.height = _describeText.textHeight + 6;
         _contentImage.width = _describeText.width + 10;
         _contentImage.height = _describeText.height + 10;
         _describeText.x = _contentImage.x + 5;
         _describeText.y = _contentImage.y + 5;
         if(_stepText)
         {
            _stepText.x = _arrowImage.x + 30;
            _stepText.y = _arrowImage.y + 20;
         }
      }
      
      private function clean() : void
      {
         if(_arrowImage)
         {
            ObjectUtils.disposeObject(_arrowImage);
         }
         _arrowImage = null;
         if(_contentImage)
         {
            ObjectUtils.disposeObject(_contentImage);
         }
         _contentImage = null;
         if(_describeText)
         {
            ObjectUtils.disposeObject(_describeText);
         }
         _describeText = null;
         if(_stepText)
         {
            ObjectUtils.disposeObject(_stepText);
         }
         _stepText = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

