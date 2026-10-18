package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   
   public class ExtraBufferTips extends BaseTip
   {
      
      private var _title1:FilterFrameText;
      
      private var _content1:FilterFrameText;
      
      private var _title2:FilterFrameText;
      
      private var _content2:FilterFrameText;
      
      private var _splitLine:ScaleBitmapImage;
      
      public function ExtraBufferTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 245;
         _title1 = ComponentFactory.Instance.creatComponentByStylename("tips.ExtraBufferTitle");
         _content1 = ComponentFactory.Instance.creatComponentByStylename("tips.ExtraBufferContent");
         _title2 = ComponentFactory.Instance.creatComponentByStylename("tips.ExtraBufferTitle");
         _content2 = ComponentFactory.Instance.creatComponentByStylename("tips.ExtraBufferContent");
         _splitLine = ComponentFactory.Instance.creatComponentByStylename("tips.TaskTraceLine");
         addChild(_title1);
         addChild(_content1);
      }
      
      override protected function updateTransform() : void
      {
         var _loc1_:int = 0;
         if(tipData)
         {
            _title1.text = tipData["title1"].toString();
            _content1.htmlText = tipData["content1"].toString();
            _content1.height = _content1.textHeight + 5;
            if(tipData.hasOwnProperty("title2") && Boolean(tipData.hasOwnProperty("content2")))
            {
               _title2.text = tipData["title2"].toString();
               _content2.htmlText = tipData["content2"].toString();
               _content2.height = _content2.textHeight + 5;
               _splitLine.y = _content1.y + _content1.height + 5;
               _title2.y = _splitLine.y + 5;
               _content2.y = _title2.y + 18;
               addChild(_title2);
               addChild(_content2);
               addChild(_splitLine);
               _bg.height = _content2.y + _content2.height + 10;
               _loc1_ = _content1.textWidth + 25;
               _loc1_ = int(_content2.textWidth + 25 > _loc1_ ? _content2.textWidth + 25 : _loc1_);
               _bg.width = _loc1_ > 245 ? _loc1_ : 245;
            }
            else
            {
               if(_title2.parent)
               {
                  _title2.parent.removeChild(_title2);
               }
               if(_content2.parent)
               {
                  _content2.parent.removeChild(_content2);
               }
               if(_splitLine.parent)
               {
                  _splitLine.parent.removeChild(_splitLine);
               }
               _bg.height = _content1.y + _content1.height + 10;
               _loc1_ = int(_content1.textWidth);
               _loc1_ = _content1.textWidth > _title1.textWidth ? _content1.textWidth + 20 : _title1.textWidth + 20;
               _bg.width = _loc1_ > 245 ? _loc1_ : 245;
            }
            if(_splitLine)
            {
               _splitLine.width = _bg.width - 3;
            }
         }
      }
      
      override public function dispose() : void
      {
         if(_title1)
         {
            ObjectUtils.disposeObject(_title1);
         }
         _title1 = null;
         if(_content1)
         {
            ObjectUtils.disposeObject(_content1);
         }
         _content1 = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

